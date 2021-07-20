package core.value;

import parse.ast.ASTNode;

public class SchemeQuotation extends SchemeValue<ASTNode> {
    private final ASTNode node;

    public SchemeQuotation(ASTNode node) {
        this.node = node;
    }

    @Override
    public ASTNode getJavaValue() {
        return node;
    }

    @Override
    public String toString() {
        return node.toString();
    }
}
