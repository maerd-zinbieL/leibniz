package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import core.exception.EvalException;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

public class Eval {

    public SchemeValue<?> evalAST(ASTNode node, Frame env) {
        if (EvalLiteral.isLiteral(node)) {
            return EvalLiteral.eval(node);
        }
        if (EvalDefinition.isDefinition(node)) {
            return EvalDefinition.eval(node, env);
        }
        if (EvalVariable.isVariable(node)) {
            return EvalVariable.eval(node, env);
        }
        throw new EvalException("unknown expression type");
    }
}
