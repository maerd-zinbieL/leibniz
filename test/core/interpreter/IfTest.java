package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import core.value.number.SchemeNumber;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class IfTest {

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

        node = Parser.parseLine("(if x x 0)", 1)[0];
        expr = Expression.ast2Expression(node);
        SchemeValue<?> value = expr.eval(global);
        assertTrue(value instanceof SchemeNumber);
        assertEquals("2", value.toString());

        expr = Expression.parse("(if (if (if #f 1 #f) 1 2) 999 0)", 1)[0];
        assertEquals("999", expr.eval(global).toString());
    }
}