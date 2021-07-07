package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeRealTest {

    @Test
    public void testToString() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3", schemeReal0.toString());

        SchemeReal schemeReal1 = new SchemeReal(3.0);
        assertEquals("3.0", schemeReal1.toString());

    }
}