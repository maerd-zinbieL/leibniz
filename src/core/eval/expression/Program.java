package core.eval.expression;

import parse.ast.ASTNode;

import java.util.ArrayList;
import java.util.List;

public class Program {
    private final List<Expression> expressions;
    public Program() {
        expressions = new ArrayList<>();
    }
    public Program(ASTNode program) {
        expressions = new ArrayList<>();
        for (ASTNode node : program) {
            expressions.add(Expression.evalAST(node));
        }
    }
    public void addExpr(Expression expr) {
        expressions.add(expr);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Expression expr : expressions) {
            sb.append(expr.toString());
            sb.append("\n");
        }
        return sb.toString();
    }
}
