package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.interpreter.expression.Expression;
import core.interpreter.expression.If;
import core.value.SchemeValue;
import core.value.number.SchemeNumber;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class IfTest {

    private Expression parse(String line) throws IOException {
        ASTNode node = Parser.parseLine(line, 0)[0];
        return Expression.ast2Expression(node);
    }

    @Test
    public void isIf() throws IOException {
        ASTNode node = Parser.parseLine("(if (= x 0) x (+ x y))", 1)[0];
        assertTrue(If.isIf(node));
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();

        ASTNode node = Parser.parseLine("(define x 2)", 1)[0];
        Expression expr = Expression.ast2Expression(node);
        expr.eval(global);

        expr = parse("(if x x 0)");
        SchemeValue<?> value = expr.eval(global);
        assertTrue(value instanceof SchemeNumber);
        assertEquals("2", value.toString());

        expr = parse("(if (if (if #f 1 #f) 1 2) 999 0)");
        assertEquals("999", expr.eval(global).toString());
    }

    @Test
    public void reduce() throws IOException {
        Frame global = InitEnv.getInstance();

        ASTNode node = Parser.parseLine("(if (if (if #t #t #f) #f #t) 1 0)", 1)[0];
        Expression expr = Expression.ast2Expression(node);
        expr = expr.reduce(global);
        assertTrue(Expression.isFinalReduceState(expr));
        assertEquals("0", expr.eval(global).toString());
    }
}