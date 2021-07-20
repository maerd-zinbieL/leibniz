package core.eval;

import core.env.Frame;
import core.value.SchemeIdentifier;
import core.value.SchemeUnspecific;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.Token;
import parse.token.TokenType;

public class EvalDefinition {

    public static boolean isDefinition(ASTNode node) {
        if (node.getType() == NodeType.LIST ) {
            Token first = node.getFirstChild().getToken();
            return first.getType() == TokenType.Identifier &&
                    first.toString().equals("define");
        }
        return false;
    }
    public static SchemeUnspecific eval(ASTNode node, Frame env) {
        // TODO: 2021/7/20 lambda

        Token variable = node.nextChild().nextChild().getToken();
        SchemeValue<?> value = node.nextChild().getToken().getSchemeValue();
        env.defineVariable(variable.toString(), value);
        return new SchemeUnspecific();
    }
}
