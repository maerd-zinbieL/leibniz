package core.interpreter;

import core.env.Frame;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.token.TokenType;

public class Variable {
    public static boolean isVariable(ASTNode node) {
        return node.isLeaf()&&
                node.getToken().getType() == TokenType.Identifier;
    }
    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        String varName = node.getToken().toString();
        return env.lookUpVariable(varName);
    }
}
