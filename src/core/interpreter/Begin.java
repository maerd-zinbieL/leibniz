package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;
import parse.ast.NodeType;

import java.io.IOException;

public class Begin {
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
        return Sequence.eval(getBeginBody(node), env);
    }

    public static boolean isReducible() {
        return false;
    }

}
