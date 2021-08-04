package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.interpreter.expression.Expression;
import core.interpreter.expression.Lambda;
import core.value.SchemeClosure;
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
        String actual = ((SchemeClosure) lambda).getCode().toString();
        assertEquals("( lambda ( x )  ( ( lambda ( y )  ( + x y )  )  x )  ) ", actual);


        line = "(define x (lambda (x y) (+ (* x x) (* y y))))";
        expr = parse(line);
        expr.eval(global);
        expr = parse("x");
        lambda = expr.eval(global);
        actual = ((SchemeClosure) lambda).getCode().toString();
        assertEquals("( lambda ( x y )  ( + ( * x x )  ( * y y )  )  ) ", actual);

        expr = parse("(lambda (x) x) ");
        lambda = expr.eval(global);
        actual = ((SchemeClosure) lambda).getCode().toString();
        assertEquals("( lambda ( x )  x ) ", actual);
    }
}