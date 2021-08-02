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

        ASTNode node1 = Parser.parseLine("(define x 2)", 1)[0];
        Definition.eval(node1, global);

        ASTNode node2 = Parser.parseLine("(if x x 0)", 1)[0];
        SchemeValue<?> value = If.eval(node2, global);
        assertTrue(value instanceof SchemeNumber);
        assertEquals("2", value.toString());
    }
}