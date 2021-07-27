package core.eval;

import core.env.Frame;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;

public class EvalApplication {
    public static boolean isApplication(ASTNode node) {
        return node.getType() == NodeType.LIST && node.getChildrenCount() > 2;
    }
    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        return null;
    }
}
