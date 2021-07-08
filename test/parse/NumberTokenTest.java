package parse;

import exception.LexerException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class NumberTokenTest {
    String[] lines;
    String fileName = "./test-resources/token-number-test0.scm";
    int badTokensCount = 1;
    @Before
    public void setUp() throws IOException {
        lines = ReadTestFile.getTestContents(fileName);
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void isNumber() {
        for (String line : lines) {
            assertTrue(NumberToken.isNumber(line, 0));
        }
    }

    @Test
    public void lex() {
        NumberToken[] tokens = new NumberToken[lines.length];
        for (int i = 0; i < lines.length - badTokensCount; i++) {
            tokens[i] = NumberToken.lex(lines[i], 0, i);
        }
        assertEquals("0", tokens[0].getValue().toString());
        assertEquals("1", tokens[1].getValue().toString());
        assertEquals("25", tokens[2].getValue().toString());
    }

    @Test(expected = LexerException.class)
    public void lexError() {
        NumberToken.lex(lines[3],3,3);
    }
}