package core.interpreter.expression;


import core.env.Frame;
import core.exception.EvalException;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

public interface Expression {
    static Expression[] parse(String line, int lineNum) throws IOException {
        ASTNode[] nodes = Parser.parseLine(line, lineNum);
        Expression[] expressions = new Expression[nodes.length];
        for (int i = 0; i < nodes.length; i++) {
            expressions[i] = ast2Expression(nodes[i]);
        }
        return expressions;
    }

    static Expression ast2Expression(ASTNode node) {
        if (Literal.isLiteral(node)) {
            return new Literal(node);
        }
        if (Definition.isDefinition(node)) {
            return new Definition(node);
        }
        if (Variable.isVariable(node)) {
            return new Variable(node);
        }
        if (Lambda.isLambda(node)) {
            return new Lambda(node);
        }
        if (If.isIf(node)) {
            return new If(node);
        }
        if (Application.isApplication(node)) {
            return new Application(node);
        }
        throw new EvalException("unknown expression type");
    }

    SchemeValue<?> eval(Frame env);
}
