package core.eval.expression;

import core.value.SchemeValue;
import core.exception.EvalException;
import parse.ast.ASTNode;

public abstract class Expression {
    protected final ASTNode node;
    protected Expression(ASTNode node) {
        if(node == null) {
            throw new IllegalArgumentException();
        }
        this.node = node;
    }
    public static SchemeValue evalAST(ASTNode node) {
        if (Literal.isLiteral(node)) {
            return new Literal(node).eval();
        }
        throw new EvalException("unknown expression type");
    }

    public abstract SchemeValue eval();
    @Override
    public String toString() {
        return node.toString();
    }
}
