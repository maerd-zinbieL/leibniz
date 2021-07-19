package core.eval.expression;

import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.TokenType;

public class Literal extends Expression {

    protected Literal(ASTNode node) {
        super(node);
    }

    @Override
    public Expression eval() {
        return this;
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
