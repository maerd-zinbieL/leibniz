package core.eval;

import core.env.Frame;
import core.exception.EvalException;
import core.value.SchemeBoolean;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.token.Token;

public class EvalIf {
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

    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        SchemeValue<?> predicate = Eval.evalExpr(node.getChild(2), env);
        ASTNode consequent = node.getChild(3);
        ASTNode alternative = node.getChild(4);
        if (isTrue(predicate)) {
            return Eval.evalExpr(consequent, env);
        } else {
            return Eval.evalExpr(alternative, env);
        }
    }
}
