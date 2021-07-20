package core.value;

import parse.ast.ASTNode;

public class SchemeQuotation extends SchemeValue<ASTNode> {
    private final ASTNode code;

    public SchemeQuotation(ASTNode code) {
        this.code = code;
    }

    @Override
    public ASTNode getJavaValue() {
        return code;
    }

    @Override
    public String toString() {
        return code.toString();
    }
}
