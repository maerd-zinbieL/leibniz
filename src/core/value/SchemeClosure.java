package core.value;

import core.env.Frame;
import parse.ast.ASTNode;

public class SchemeClosure extends SchemeValue<ASTNode> {
    private final ASTNode code;
    private final Frame env;

    public SchemeClosure(ASTNode code, Frame env) {
        this.code = code;
        this.env = env;
    }

    public ASTNode getBody() {
        return code.getChild(3);
    }

    public ASTNode getParameters() {
        return code.getChild(2);
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
