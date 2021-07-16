package core.interpreter.expression;

import java.util.ArrayList;
import java.util.List;

public class Program {
    private final List<Expression> expressions;
    public Program() {
        expressions = new ArrayList<>();
    }
    public void addExpr(Expression expr) {
        expressions.add(expr);
    }
}
