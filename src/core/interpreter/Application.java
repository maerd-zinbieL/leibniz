package core.interpreter;

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
    private final Expression operatorExpr;
    private final Expression[] argumentsExpr;

    public Application(ASTNode app) {
        argumentsExpr = getArgumentsExpr(app);
        operatorExpr = Expression.ast2Expression(app.getChild(1));
    }

    private Expression[] getArgumentsExpr(ASTNode app) {
        int childrenCount = app.getChildrenCount();
        Expression[] arguments = new Expression[childrenCount - 3];
        for (int i = 2; i < childrenCount - 1; i++) {
            arguments[i - 2] = Expression.ast2Expression(app.getChild(i));
        }
        return arguments;
    }

    private SchemeValue<?>[] evalArguments(Frame env) {
        SchemeValue<?>[] arguments = new SchemeValue[argumentsExpr.length];
        for (int i = 0; i < arguments.length; i++) {
            arguments[i] = argumentsExpr[i].eval(env);
        }
        return arguments;
    }

    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }

    private String[] getParameters(SchemeClosure closure) {
        ASTNode parameterNode = closure.getParameters();
        String[] parameters = new String[parameterNode.getChildrenCount() - 2];
        for (int i = 0; i < parameters.length; i++) {
            parameters[i] = parameterNode.getChild(i + 1).toString();
        }
        return parameters;
    }

    private SchemeValue<?> applyPrimitive(Primitive operator, Frame env) {
        SchemeValue<?>[] arguments = evalArguments(env);
        return operator.apply(arguments);
    }

    private SchemeValue<?> applyCompound(SchemeClosure operator, Frame env) {
        String[] parameters = getParameters(operator);
        SchemeValue<?>[] arguments = evalArguments(env);
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
    public SchemeValue<?> eval(Frame env) {
        SchemeValue<?> operator = operatorExpr.eval(env);
        if (operator.getClass() == Primitive.class) {
            return applyPrimitive((Primitive) operator, env);
        }
        if (operator.getClass() == SchemeClosure.class) {
            return applyCompound((SchemeClosure) operator, env);
        }
        throw new EvalException(operatorExpr + " is not a procedure");
    }

    public static void main(String[] args) throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) a) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Expression expr = Expression.ast2Expression(node);
        assert expr.getClass() == Application.class;
        System.out.println(expr.eval(global));
    }

}
