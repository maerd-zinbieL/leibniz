package core.value;

import core.env.Frame;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.PunctuatorToken;

public class SchemeClosure extends SchemeValue<ASTNode> {
    private final ASTNode code;
    private final Frame env;

    public SchemeClosure(ASTNode code, Frame env) {
        this.code = code;
        this.env = env;
    }

    public ASTNode getBody() {
        ASTNode body = new ASTNode(NodeType.LIST);
        body.addChild(new ASTNode(new PunctuatorToken("(", -1, -1, -1)));
        body.addChild(code.getChild(3));
        body.addChild(new ASTNode(new PunctuatorToken(")", -1, -1, -1)));
        return body;
    }

    public ASTNode getParameters() {
        return code.getChild(2);
    }

    public Frame getEnv() {
        return env;
    }

    public ASTNode getCode() {
        return code;
    }
    @Override
    public ASTNode getJavaValue() {
        return code;
    }

    @Override
    public String toString() {
        return "#<procedure>";
    }
}
