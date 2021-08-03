package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.interpreter.expression.Expression;
import core.interpreter.expression.Sequence;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class SequenceTest {

    @Test(expected = EvalException.class)
    public void evalError1() throws IOException {
        String code = "pi";
        ASTNode node = Parser.parseLine(code, 0)[0];
        new Sequence(node);

    }

    @Test
    public void eval() throws IOException {
        Frame env = InitEnv.getInstance();

        String code = "(pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Expression expr = new Sequence(node);
        assertEquals("3.1415926", expr.eval(env).toString());
    }

    @Test
    public void testEval() throws IOException {
        Frame env = InitEnv.getInstance();

        String code = "(pi 1 2 3)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Expression expr = new Sequence(node);
        assertEquals("3", expr.eval(env).toString());
    }

    @Test
    public void reduce() throws IOException {
        Frame global = InitEnv.getInstance();
        Sequence sequence = new Sequence(Parser.parseLine("(1 2 3 pi)", 1)[0]);
        Expression expression = sequence.reduce(global);
        assertTrue(Expression.isFinalReduceState(expression));
        assertEquals("3.1415926", expression.eval(global).toString());
    }
}