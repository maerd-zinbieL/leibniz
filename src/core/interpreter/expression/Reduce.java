package core.interpreter.expression;

import parse.ast.ASTNode;

public class Reduce {
    private static boolean isReducible(ASTNode node) {
        return Literal.isLiteral(node);
    }
}
