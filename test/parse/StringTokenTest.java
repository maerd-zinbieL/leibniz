package parse;

import exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;

import static org.junit.Assert.*;

public class StringTokenTest {
    String[] lines;
    String fileName = "./test-resources/token-string-test0.scm";

    @Before
    public void setUp() throws IOException {
        lines = ReadTestFile.getTestContents(fileName);
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
//        "whatever\"Hello World!\""
//        "\"Hello \\World!\""
//        "Hello World!"
        Token<String> token1 = StringToken.lex(lines[0], 1, 0);
        assertEquals("whatever\\\"Hello World!\\\"", token1.getValue());

        Token<String> token2 = StringToken.lex(lines[1], 1, 1);
        assertEquals("\\\"Hello \\\\World!\\\"", token2.getValue());

        Token<String> token3 = StringToken.lex(lines[2], 1, 0);
        assertEquals("Hello World!", token3.getValue());
    }

    @Test(expected = LexerException.class)
    public void lexError1() {
//        "\"Hello \nWorld!\""
        StringToken.lex(lines[3],1,0);
    }

    @Test(expected = LexerException.class)
    public void lexError2() {
//        "\"Hello \r\nWorld!\""
        StringToken.lex(lines[4],1,0);
    }
}