package parse;

import exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class StringTokenTest {
    String[] lines;
    String fileName = TestUtil.TEST_TOKEN_FILES_PATH + "token-string-test0.scm";

    @Before
    public void setUp() throws IOException {
        lines = TestUtil.getTestContents(fileName);
    }

    @After
    public void tearDown() throws Exception {
        lines = null;
    }

    @Test
    public void getEnd() {
    }

    @Test
    public void isString() {
        assertFalse(StringToken.isString(lines[0], 10));
        assertTrue(StringToken.isString(lines[0], 0));
        assertTrue(StringToken.isString(lines[1], 0));
    }

    @Test
    public void lex() {
        Token<String> token1 = StringToken.lex(lines[0], 1, 0);
        assertEquals("whatever\\\"Hello World!\\\"", token1.getValue());
        assertEquals(26, token1.getEnd());

        Token<String> token2 = StringToken.lex(lines[1], 1, 1);
        assertEquals("\\\"Hello \\\\World!\\\"", token2.getValue());

        Token<String> token3 = StringToken.lex(lines[2], 1, 0);
        assertEquals("Hello World!", token3.getValue());
        assertEquals(14, token3.getEnd());

    }

    @Test(expected = LexerException.class)
    public void lexError1() {
//        "\"Hello \nWorld!\""
        StringToken.lex(lines[3], 1, 0);
    }

    @Test(expected = LexerException.class)
    public void lexError2() {
//        "\"Hello \r\nWorld!\""
        StringToken.lex(lines[4], 1, 0);
    }
}