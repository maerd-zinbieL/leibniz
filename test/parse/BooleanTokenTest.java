package parse;

import core.exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import parse.token.BooleanToken;
import parse.token.TokenType;

import java.io.IOException;

import static org.junit.Assert.*;

public class BooleanTokenTest {

    String[] lines;
    String fileName = TestUtil.TEST_TOKEN_FILES_PATH + "token-boolean-test0.scm";

    @Before
    public void setUp() throws IOException {
        lines = TestUtil.getTestContents(fileName);
    }

    @After
    public void tearDown() throws IOException {
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
        assertEquals("true", token1.toString());
        assertEquals("false", token2.toString());
//        assertTrue(token1.getSchemeValue().getJavaValue());
//        assertFalse(token2.getSchemeValue().getJavaValue());
        assertEquals(13, token1.getColNum());
        assertEquals(1, token2.getLineNum());
    }

    @Test(expected = LexerException.class)
    public void lexError() {
        BooleanToken.lex(lines[1], 0, 1);
    }
}