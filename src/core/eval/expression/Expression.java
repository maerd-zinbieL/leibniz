package core.eval.expression;

import exception.EvalException;
import parse.ast.ASTNode;

public abstract class Expression {
    protected final ASTNode node;
    protected Expression(ASTNode node) {
        if(node == null) {
            throw new IllegalArgumentException();
        }
        this.node = node;
    }
    public static Expression evalAST(ASTNode node) {
        if (Literal.isLiteral(node)) {
            return new Literal(node);
        }
        throw new EvalException("unknown expression type");
    }

    public abstract Expression eval();
    @Override
    public String toString() {
        return node.toString();
    }
}
