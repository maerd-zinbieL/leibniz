package core.interpreter;

import core.env.Frame;
import core.value.SchemeValue;
import core.exception.EvalException;
import parse.ast.ASTNode;


public class Eval {
    public static SchemeValue<?> evalExpr(ASTNode node, Frame env) {
        if (Literal.isLiteral(node)) {
            return Literal.eval(node);
        }
        if (Definition.isDefinition(node)) {
            return Definition.eval(node, env);
        }
        if (Variable.isVariable(node)) {
            return Variable.eval(node, env);
        }
        if (Lambda.isLambda(node)) {
            return Lambda.eval(node, env);
        }
        if (If.isIf(node)) {
            return If.eval(node, env);
        }
        if (Apply.isApplication(node)) {
            return Apply.apply(node, env);
        }
        throw new EvalException("unknown expression type");
    }
}
