package core.interpreter.expression;

import parse.ASTNode;

public abstract class Expression {
    private final ASTNode node;
    protected Expression(ASTNode node) {
        if(node == null) {
            throw new IllegalArgumentException();
        }
        this.node = node;
    }
    public abstract Expression eval();
}
