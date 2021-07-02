package parse;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class CharTokenTest {

    String[] lines;
    @Before
    public void setUp()  {
        lines = new String[] {
                "whatever#\\space whatever",
                "whatever#\\newline whatever",
                "whatever#\\spacewhatever",
                "whatever#\\newlinewhatever",
                "whatever#\\@",
                "#\\@whatever",
        };
    }

    @After
    public void tearDown() {
        lines = null;
    }

    @Test
    public void isCharacter() {
        assertTrue(CharToken.isCharacter(lines[0],8));
        assertTrue(CharToken.isCharacter(lines[1],8));
        assertFalse(CharToken.isCharacter(lines[2],8));
        assertFalse(CharToken.isCharacter(lines[3],8));
        assertTrue(CharToken.isCharacter(lines[4],8));
        assertFalse(CharToken.isCharacter(lines[5],0));
    }

    @Test
    public void lex() {
        CharToken token1 = CharToken.lex(lines[0], 8,1 );
        assertEquals(16, token1.getEnd());
        assertEquals("#\\space", token1.getValue());
        assertEquals(8, token1.getColNum());

        CharToken token2 = CharToken.lex(lines[1], 8,2 );
        assertEquals(18, token2.getEnd());
        assertEquals("#\\newline", token2.getValue());
        assertEquals(2, token2.getLineNum());

        CharToken token5 = CharToken.lex(lines[4],8, 1 );
        assertEquals(12,token5.getEnd());
        assertEquals("#\\@", token5.getValue());
    }
    @Test(expected = IllegalArgumentException.class)
    public void lexError1() {
        CharToken.lex(lines[2],8, 1 );
    }
    @Test(expected = IllegalArgumentException.class)
    public void lexError2() {
        CharToken.lex(lines[3],8, 1 );
    }
    @Test(expected = IllegalArgumentException.class)
    public void lexError3() {
        CharToken.lex(lines[5],0, 1 );
    }
}