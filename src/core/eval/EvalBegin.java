package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;
import parse.ast.NodeType;

import java.io.IOException;

public class EvalBegin {
    private static ASTNode getBeginBody(ASTNode node) {
        ASTNode body = new ASTNode(NodeType.LIST);
        body.addChild(node.getChild(0));
        for (int i = 2; i < node.getChildrenCount(); i++) {
            body.addChild(node.getChild(i));
        }
        return body;
    }

    public static boolean isBegin(ASTNode node) {
        return node.getChild(1).toString().equals("begin");
    }

    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        return EvalSequence.eval(getBeginBody(node), env);
    }

    public static void main(String[] args) throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(begin + ";
        ASTNode node = Parser.parseLine(code, 1)[0];
        SchemeValue<?> result = Eval.evalExpr(node, global);
        System.out.println(result);
    }
}
