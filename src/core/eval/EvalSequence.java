package core.eval;

import core.env.Frame;
import core.exception.EvalException;
import core.value.SchemeNil;
import core.value.SchemeValue;
import parse.ast.ASTNode;

class EvalSequence {
    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        int childrenCount = node.getChildrenCount();
        if (childrenCount < 2) {
            throw new EvalException("not a sequence");
        }
        if (childrenCount == 2) {
            // '()
            return new SchemeNil();
        }
        for (int i = 1; i < childrenCount - 2; i++) {
            Eval.evalExpr(node.getChild(i), env);
        }
        return Eval.evalExpr(node.getChild(childrenCount - 2), env);
    }
}
