package parse;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class StringTokenTest {
    String[] lines;

    @Before
    public void setUp() {
        lines = new String[] {
                "whatever\"Hello World!\"",
                "\"Hello \nWorld!\"",
                "\"Hello \\World!\"",
                "\"Hello \"World!\"",
                "\"Hello \r\nWorld!\"",
        };
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
        assertTrue(StringToken.isOpenString(lines[0],9));
        assertFalse(StringToken.isOpenString(lines[0],0));
        assertTrue(StringToken.isOpenString(lines[1],0));
    }

    @Test
    public void lex() {
    }
}