package core.interpreter.expression;


import core.env.Frame;
import core.exception.EvalException;
import core.exception.ReduceException;
import core.value.SchemeValue;
import parse.ast.ASTNode;


public interface Expression {

    static boolean isFinalReduceState(Expression expression) {
        return !expression.isReducible() &&
                expression instanceof Literal ||
                expression instanceof Definition ||
                expression instanceof Lambda ||
                expression instanceof Application ||
                expression instanceof Variable;
    }

    static SchemeValue<?> getReduceResult(Expression expression, Frame env) {
        if (!isFinalReduceState(expression)) {
            throw new ReduceException("bad reduce");
        }
        return expression.eval(env);
    }

    static Expression ast2Expression(ASTNode node) {
        if (Literal.isLiteral(node)) {
            return new Literal(node);
        }
        if (Definition.isDefinition(node)) {
            return new Definition(node);
        }
        if (Variable.isVariable(node)) {
            return new Variable(node);
        }
        if (Lambda.isLambda(node)) {
            return new Lambda(node);
        }
        if (If.isIf(node)) {
            return new If(node);
        }
        if(Begin.isBegin(node)) {
            return new Begin(node);
        }
        if (Fast.isFast(node)) {
            return new Fast(node);
        }
        if (Application.isApplication(node)) {
            return new Application(node);
        }
        throw new EvalException("unknown expression type");
    }

    boolean isReducible();

    Expression reduce(Frame env);

    SchemeValue<?> eval(Frame env);
}
