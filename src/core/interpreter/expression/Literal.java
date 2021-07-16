package core.interpreter.expression;

import parse.ASTNode;

public class Literal extends Expression{

    protected Literal(ASTNode node) {
        super(node);
    }

    @Override
    public Expression eval() {
        return null;
    }
}
