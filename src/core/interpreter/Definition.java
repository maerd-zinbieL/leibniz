package core.interpreter;

import core.env.Frame;
import core.value.SchemeUnspecific;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.Token;
import parse.token.TokenType;

public class Definition {

    public static boolean isDefinition(ASTNode node) {
        if (node.getType() == NodeType.LIST ) {
            ASTNode first = node.getChild(1);
            return  first.isLeaf() &&
                    first.getToken().getType() == TokenType.Identifier &&
                    first.toString().equals("define");
        }
        return false;
    }

    public static SchemeUnspecific eval(ASTNode node, Frame env) {
        // TODO: 2021/7/20 lambda

        Token variable = node.getChild(2).getToken();
        SchemeValue<?> value = Eval.evalExpr(node.getChild(3), env);
        env.defineVariable(variable.toString(), value);
        return new SchemeUnspecific();
    }

    public static boolean isReducible() {
        return false;
    }
}