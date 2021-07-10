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
            if (line.length() != 0) {
//                System.out.println(line);
                assertTrue(NumberToken.isNumber(line, 0));
            }
        }
    }

    @Test
    public void lex() throws IOException {
        // TODO: 2021/7/10 java和scheme的科学计数法的表示不一样，找不到合适的方法输出scheme的大数。
        //  目前采用的方法是逐位输出scheme的数字。 测试文件第testTokenCount行后的数字可以分析，值也正确（未经过严密测试），
        //  但是表示方式和通常的实现不一样。

        int testTokenCount = 83;
        NumberToken[] tokens = new NumberToken[testTokenCount];
        for (int i = 0; i < testTokenCount; i++) {
            tokens[i] = NumberToken.lex(lines[i], 0, i + 1);
        }
        String[] represents = new String[tokens.length];
        for (int i = 0; i < represents.length; i++) {
            represents[i] = tokens[i].getValue().toString();
        }

        String expectFileName = "./test-resources/expect/token-number-test0.expect";
        String[] expectRepresents = ReadTestFile.getTestContents(expectFileName);

        for (int i = 0; i < tokens.length; i++) {
//            System.out.println(lines[i]);
            assertEquals(expectRepresents[i], represents[i]);
        }

        //testTokenCount行后的数字
        NumberToken token;
        for (int i = testTokenCount + 1; i < lines.length; i++) {
            System.out.println("------------------------------------");
            token = NumberToken.lex(lines[i], 0, i + 1);
            System.out.println(lines[i]);
            System.out.println(token.getValue());
            System.out.println("------------------------------------");
        }
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

    @Test (expected = LexerException.class)
    public void lexError1() {
        NumberToken.lex("-#i#d3141599f232", 0, 0);
    }
}