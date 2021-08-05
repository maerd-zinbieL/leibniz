package core.interpreter.expression;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class CacheTest {
    private ASTNode parse(String code) throws IOException {
        return Parser.parseLine(code, 0)[0];
    }
    private SchemeValue<?> eval(String code, Frame env) throws IOException {
        Expression expr = Expression.ast2Expression(parse(code));
        return expr.eval(env);
    }

    @Test
    public void isCache() throws IOException {
        assertTrue(Cache.isCache(parse("(cache (fib 1))")));
        assertFalse(Cache.isCache(parse("(cache (fib 1) (fib 2))")));
        assertFalse(Cache.isCache(parse("(cache)")));
    }

    @Test(timeout = 1000)
    public void evalTest() throws IOException {
        Frame environment = InitEnv.getInstance();

        String define = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
        eval(define, environment);

        String run = "(cache (fib 45))";
        long startTime = System.currentTimeMillis();
        System.out.println(eval(run, environment));
        long endTime = System.currentTimeMillis();

        System.out.println(endTime - startTime + "ms");
    }
}