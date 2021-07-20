package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class EvalLambdaTest {

    @Test
    public void isLambda() throws IOException {
        ASTNode node = Parser.parseLine("( lambda (x) (+ x (* x 2) 1))", 1)[0];
        assertTrue(EvalLambda.isLambda(node));

        node = Parser.parseLine("( lambda (x y z) (+ x (* x 2) 1) (what)) ", 1)[0];
        assertFalse(EvalLambda.isLambda(node));
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();
        ASTNode node = Parser.parseLine("(lambda (x) ((lambda (y) (+ x y)) x))", 1)[0];
        SchemeClosure lambda = EvalLambda.eval(node, global);
        assertEquals("( lambda ( x )  ( ( lambda ( y )  ( + x y )  )  x )  ) ", lambda.toString());


        node = Parser.parseLine("(define x (lambda (x y) (+ (* x x) (* y y))))", 1)[0];
        SchemeValue<?> value = Eval.evalExpr(node, global);

        node = Parser.parseLine("x", 1)[0];
        value = Eval.evalExpr(node, global);
        assertEquals("( lambda ( x y )  ( + ( * x x )  ( * y y )  )  ) ",value.toString());

    }
}