package core.interpreter.expression;

import core.env.Frame;
import core.exception.EvalException;
import core.interpreter.Cache;
import core.value.Primitive;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;

public class Application implements Expression {
    private final Expression operatorExpr;
    private final Expression[] argumentsExpr;
    private final ReduceStrategy reduceStrategy;
    private final EvalStrategy evalStrategy;
    private final SchemeValue<?> result;
    private static final Cache cache = new Cache();

    public Application(SchemeValue<?> result) {
        operatorExpr = null;
        argumentsExpr = null;
        reduceStrategy = null;
        evalStrategy = null;
        this.result = result;
    }

    public Application(ASTNode app) {
        int childrenCount = app.getChildrenCount();
        argumentsExpr = new Expression[childrenCount - 3];
        for (int i = 2; i < childrenCount - 1; i++) {
            argumentsExpr[i - 2] = Expression.ast2Expression(app.getChild(i));
        }
        operatorExpr = Expression.ast2Expression(app.getChild(1));
        evalStrategy = new EvalStrategy();
        reduceStrategy = new ReduceStrategy();
        result = null;
    }

    class ReduceStrategy {

        private SchemeValue<?> reduceCompound(SchemeClosure operator, SchemeValue<?>[] arguments) {
            String[] parameters = getAppParameters(operator);

            if (parameters.length != arguments.length) {
                throw new EvalException("incorrect number of arguments to procedure: " + operatorExpr);
            }
            Sequence body = getAppBody(operator);
            Frame appEnv = getAppEnv(parameters, operator, arguments);
            Expression resultExpr = body.reduce(appEnv);
            return Expression.getReduceResult(resultExpr, appEnv);
        }

        private SchemeValue<?> reduceOperator(Frame env) {
            assert operatorExpr != null;
            Expression operatorExprReduce = operatorExpr;
            while (operatorExprReduce.isReducible()) {
                operatorExprReduce = operatorExprReduce.reduce(env);
            }
            return Expression.getReduceResult(operatorExprReduce, env);
        }

        private SchemeValue<?>[] reduceArguments(Frame env) {
            assert argumentsExpr != null;
            Expression[] argumentsExprReduce = new Expression[argumentsExpr.length];
            Expression expr;
            for (int i = 0; i < argumentsExprReduce.length; i++) {
                expr = argumentsExpr[i];
                while (expr.isReducible()) {
                    expr = expr.reduce(env);
                }
                argumentsExprReduce[i] = expr;
            }
            SchemeValue<?>[] arguments = new SchemeValue[argumentsExpr.length];
            for (int i = 0; i < arguments.length; i++) {
                arguments[i] = Expression.getReduceResult(argumentsExprReduce[i], env);
            }
            return arguments;
        }

        private Expression reduce(Frame env) {

            SchemeValue<?> operator = reduceOperator(env);

            SchemeValue<?>[] arguments = reduceArguments(env);

            SchemeValue<?> reduceResult;
            if (operator.getClass() == Primitive.class) {
                reduceResult = applyPrimitive((Primitive) operator, arguments);
                return new Application(reduceResult);
            }
            if (operator.getClass() == SchemeClosure.class) {
                reduceResult = reduceCompound((SchemeClosure) operator, arguments);
                return new Application(reduceResult);
            }
            throw new EvalException(operatorExpr + " is not a procedure");
        }
    }

    class EvalStrategy {
        private SchemeValue<?> evalCompound(SchemeClosure operator, SchemeValue<?>[] arguments) {
            String[] parameters = getAppParameters(operator);

            if (parameters.length != arguments.length) {
                throw new EvalException("incorrect number of arguments to procedure: " + operatorExpr);
            }
            Sequence body = getAppBody(operator);
            Frame appEnv = getAppEnv(parameters, operator, arguments);
            SchemeValue<?> evalResult = body.eval(appEnv);
            cache.cacheResult(arguments, operator, evalResult);
            return evalResult;
        }

        private SchemeValue<?>[] evalAppArguments(Frame env) {
            assert argumentsExpr != null;
            SchemeValue<?>[] arguments = new SchemeValue[argumentsExpr.length];
            for (int i = 0; i < arguments.length; i++) {
                arguments[i] = argumentsExpr[i].eval(env);
            }
            return arguments;
        }

        public SchemeValue<?> eval(Frame env) {
            assert operatorExpr != null && argumentsExpr != null;
            SchemeValue<?> operator = operatorExpr.eval(env);
            SchemeValue<?>[] arguments = evalAppArguments(env);

            if (operator.getClass() == Primitive.class) {
                return applyPrimitive((Primitive) operator, arguments);
            }
            if (operator.getClass() == SchemeClosure.class) {
                SchemeValue<?> evalResult = cache.getResult(arguments, (SchemeClosure) operator);
                if (evalResult != null) {
                    return evalResult;
                } else {
                    return evalCompound((SchemeClosure) operator, arguments);
                }
            }

            throw new EvalException(operatorExpr + " is not a procedure");
        }
    }

    private SchemeValue<?> applyPrimitive(Primitive operator, SchemeValue<?>[] arguments) {
        return operator.apply(arguments);
    }

    private String[] getAppParameters(SchemeClosure operator) {
        ASTNode parameterNode = operator.getParameters();
        String[] parameters = new String[parameterNode.getChildrenCount() - 2];
        for (int i = 0; i < parameters.length; i++) {
            parameters[i] = parameterNode.getChild(i + 1).toString();
        }
        return parameters;
    }

    private Sequence getAppBody(SchemeClosure operator) {
        return new Sequence(operator.getBody());
    }

    private Frame getAppEnv(String[] parameters, SchemeClosure operator, SchemeValue<?>[] arguments) {
        Frame appEnv = new Frame();
        for (int i = 0; i < arguments.length; i++) {
            String varName = parameters[i];
            appEnv.defineVariable(varName, arguments[i]);
        }
        appEnv.setPreFrame(operator.getEnv());
        return appEnv;
    }

    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }

    @Override
    public boolean isReducible() {
        return result == null;
    }

    @Override
    public Expression reduce(Frame env) {
        return reduceStrategy.reduce(env);
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        if (result == null)
            return evalStrategy.eval(env);
        else
            return result;
    }
}
