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

    private Expression parse(String line) throws IOException {
        ASTNode node = Parser.parseLine(line, 0)[0];
        return Expression.ast2Expression(node);
    }

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
        Expression expr = parse(line);
        SchemeValue<?> lambda = expr.eval(global);
        assertEquals("( lambda ( x )  ( ( lambda ( y )  ( + x y )  )  x )  ) ", lambda.toString());


        line = "(define x (lambda (x y) (+ (* x x) (* y y))))";
        expr = parse(line);
        expr.eval(global);
        expr = parse("x");
        assertEquals("( lambda ( x y )  ( + ( * x x )  ( * y y )  )  ) ", expr.eval(global).toString());

        expr = parse("(lambda (x) x) ");
        assertEquals("( lambda ( x )  x ) ", expr.eval(global).toString());
    }
}