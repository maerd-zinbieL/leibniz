package core.interpreter;

import core.env.Frame;
import core.exception.EvalException;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;


public class Begin implements Expression {
    private final Sequence body;

    public Begin(ASTNode node) {
        Expression[] expressions = new Expression[node.getChildrenCount() - 3];

        for (int i = 0; i < expressions.length; i++) {
            expressions[i] = Expression.ast2Expression(node.getChild(i + 2));
        }
        body = new Sequence(expressions);
    }

    public static boolean isBegin(ASTNode node) {
        return node.getType() == NodeType.LIST &&
                node.getChildrenCount() >= 3 &&
                node.getChild(1).toString().equals("begin");
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        if (body.getLength() == 0) {
            //(begin) 不合法
            throw new EvalException("begin: bad syntax");
        }
        return body.eval(env);
    }

}
