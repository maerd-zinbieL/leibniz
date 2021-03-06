package parse;

import core.exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import parse.token.CharToken;

import java.io.IOException;

import static org.junit.Assert.*;

public class CharTokenTest {

    String[] lines;
    String fileName = TestUtil.TEST_TOKEN_FILES_PATH + "token-char-test0.scm";
    final char SPACE = 32;
    final char NEWLINE = 10;
    @Before
    public void setUp() throws IOException {
        lines = TestUtil.getTestContents(fileName);
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void isCharacter() {
        assertTrue(CharToken.isCharacter(lines[0], 8));
        assertTrue(CharToken.isCharacter(lines[1], 8));
        assertFalse(CharToken.isCharacter(lines[2], 8));
        assertFalse(CharToken.isCharacter(lines[3], 8));
        assertTrue(CharToken.isCharacter(lines[4], 8));
        assertFalse(CharToken.isCharacter(lines[5], 0));
        assertTrue(CharToken.isCharacter(lines[6], 0));
        assertTrue(CharToken.isCharacter(lines[7], 0));
    }

    @Test
    public void lex() {
        CharToken token1 = CharToken.lex(lines[0], 8, 1);
        assertEquals(15, token1.getEnd());
        assertEquals(SPACE, (char)token1.getSchemeValue().getJavaValue());
        assertEquals(8, token1.getColNum());

        CharToken token2 = CharToken.lex(lines[1], 8, 2);
        assertEquals(17, token2.getEnd());
        assertEquals(NEWLINE, (char) token2.getSchemeValue().getJavaValue());
        assertEquals(2, token2.getLineNum());

        CharToken token5 = CharToken.lex(lines[4], 8, 1);
        assertEquals(11, token5.getEnd());
        assertEquals('@', (char) token5.getSchemeValue().getJavaValue());

        CharToken token6 = CharToken.lex(lines[6], 0,7);
        assertEquals(3,token6.getEnd());
        assertEquals(SPACE, (char) token6.getSchemeValue().getJavaValue());

        // TODO: 2021/7/14 token-char-test0.scm line 8
//        CharToken token7 = CharToken.lex(lines[7], 0, 8);
//        assertEquals('\n', (char) token7.getValue());
    }

    @Test(expected = LexerException.class)
    public void lexError1() {
        CharToken.lex(lines[2], 8, 1);
    }

    @Test(expected = LexerException.class)
    public void lexError2() {
        CharToken.lex(lines[3], 8, 1);
    }

    @Test(expected = LexerException.class)
    public void lexError3() {
        CharToken.lex(lines[5], 0, 1);
    }
}