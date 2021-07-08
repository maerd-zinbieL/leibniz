package parse;

import core.number.SchemeNumber;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class NumberTokenTest {
    String[] lines;
    String fileName = "./test-resources/token-number-test0.scm";

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
        for (int i = 0; i < lines.length; i++) {
            tokens[i] = NumberToken.lex(lines[i], 0, i);
        }
        assertEquals("0", tokens[0].getValue().toString());
        assertEquals("1", tokens[1].getValue().toString());
        assertEquals("25", tokens[2].getValue().toString());
        System.out.println(tokens[3].getValue().toString());

    }
}