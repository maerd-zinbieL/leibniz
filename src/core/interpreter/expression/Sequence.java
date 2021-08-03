package core.interpreter.expression;

import core.env.Frame;
import core.exception.EvalException;
import core.value.SchemeNil;
import core.value.SchemeValue;
import parse.ast.ASTNode;


public class Sequence implements Expression {

    private final Expression[] expressions;

    public Sequence(Expression[] expressions) {
        this.expressions = expressions;
    }

    public Sequence(ASTNode node) {
        int childrenCount = node.getChildrenCount();
        if (childrenCount < 2) {
            throw new EvalException("not a sequence");
        }
        expressions = new Expression[childrenCount - 2];
        for (int i = 1; i < childrenCount - 1; i++) {
            expressions[i - 1] = Expression.ast2Expression(node.getChild(i));
        }

    }

    public int getLength() {
        return expressions.length;
    }

    @Override
    public boolean isReducible() {
        return true;
    }

    @Override
    public Expression reduce(Frame env) {
        Expression expr = null;
        for (Expression expression : expressions) {
            expr = expression;
            while (expr.isReducible()) {
                expr = expr.reduce(env);
            }
        }
        return expr;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        int exprCount = expressions.length;
        if (exprCount == 0) {
            return new SchemeNil();
        }
        for (int i = 0; i < exprCount - 1; i++) {
            expressions[i].eval(env);
        }
        return expressions[exprCount - 1].eval(env);
    }

}
