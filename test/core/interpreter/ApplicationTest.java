package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.exception.EvalException;
import core.interpreter.expression.Application;
import core.interpreter.expression.Expression;
import core.value.SchemeValue;
import core.value.number.SchemeReal;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class ApplicationTest {

    @Test
    public void isApplication() {
    }

    private Expression parse(String line) throws IOException {
        return Expression.parse(line, 0)[0];
    }
    private SchemeValue<?> eval(String code, Frame env) throws IOException {
        Expression expr = parse(code);
        return expr.eval(env);
    }
    @Test
    public void evalTest() throws IOException {
        Frame global = InitEnv.getInstance();

        String code = "((lambda (a) a) pi)";
        Expression expression = parse(code);
        assertEquals(Application.class, expression.getClass());
        SchemeValue<?> result = expression.eval(global);
        assertEquals(SchemeReal.class, result.getClass());
        assertEquals("3.1415926", result.toString());

        code = "(+ 1 2 3)";
        result = eval(code, global);
        assertEquals("6", result.toString());

        code = "(- 1 2 3)";
        result = eval(code, global);
        assertEquals("-4", result.toString());

        code = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
        eval(code, global);
        code = "(fib 20)";
        result = eval(code, global);
        assertEquals("6765", result.toString());
    }

    @Test(expected = EvalException.class)
    public void evalError1() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "((lambda (a) (a)) pi)";
        ASTNode node = Parser.parseLine(code, 0)[0];
        Expression expression = Expression.ast2Expression(node);
        expression.eval(global);
    }

    @Test(expected = StackOverflowError.class)
    public void evalError2() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(define loop (lambda () (loop)))";
        eval(code, global);

        code = "(loop)";
        eval(code, global);

    }

    @Test
    public void timeTest() throws IOException {
        Frame globalEnv = InitEnv.getInstance();

        String define = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
        String run = "(fib 30)";
        eval(define, globalEnv);

        long startTime = System.currentTimeMillis();
        eval(run, globalEnv);
        long endTime = System.currentTimeMillis();
        System.out.println(endTime - startTime + "ms");
    }
}