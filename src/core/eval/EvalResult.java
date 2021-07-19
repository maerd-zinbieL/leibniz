package core.eval;

import core.eval.expression.Expression;

import java.util.ArrayList;
import java.util.List;

public class EvalResult {
    private final List<Expression> result;

    public EvalResult() {
        result = new ArrayList<>();
    }

    public void addExpr(Expression expr) {
        result.add(expr);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Expression expr : result) {
            sb.append(expr.toString());
            sb.append("\n");
        }
        return sb.toString();
    }
}
