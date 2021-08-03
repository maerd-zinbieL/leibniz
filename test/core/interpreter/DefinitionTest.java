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
    private Expression parse(String line) throws IOException {
        ASTNode node = Parser.parseLine(line, 0)[0];
        return Expression.ast2Expression(node);
    }

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

        Expression expr = parse("(define x 10)");
        expr.eval(global);

        expr = parse("x");
        assertEquals(Variable.class, expr.getClass());
        assertEquals("10", expr.eval(global).toString());

        expr = parse("(define y x)");
        expr.eval(global);
        expr = parse("y");
        assertEquals("10", expr.eval(global).toString());

    }
}