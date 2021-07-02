package parse;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class BooleanTokenTest {

    String[] lines;

    @Before
    public void setUp() {
        lines = new String[]{
                "(define true #t) (define false #f)",
                "(define (square x) (* x x))",
                "whatever#t"
        };
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void getEnd() {
        BooleanToken token1 = BooleanToken.lex(lines[0], 13, 1);
        BooleanToken token2 = BooleanToken.lex(lines[0], 31, 1);
        assertEquals(15, token1.getEnd());
        assertEquals(33, token2.getEnd());

    }
    @Test
    public void isBoolean() {
        assertTrue(BooleanToken.isBoolean(lines[0], 13));
        assertTrue(BooleanToken.isBoolean(lines[0], 31));
        assertFalse(BooleanToken.isBoolean(lines[1], 0));
        assertTrue(BooleanToken.isBoolean(lines[2], 8));
    }

    @Test
    public void lex() {
        BooleanToken token1 = BooleanToken.lex(lines[0], 13, 1);
        BooleanToken token2 = BooleanToken.lex(lines[0], 31, 1);
        assertEquals(TokenType.Boolean, token1.getType());
        assertTrue(token1.getValue());
        assertFalse(token2.getValue());
        assertEquals(13, token1.getColNum());
        assertEquals(1, token2.getLineNum());
    }

    @Test(expected = IllegalArgumentException.class)
    public void lexError() {
        BooleanToken.lex(lines[1], 0, 1);
    }
}