package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.value.SchemeValue;
import core.value.number.SchemeReal;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class ApplyTest {

    @Test
    public void isApplication() {
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) a) pi)";
        ASTNode astNode = Parser.parseLine(code, 0)[0];
        SchemeValue<?> result = Eval.evalExpr(astNode, global);
        assertEquals(SchemeReal.class, result.getClass());
        assertEquals("3.1415926", result.toString());


        code = "(+ 1 2 3)";
        astNode = Parser.parseLine(code, 0)[0];
        result = Eval.evalExpr(astNode, global);
        assertEquals("6", result.toString());

        code = "(- 1 2 3)";
        astNode = Parser.parseLine(code, 0)[0];
        result = Eval.evalExpr(astNode, global);
        assertEquals("-4", result.toString());

        code = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
        astNode = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(astNode, global);
        code = "(fib 20)";
        astNode = Parser.parseLine(code, 0)[0];
        assertEquals("6765", Eval.evalExpr(astNode, global).toString());
    }

    @Test(expected = EvalException.class)
    public void evalError1() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) (a)) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);
    }

    @Test(expected = StackOverflowError.class)
    public void evalError2() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(define loop (lambda () (loop)))";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);

        code = "(loop)";
        node = Parser.parseLine(code, 0)[0];
        Eval.evalExpr(node, global);
    }

    @Test
    public void timeTest() throws IOException {
        String code = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))" +
                      "(fib 30)";
        ASTNode define = Parser.parseLine(code, 0)[0];
        ASTNode run = Parser.parseLine(code, 0)[1];

        Frame globalEnv = InitEnv.getInstance();
        Eval.evalExpr(define, globalEnv);

        long startTime = System.currentTimeMillis();
        Eval.evalExpr(run, globalEnv);
        long endTime = System.currentTimeMillis();
        System.out.println(endTime - startTime + "ms");
    }
}