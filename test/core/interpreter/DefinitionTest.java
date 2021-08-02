package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class DefinitionTest {

    @Test
    public void isDefinition() throws IOException {
        ASTNode node = Parser.parseLine("(define x 10)", 1)[0];
        assertTrue(Definition.isDefinition(node));
    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();

        ASTNode node1 = Parser.parseLine("(define x 10)", 1)[0];
        Definition.eval(node1, global);
        assertEquals("10",
                Variable.eval(
                        Parser.parseLine("x", 1)[0], global).toString()
        );

        ASTNode node2 = Parser.parseLine("(define y x)", 1)[0];
        Definition.eval(node2, global);
        assertEquals("10", Variable.eval(
                Parser.parseLine("y", 2)[0], global).toString()
        );

    }
}