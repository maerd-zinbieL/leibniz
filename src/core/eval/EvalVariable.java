package core.eval;

import core.env.Frame;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.TokenType;

public class EvalVariable {
    public static boolean isVariable(ASTNode node) {
        return node.isLeaf()&&
                node.getToken().getType() == TokenType.Identifier;
    }
    public static SchemeValue<?> eval(ASTNode node, Frame env) {
        String varName = node.getToken().toString();
        return env.lookUpVariable(varName);
    }
}
