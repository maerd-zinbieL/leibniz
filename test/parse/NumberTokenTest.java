package parse;

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
    public void lex() throws IOException {
        NumberToken[] tokens = new NumberToken[lines.length];
        for (int i = 0; i < lines.length; i++) {
            tokens[i] = NumberToken.lex(lines[i], 0, i + 1);
        }
        String[] represents = new String[tokens.length];
        for (int i = 0; i < represents.length; i++) {
            represents[i] = tokens[i].getValue().toString();
        }

        String expectFileName = "./test-resources/expect/token-number-test0.expect";
        String[] expectRepresents = ReadTestFile.getTestContents(expectFileName);

        assertArrayEquals(expectRepresents, represents);
    }

    @Test
    public void getEnd() {
        int testLength = 23;
        NumberToken[] tokens = new NumberToken[testLength];
        for (int i = 0; i < testLength; i++) {
            tokens[i] = NumberToken.lex(lines[i], 0, i);
        }
        int[] ends = new int[testLength];
        for (int i = 0; i < testLength; i++) {
            ends[i] = tokens[i].getEnd();
        }
        int[] expectedEnd = new int[]{
                1,
                1,
                2,
                19,
                9,
                20,
                10,
                7,
                7,
                10,
                10,
                11,
                10,
                11,
                11,
                10,
                14,
                15,
                15,
                13,
                12,
                3,
                4,
        };
        assertArrayEquals(expectedEnd, ends);
    }
}