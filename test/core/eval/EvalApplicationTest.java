package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.value.SchemeValue;
import core.value.number.SchemeNumber;
import core.value.number.SchemeReal;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class EvalApplicationTest {

    @Test
    public void isApplication() {
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) a) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        SchemeValue<?> result = Eval.evalExpr(node, global);
        assertEquals(SchemeReal.class, result.getClass());
        assertEquals("3.1415926", result.toString());
    }

    @Test(expected = EvalException.class)
    public void evalError1() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) (a)) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);
    }

    @Test (expected = StackOverflowError.class)
    public void evalError2() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(define loop (lambda () (loop)))";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);

        code = "(loop)";
        node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);
    }
}