package core.eval;

import core.env.Frame;
import core.env.InitEnv;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class EvalDefinitionTest {

    @Test
    public void isDefinition() throws IOException {
        ASTNode node = Parser.parseLine("(define x 10)", 1)[0];
        assertTrue(EvalDefinition.isDefinition(node));
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();

        ASTNode node1 = Parser.parseLine("(define x 10)", 1)[0];
        EvalDefinition.eval(node1, global);
        assertEquals("10",
                EvalVariable.eval(
                        Parser.parseLine("x", 1)[0], global).toString()
        );

        ASTNode node2 = Parser.parseLine("(define y x)", 1)[0];
        EvalDefinition.eval(node2, global);
        assertEquals("10", EvalVariable.eval(
                Parser.parseLine("y", 2)[0], global).toString()
        );

    }
}