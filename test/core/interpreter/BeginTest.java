package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.interpreter.expression.Begin;
import core.interpreter.expression.Expression;
import core.value.number.SchemeReal;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class BeginTest {
    @Test
    public void isBegin() throws IOException {
        String code = "(begin)";
        ASTNode node = Parser.parseLine(code, 1)[0];
        assertTrue(Begin.isBegin(node));

         code = "(x begin)";
         node = Parser.parseLine(code, 1)[0];
        assertFalse(Begin.isBegin(node));

        code = "( begin 1)";
        node = Parser.parseLine(code, 1)[0];
        assertTrue(Begin.isBegin(node));
    }

    @Test (expected = EvalException.class)
    public void evalError0() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(begin)";
        ASTNode node = Parser.parseLine(code, 1)[0];
        Expression expr = new Begin(node);
        expr.eval(global);
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();
        global.defineVariable("pi", new SchemeReal(3.1415926));

        String code = "(begin 1 2 3)";
        ASTNode node = Parser.parseLine(code, 1)[0];
        Expression expr = Expression.ast2Expression(node);

        assertEquals(3.0, expr.eval(global).getJavaValue());

        code = "(begin pi)";
        node = Parser.parseLine(code, 1)[0];
        expr = Expression.ast2Expression(node);

        assertEquals("3.1415926", expr.eval(global).toString());
    }

}