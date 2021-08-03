package core.interpreter;

import core.env.Frame;
import core.value.SchemeBoolean;
import core.value.SchemeValue;
import parse.ast.ASTNode;

public class If implements Expression{
    private final Expression predicateExpr;
    private final Expression consequentExpr;
    private final Expression alternativeExpr;
    public If(ASTNode node) {
        predicateExpr = Expression.ast2Expression(node.getChild(2));
        consequentExpr = Expression.ast2Expression(node.getChild(3));
        alternativeExpr = Expression.ast2Expression(node.getChild(4));
    }
    private static boolean isTrue(SchemeValue<?> value) {
        if (!(value instanceof SchemeBoolean))
            return true;
        return ((SchemeBoolean) value).getJavaValue();
    }

    public static boolean isIf(ASTNode node) {
        return node.getChildrenCount() == 6 &&
                node.getChild(1).isLeaf() &&
                node.getChild(1).getToken().toString().equals("if");
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        if (isTrue(predicateExpr.eval(env))) {
            return consequentExpr.eval(env);
        }else {
            return alternativeExpr.eval(env);
        }
    }
}
