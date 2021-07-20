package core.eval;

import core.env.Frame;
import core.value.SchemeQuotation;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.TokenType;

public class EvalLiteral {

    public static SchemeValue<?> eval(ASTNode node) {
        if (node.getType() == NodeType.QUOTE) {
            return new SchemeQuotation(node);
        }
        return node.getToken().getSchemeValue();
    }

    public static boolean isLiteral(ASTNode node) {
        if (node.getType() == NodeType.QUOTE) {
            return true;
        }
        if (node.getType() == NodeType.SIMPLE ) {
            TokenType type = node.getToken().getType();
            return type == TokenType.Boolean ||
                    type == TokenType.Number||
                    type == TokenType.Character ||
                    type == TokenType.String;
        }
        return false;
    }

}
