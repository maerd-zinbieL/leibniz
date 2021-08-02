package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class SequenceTest {

    @Test (expected = EvalException.class)
    public void evalError1() throws IOException {
        String code = "pi";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Frame env = InitEnv.getInstance();
        Sequence.eval(node, env);

    }

    @Test
    public void eval() throws IOException {
        String code = "(pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Frame env = InitEnv.getInstance();
        assertEquals("3.1415926", Sequence.eval(node, env).toString());
    }
}