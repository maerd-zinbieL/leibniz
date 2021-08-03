package core.interpreter;

import core.env.Frame;
import core.exception.ReduceException;
import core.interpreter.expression.Expression;
import core.value.SchemeValue;

import static core.interpreter.expression.Expression.isFinalReduceState;

public class Reduce {
    // TODO: 2021/8/3 test

//    public static SchemeValue<?> getResult(Expression expression, Frame env) {
//
//        if (!isFinalReduceState(expression)) {
//            throw new ReduceException("bad reduce");
//        }
//        return expression.eval(env);
//    }
}
