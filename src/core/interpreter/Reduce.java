package core.interpreter;

import core.env.Frame;
import core.value.SchemeValue;
import parse.ast.ASTNode;

public class Reduce {
    private static boolean isReducible(ASTNode node) {
        return Literal.isLiteral(node);
    }
}
