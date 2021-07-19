package parse;

import core.exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import parse.token.IdentifierToken;
import parse.token.Token;

import java.io.IOException;

import static org.junit.Assert.*;

public class IdentifierTest {
    String[] lines;
    String fileName = TestUtil.TEST_TOKEN_FILES_PATH + "token-id-test0.scm";

    @Before
    public void setUp() throws IOException {
        lines = TestUtil.getTestContents(fileName);
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void isIdentifier() {
        assertTrue(IdentifierToken.isIdentifier(lines[0], 1));
        assertTrue(IdentifierToken.isIdentifier(lines[0], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[1], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[2], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[3], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[4], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[5], 8));
        assertFalse(IdentifierToken.isIdentifier(lines[6], 8));
        assertFalse(IdentifierToken.isIdentifier(lines[7], 8));
        assertTrue(IdentifierToken.isIdentifier(lines[8], 10));
    }

    @Test
    public void lex() {
        Token token0 = IdentifierToken.lex(lines[0], 1, 0);
        assertEquals("define", token0.getSchemeValue().toString());
        assertEquals(7, token0.getEnd());

        Token token1 = IdentifierToken.lex(lines[0], 8, 1);
        assertEquals("he++o", token1.getSchemeValue().toString());
        assertEquals(13, token1.getEnd());

        Token token2 = IdentifierToken.lex(lines[1], 8, 1);
        assertEquals("hel.o", token2.getSchemeValue().toString());
        assertEquals(13, token2.getEnd());

        Token token3 = IdentifierToken.lex(lines[2], 8, 1);
        assertEquals("....", token3.getSchemeValue().toString());
        assertEquals(12, token3.getEnd());

        Token token4 = IdentifierToken.lex(lines[3], 8, 1);
        assertEquals("...", token4.getSchemeValue().toString());
        assertEquals(11, token4.getEnd());

        Token token5 = IdentifierToken.lex(lines[4], 8, 1);
        assertEquals("@whatever", token5.getSchemeValue().toString());

        Token token6 = IdentifierToken.lex(lines[5], 8, 1);
        assertEquals("+whatever", token6.getSchemeValue().toString());

        Token token7 = IdentifierToken.lex(lines[8], 10, 1);
        assertEquals("y", token7.getSchemeValue().toString());

    }

    @Test(expected = LexerException.class)
    public void lexError1() {
        IdentifierToken.lex(lines[6], 8, 1);
    }

    @Test(expected = LexerException.class)
    public void lexError2() {
        IdentifierToken.lex(lines[7], 8, 1);
    }
}