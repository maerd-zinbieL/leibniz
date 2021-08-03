package core.interpreter.expression;

import core.env.Frame;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.token.TokenType;

public class Variable implements Expression {
    private final String varName;

    public Variable(ASTNode node) {
        varName = node.getToken().toString();
    }

    public static boolean isVariable(ASTNode node) {
        return node.isLeaf() &&
                node.getToken().getType() == TokenType.Identifier;
    }

    @Override
    public boolean isReducible() {
        return false;
    }

    @Override
    public Expression reduce(Frame env) {
        return null;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        return env.lookUpVariable(varName);
    }

}
