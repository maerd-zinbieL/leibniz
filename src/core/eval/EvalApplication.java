package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;
import parse.ast.NodeType;

import java.io.IOException;

public class EvalApplication {
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
        String[]  parameters = new String[parameterNode.getChildrenCount()-2];
        for (int i = 0; i < parameters.length; i++) {
            parameters[i] = parameterNode.getChild(i+1).toString();
        }
        return parameters;
    }
    public static SchemeValue<?> eval(ASTNode app, Frame env) {
        ASTNode operatorNode = app.getChild(1);
        SchemeValue<?> operator = Eval.evalExpr(operatorNode, env);
        if (operator.getClass() != SchemeClosure.class) {
            throw new EvalException(operatorNode.toString() + " is not a procedure");
        }
        ASTNode body = ((SchemeClosure) operator).getBody();
        String[] parameters = getParameters((SchemeClosure) operator);
        SchemeValue<?>[] arguments = getArguments(app, env);
        if (parameters.length  != arguments.length) {
            throw new EvalException("incorrect number of arguments to procedure: "
                    + operatorNode.toString());
        }
        Frame appEnv = new Frame();
        for (int i = 0; i < arguments.length; i++) {
            String varName = parameters[i];
            appEnv.defineVariable(varName, arguments[i]);
        }
        appEnv.setPreFrame(env);
        return EvalSequence.eval(body, appEnv);
    }

    public static void main(String[] args) throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) (a)) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        System.out.println(Eval.evalExpr(node, global));
    }
}
