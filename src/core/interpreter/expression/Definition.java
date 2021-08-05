package core.interpreter.expression;

import core.env.Frame;
import core.value.SchemeUnspecific;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.TokenType;

public class Definition implements Expression {

    private final String variableName;
    private final Expression valueExpr;

    public Definition(ASTNode node) {
        // TODO: 2021/7/20 lambda

        variableName = node.getChild(2).getToken().toString();
        valueExpr = Expression.ast2Expression(node.getChild(3));
    }

    public static boolean isDefinition(ASTNode node) {
        if (node.getType() == NodeType.LIST) {
            ASTNode first = node.getChild(1);
            return first.isLeaf() &&
                    first.getToken().getType() == TokenType.Identifier &&
                    first.toString().equals("define");
        }
        return false;
    }

    @Override
    public boolean isReducible() {
        return valueExpr.isReducible();
    }

    @Override
    public Expression reduce(Frame env) {
        Expression expr = valueExpr;
        while (expr.isReducible()) {
            expr.reduce(env);
        }
        return expr;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        SchemeValue<?> value = valueExpr.eval(env);
        env.defineVariable(variableName, value);
        return new SchemeUnspecific();
    }
}
