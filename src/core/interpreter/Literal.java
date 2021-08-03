package core.interpreter;

import core.env.Frame;
import core.value.SchemeQuotation;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.TokenType;

public class Literal implements Expression {
    private final SchemeValue<?> schemeValue;

    public Literal(ASTNode node) {
        if (node.getType() == NodeType.QUOTE) {
            schemeValue = new SchemeQuotation(node);
        } else {
            schemeValue = node.getToken().getSchemeValue();
        }
    }

    public static boolean isLiteral(ASTNode node) {
        if (node.getType() == NodeType.QUOTE) {
            return true;
        }
        if (node.getType() == NodeType.SIMPLE) {
            TokenType type = node.getToken().getType();
            return type == TokenType.Boolean ||
                    type == TokenType.Number ||
                    type == TokenType.Character ||
                    type == TokenType.String;
        }
        return false;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        return schemeValue;
    }
}
