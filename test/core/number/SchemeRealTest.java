package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeRealTest {

    @Test
    public void testToString() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3.0", schemeReal0.toString());

        SchemeReal schemeReal1 = new SchemeReal(3.0);
        assertEquals("3.0", schemeReal1.toString());

    }

    @Test
    public void toExact() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3", schemeReal0.toExact().toString());

        SchemeReal schemeReal1 = new SchemeReal(+0.0);
        assertEquals("0", schemeReal1.toExact().toString());

        SchemeReal schemeReal2 = new SchemeReal(+3.14);
        assertEquals("157/50", schemeReal2.toExact().toString());
    }

    @Test
    public void toInexact() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3.0", schemeReal0.toInexact().toString());

        SchemeReal schemeReal1 = new SchemeReal(+0.0);
        assertEquals("0.0", schemeReal1.toInexact().toString());

        SchemeReal schemeReal2 = new SchemeReal(+3.14);
        assertEquals("3.14", schemeReal2.toInexact().toString());
    }

}