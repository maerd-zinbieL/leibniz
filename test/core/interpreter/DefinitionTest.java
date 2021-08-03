package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.interpreter.expression.Definition;
import core.interpreter.expression.Expression;
import core.interpreter.expression.Variable;
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

        node = Parser.parseLine("x", 1)[0];
        assertFalse(Definition.isDefinition(node));

    }

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();

        Expression expr = Expression.parse("(define x 10)", 1)[0];
        expr.eval(global);

        expr = Expression.parse("x", 2)[0];
        assertEquals(Variable.class, expr.getClass());
        assertEquals("10",expr.eval(global).toString());

        expr = Expression.parse("(define y x)", 3)[0];
        expr.eval(global);
        expr = Expression.parse("y", 4)[0];
        assertEquals("10", expr.eval(global).toString());

    }
}