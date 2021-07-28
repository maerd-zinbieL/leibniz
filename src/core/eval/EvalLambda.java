package core.eval;

import core.env.Frame;
import core.value.SchemeClosure;
import parse.ast.ASTNode;
import parse.ast.NodeType;

public class EvalLambda {
    public static boolean isLambda(ASTNode node) {
        return node.getType() == NodeType.LIST &&
                node.getChildrenCount() == 5 &&
                node.getChild(1).isLeaf() &&
                node.getChild(1).toString().equals("lambda") &&
                node.getChild(2).getType() == NodeType.LIST;
    }

    public static SchemeClosure eval(ASTNode node, Frame env) {
        return new SchemeClosure(node, env);
    }
}
