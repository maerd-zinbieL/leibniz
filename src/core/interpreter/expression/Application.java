package core.interpreter.expression;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.value.Primitive;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;
import parse.ast.NodeType;

import java.io.IOException;

public class Application implements Expression {
    class ReduceStrategy {
        private boolean calReducibility() {
            // calculate reducibility
            for (Expression expr : argumentsExpr) {
                if (!expr.isReducible()) {
                    return false;
                }
            }
            return operatorExpr.isReducible();
        }

        private SchemeValue<?> reduceCompound(SchemeClosure operator, Frame env, SchemeValue<?>[] arguments) {
            String[] parameters = getAppParameters(operator);

            if (parameters.length != arguments.length) {
                throw new EvalException("incorrect number of arguments to procedure: " + operatorExpr);
            }
            Sequence body = getAppBody(operator);
            Frame appEnv = getAppEnv(parameters, env, arguments);
            Expression resultExpr = body.reduce(appEnv);
            return Expression.getReduceResult(resultExpr, appEnv);
        }

        private SchemeValue<?> reduceOperator(Frame env) {
            Expression operatorExprReduce = operatorExpr;
            while (operatorExprReduce.isReducible()) {
                operatorExprReduce = operatorExprReduce.reduce(env);
            }
            return Expression.getReduceResult(operatorExprReduce, env);
        }

        private SchemeValue<?>[] reduceArguments(Frame env) {
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

        //        private Expression wrapReduceResult(SchemeValue<?> result) {
//            if (result instanceof SchemeClosure) {
//                return new Lambda(result);
//            }
//        }
        private Expression reduce(Frame env) {

            SchemeValue<?> operator = reduceOperator(env);

            SchemeValue<?>[] arguments = reduceArguments(env);

            SchemeValue<?> result;
            if (operator.getClass() == Primitive.class) {
                result = applyPrimitive((Primitive) operator, arguments);
            }
            if (operator.getClass() == SchemeClosure.class) {
                result = reduceCompound((SchemeClosure) operator, env, arguments);
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
            Frame appEnv = getAppEnv(parameters, operator.getEnv(), arguments);
            return body.eval(appEnv);
        }

        public SchemeValue<?> eval(Frame env) {
            SchemeValue<?> operator = operatorExpr.eval(env);
            SchemeValue<?>[] arguments = new SchemeValue[argumentsExpr.length];
            for (int i = 0; i < arguments.length; i++) {
                arguments[i] = argumentsExpr[i].eval(env);
            }

            if (operator.getClass() == Primitive.class) {
                return applyPrimitive((Primitive) operator, arguments);
            }
            if (operator.getClass() == SchemeClosure.class) {
                return evalCompound((SchemeClosure) operator, arguments);
            }
            throw new EvalException(operatorExpr + " is not a procedure");
        }
    }

    private final Expression operatorExpr;
    private final Expression[] argumentsExpr;
    private final ReduceStrategy reduceStrategy;
    private final EvalStrategy evalStrategy;
    // TODO: 2021/8/3 cache result


    public Application(ASTNode app) {
        int childrenCount = app.getChildrenCount();
        argumentsExpr = new Expression[childrenCount - 3];
        for (int i = 2; i < childrenCount - 1; i++) {
            argumentsExpr[i - 2] = Expression.ast2Expression(app.getChild(i));
        }

        operatorExpr = Expression.ast2Expression(app.getChild(1));
        evalStrategy = new EvalStrategy();
        reduceStrategy = new ReduceStrategy();
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

    private Frame getAppEnv(String[] parameters, Frame env, SchemeValue<?>[] arguments) {
        Frame appEnv = new Frame();
        for (int i = 0; i < arguments.length; i++) {
            String varName = parameters[i];
            appEnv.defineVariable(varName, arguments[i]);
        }
        appEnv.setPreFrame(env);
        return appEnv;
    }

    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }

    @Override
    public boolean isReducible() {
        return reduceStrategy.calReducibility();
    }

    @Override
    public Expression reduce(Frame env) {
        return reduceStrategy.reduce(env);
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        return evalStrategy.eval(env);
    }

    private static Expression parse(String line) throws IOException {
        ASTNode node = Parser.parseLine(line, 0)[0];
        return Expression.ast2Expression(node);
    }

    private static SchemeValue<?> eval(String code, Frame env) throws IOException {
        Expression expr = parse(code);
        return expr.eval(env);
    }

    public static void main(String[] args) throws IOException {
        Frame global = InitEnv.getInstance();

    }
}
