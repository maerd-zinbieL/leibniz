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

public class Apply {
    private static SchemeValue<?>[] getArguments(ASTNode app, Frame env) {
        int childrenCount = app.getChildrenCount();
        SchemeValue<?>[] arguments = new SchemeValue<?>[childrenCount - 3];
        for (int i = 2; i < childrenCount - 1; i++) {
            arguments[i - 2] = (Eval.evalExpr(app.getChild(i), env));
        }
        return arguments;
    }

    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }

    private static String[] getParameters(SchemeClosure closure) {
        ASTNode parameterNode = closure.getParameters();
        String[] parameters = new String[parameterNode.getChildrenCount() - 2];
        for (int i = 0; i < parameters.length; i++) {
            parameters[i] = parameterNode.getChild(i + 1).toString();
        }
        return parameters;
    }

    private static SchemeValue<?> applyPrimitive(Primitive operator, ASTNode app, Frame env) {
        SchemeValue<?>[] arguments = getArguments(app, env);
        return operator.apply(arguments);
    }

    private static SchemeValue<?> applyCompound(SchemeClosure operator, ASTNode app, Frame env) {
        String[] parameters = getParameters(operator);
        SchemeValue<?>[] arguments = getArguments(app, env);
        if (parameters.length != arguments.length) {
            throw new EvalException("incorrect number of arguments to procedure: "
                    + app.getChild(1).toString());
        }
        ASTNode body = operator.getBody();

        Frame appEnv = new Frame();
        for (int i = 0; i < arguments.length; i++) {
            String varName = parameters[i];
            appEnv.defineVariable(varName, arguments[i]);
        }
        appEnv.setPreFrame(env);
        return Sequence.eval(body, appEnv);
    }

    public static SchemeValue<?> apply(ASTNode app, Frame env) {
        SchemeValue<?> operator = Eval.evalExpr(app.getChild(1), env);
        if (operator.getClass() == Primitive.class) {
            return applyPrimitive((Primitive) operator, app, env);
        }
        if (operator.getClass() == SchemeClosure.class) {
            return applyCompound((SchemeClosure) operator, app, env);
        }
        throw new EvalException(app.getChild(1).toString() + " is not a procedure");
    }

    public static void main(String[] args) throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) (a)) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        System.out.println(Eval.evalExpr(node, global));
    }
}
