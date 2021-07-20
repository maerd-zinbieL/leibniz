package core.eval;

import core.env.Frame;
import core.value.SchemeValue;
import core.exception.EvalException;
import parse.ast.ASTNode;


public class Eval {
    public static SchemeValue<?> evalExpr(ASTNode node, Frame env) {
        if (EvalLiteral.isLiteral(node)) {
            return EvalLiteral.eval(node);
        }
        if (EvalDefinition.isDefinition(node)) {
            return EvalDefinition.eval(node, env);
        }
        if (EvalVariable.isVariable(node)) {
            return EvalVariable.eval(node, env);
        }
        if (EvalLambda.isLambda(node)) {
            return EvalLambda.eval(node, env);
        }
        throw new EvalException("unknown expression type");
    }
}
