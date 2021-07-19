package parse;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import parse.token.PunctuatorToken;
import parse.token.Token;

import static org.junit.Assert.*;

public class PunctuatorTest {
    String[] lines;
    String fileName = TestUtil.TEST_TOKEN_FILES_PATH + "token-punctuator-test0.scm";

    @Before
    public void setUp() throws Exception {
        lines = TestUtil.getTestContents(fileName);
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void isPunctuator() {
        assertTrue(PunctuatorToken.isPunctuator(lines[0], 0));
        assertFalse(PunctuatorToken.isPunctuator(lines[0], 1));
        assertTrue(PunctuatorToken.isPunctuator(lines[0], 12));

        assertTrue(PunctuatorToken.isPunctuator(lines[1], 0));
        assertTrue(PunctuatorToken.isPunctuator(lines[2], 0));
        assertTrue(PunctuatorToken.isPunctuator(lines[3], 8));
        assertTrue(PunctuatorToken.isPunctuator(lines[4], 0));
        assertTrue(PunctuatorToken.isPunctuator(lines[3], 20));
        assertTrue(PunctuatorToken.isPunctuator(lines[4], 6));
        assertFalse(PunctuatorToken.isPunctuator(lines[4], 7));
        assertTrue(PunctuatorToken.isPunctuator(lines[5], 0));
        assertTrue(PunctuatorToken.isPunctuator(lines[6], 0));

    }

    @Test
    public void lex() {
        Token token1 = PunctuatorToken.lex(lines[0], 0, 2);
        assertEquals(2, token1.getLineNum());
        assertEquals(0, token1.getColNum());
        assertEquals("(", token1.getSchemeValue().toString());
        assertEquals(1, token1.getEnd());

        Token token2 = PunctuatorToken.lex(lines[0], 12, 1);
        assertEquals(")", token2.getSchemeValue().toString());
        assertEquals(13, token2.getEnd());

        Token token3 = PunctuatorToken.lex(lines[1], 0, 1);
        assertEquals("#(", token3.getSchemeValue().toString());
        assertEquals(2, token3.getEnd());

        Token token4 = PunctuatorToken.lex(lines[2], 0, 1);
        assertEquals("'", token4.getSchemeValue().toString());

        Token token5 = PunctuatorToken.lex(lines[3], 8, 1);
        assertEquals("`", token5.getSchemeValue().toString());

        Token token6 = PunctuatorToken.lex(lines[4], 6, 1);
        assertEquals(",@", token6.getSchemeValue().toString());

        Token token7 = PunctuatorToken.lex(lines[5], 0, 5);
        assertEquals("(", token7.getSchemeValue().toString());

        Token token8 = PunctuatorToken.lex(lines[5], 6, 5);
        assertEquals(")", token8.getSchemeValue().toString());

        Token token9 = PunctuatorToken.lex(lines[6], 0, 6);
        assertEquals(".", token9.toString());

    }
}