package parse;

import exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class IdentifierTest {
    String[] lines;
    String fileName = "./test-resources/token-id-test0.scm";

    @Before
    public void setUp() throws IOException {
        lines = ReadTestFile.getTestContents(fileName);
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

    }

    @Test
    public void lex() {
        Token<String> token0 = IdentifierToken.lex(lines[0], 1, 0);
        assertEquals("define", token0.getValue());
        assertEquals(7, token0.getEnd());

        Token<String> token1 = IdentifierToken.lex(lines[0], 8, 1);
        assertEquals("he++o", token1.getValue());
        assertEquals(13, token1.getEnd());

        Token<String> token2 = IdentifierToken.lex(lines[1], 8, 1);
        assertEquals("hel.o", token2.getValue());
        assertEquals(13, token2.getEnd());

        Token<String> token3 = IdentifierToken.lex(lines[2], 8, 1);
        assertEquals("....", token3.getValue());
        assertEquals(12, token3.getEnd());

        Token<String> token4 = IdentifierToken.lex(lines[3], 8, 1);
        assertEquals("...", token4.getValue());
        assertEquals(11, token4.getEnd());

        Token<String> token5 = IdentifierToken.lex(lines[4], 8, 1);
        assertEquals("@whatever", token5.getValue());

        Token<String> token6 = IdentifierToken.lex(lines[5], 8, 1);
        assertEquals("+whatever", token6.getValue());

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