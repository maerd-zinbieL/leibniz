package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.interpreter.expression.Expression;
import core.interpreter.expression.Lambda;
import core.value.SchemeValue;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class LambdaTest {

    @Test
    public void isLambda() throws IOException {
        ASTNode node = Parser.parseLine("( lambda (x) (+ x (* x 2) 1))", 1)[0];
        assertTrue(Lambda.isLambda(node));

        node = Parser.parseLine("( lambda (x y z) (+ x (* x 2) 1) (what)) ", 1)[0];
        assertFalse(Lambda.isLambda(node));

        node = Parser.parseLine("(lambda (x) x) ", 1)[0];
        assertTrue(Lambda.isLambda(node));
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();

        String line = "(lambda (x) ((lambda (y) (+ x y)) x))";
        Expression expr = Expression.parse(line, 1)[0];
        SchemeValue<?> lambda = expr.eval(global);
        assertEquals("( lambda ( x )  ( ( lambda ( y )  ( + x y )  )  x )  ) ", lambda.toString());


        line = "(define x (lambda (x y) (+ (* x x) (* y y))))";
        expr = Expression.parse(line, 1)[0];
        expr.eval(global);
        expr = Expression.parse("x", 2)[0];
        assertEquals("( lambda ( x y )  ( + ( * x x )  ( * y y )  )  ) ", expr.eval(global).toString());

        expr = Expression.parse("(lambda (x) x) ", 1)[0];
        assertEquals("( lambda ( x )  x ) ", expr.eval(global).toString());
    }
}