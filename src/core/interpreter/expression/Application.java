package core.interpreter.expression;

import core.env.Frame;
import core.exception.EvalException;
import core.value.Primitive;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;

public class Application implements Expression {
    private final Expression operatorExpr;
    private final Expression[] argumentsExpr;
    private boolean isReducible;

    // TODO: 2021/8/3 cache result

    public Application(Expression operatorExpr, Expression[] argumentsExpr) {
        // reduced
        this.operatorExpr = operatorExpr;
        this.argumentsExpr = argumentsExpr;
        isReducible = false;
    }


    public Application(ASTNode app) {
        int childrenCount = app.getChildrenCount();
        argumentsExpr = new Expression[childrenCount - 3];
        for (int i = 2; i < childrenCount - 1; i++) {
            argumentsExpr[i - 2] = Expression.ast2Expression(app.getChild(i));
        }

        operatorExpr = Expression.ast2Expression(app.getChild(1));

        isReducible = calReducibility();
    }

    private boolean calReducibility() {
        // calculate reducibility
        for (Expression expr : argumentsExpr) {
            if (!expr.isReducible()) {
                return false;
            }
        }
        return operatorExpr.isReducible();
    }

    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }

    private SchemeValue<?> applyPrimitive(Primitive operator, SchemeValue<?>[] arguments) {
        return operator.apply(arguments);
    }

    private String[] getParameters(SchemeClosure closure) {
        ASTNode parameterNode = closure.getParameters();
        String[] parameters = new String[parameterNode.getChildrenCount() - 2];
        for (int i = 0; i < parameters.length; i++) {
            parameters[i] = parameterNode.getChild(i + 1).toString();
        }
        return parameters;
    }

    private SchemeValue<?> applyCompound(SchemeClosure operator, Frame env, SchemeValue<?>[] arguments) {
        String[] parameters = getParameters(operator);
        if (parameters.length != arguments.length) {
            throw new EvalException("incorrect number of arguments to procedure: "
                    + operatorExpr.toString());
        }
        Sequence body = new Sequence(operator.getBody());

        Frame appEnv = new Frame();
        for (int i = 0; i < arguments.length; i++) {
            String varName = parameters[i];
            appEnv.defineVariable(varName, arguments[i]);
        }
        appEnv.setPreFrame(env);
        return body.eval(appEnv);
    }

    @Override
    public boolean isReducible() {
        return isReducible;
    }

    @Override
    public Expression reduce(Frame env) {
        Expression[] arguments = new Expression[argumentsExpr.length];
        Expression expr;
        for (int i = 0; i < arguments.length; i++) {
            expr = argumentsExpr[i];
            while (expr.isReducible()) {
                expr = expr.reduce(env);
            }
            arguments[i] = expr;
        }

        Expression operatorExprReduce = operatorExpr;
        while (operatorExprReduce.isReducible()) {
            operatorExprReduce = operatorExprReduce.reduce(env);
        }
        return new Application(operatorExprReduce, arguments);
    }
//    public SchemeValue<?> getReduceResult(Frame env) {
//
//    }

    @Override
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
            return applyCompound((SchemeClosure) operator, env, arguments);
        }
        throw new EvalException(operatorExpr + " is not a procedure");
    }

}
