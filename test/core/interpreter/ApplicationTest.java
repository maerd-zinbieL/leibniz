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

import static org.junit.Assert.assertEquals;

public class ApplicationTest {

    @Test
    public void isApplication() {
    }

    private Expression parse(String line) throws IOException {
        ASTNode node = Parser.parseLine(line, 0)[0];
        return Expression.ast2Expression(node);
    }

    private SchemeValue<?> eval(String code, Frame env) throws IOException {
        Expression expr = parse(code);
        return expr.eval(env);
    }

    @Test
    public void evalTest() throws IOException {
        Frame global = InitEnv.getInstance();
        String code;
        SchemeValue<?> result;

        code = "((lambda (a) a) pi)";
        Expression expression = parse(code);
        assertEquals(Application.class, expression.getClass());
        result = expression.eval(global);
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

        eval("(define add (lambda (x) (lambda (y) (+ x y))))", global);
        eval("(define inc-1 (add 1))", global);
        result = eval("(inc-1 9)", global);
        assertEquals("10", result.toString());

        eval("(define add (lambda (x) (lambda (y) (lambda (z) (+ x y z)))))", global);
        eval("(define inc-1 (add 1))", global);
        eval("(define inc-3 (inc-1 2))", global);

        result = eval("(inc-3 10)", global);
        assertEquals("13", result.toString());

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
        Frame environment = InitEnv.getInstance();

        String define = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
        eval(define, environment);

        String run = "(fib 45)";
        long startTime = System.currentTimeMillis();
        System.out.println(eval(run, environment));
        long endTime = System.currentTimeMillis();

        System.out.println(endTime - startTime + "ms");
    }
}