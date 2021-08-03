package core.interpreter;

import core.env.Frame;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;

public class Lambda implements Expression {
    private final ASTNode node;

    public Lambda(ASTNode node) {
        this.node = node;
    }

    public static boolean isLambda(ASTNode node) {
        return node.getType() == NodeType.LIST &&
                node.getChildrenCount() == 5 &&
                node.getChild(1).isLeaf() &&
                node.getChild(1).toString().equals("lambda") &&
                node.getChild(2).getType() == NodeType.LIST;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        return new SchemeClosure(node, env);
    }
}
