package core.value.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeRealTest {

    @Test
    public void down() {
        SchemeReal schemeReal0 = new SchemeReal(31415);
        assertEquals("31415", schemeReal0.down().toString());

        SchemeReal schemeReal1 = new SchemeReal(31457888071.107);
        assertEquals("31457888071107/1000", schemeReal1.down().toString());

        SchemeReal schemeReal2 = new SchemeReal(-2718);
        assertEquals("-2718", schemeReal2.down().toString());

        SchemeReal schemeReal3 = new SchemeReal(-1233123.127);
        assertEquals("-1233123127/1000",schemeReal3.down().toString());

        SchemeReal schemeReal4 = new SchemeReal(-31457.107);
        assertEquals("-31457107/1000",schemeReal4.down().toString());

        SchemeReal schemeReal5 = new SchemeReal(-4454777700.0);
        assertEquals("-4454777700", schemeReal5.down().toString());

        SchemeReal schemeReal6 = new SchemeReal(137937910);
        assertEquals("137937910", schemeReal6.down().toString());

        SchemeReal schemeReal7 = new SchemeReal(-31415e-7);
        assertEquals("-6283/2000000", schemeReal7.down().toString());
    }
    @Test
    public void testToString() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3.0", schemeReal0.toString());

        SchemeReal schemeReal1 = new SchemeReal(31415926535.897);
        assertEquals("31415926535.897", schemeReal1.toString());

        SchemeReal schemeReal2 = new SchemeReal(31415926535.8979323);
        assertEquals("31415926535.897934",schemeReal2.toString());

        SchemeReal schemeReal3 = new SchemeReal(-314159265.3589);
        assertEquals("-314159265.3589",schemeReal3.toString());

        SchemeReal schemeReal4 = new SchemeReal(0.0);
        assertEquals("0.0",schemeReal4.toString());

        SchemeReal schemeReal5 = new SchemeReal(-4454777700.0);
        assertEquals("-4454777700.0",schemeReal5.toString());

        SchemeReal schemeReal6 = new SchemeReal(-4454777700.172);
        assertEquals("-4454777700.172",schemeReal6.toString());

        SchemeReal schemeReal7 = new SchemeReal(+31182e-9);
        assertEquals("0.000031182", schemeReal7.toString());

        SchemeReal schemeReal8 = new SchemeReal(-31415e-7);
        assertEquals("-0.0031415",schemeReal8.toString());

    }

    @Test
    public void toExact() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        assertEquals("3", schemeReal0.toExact().toString());

        SchemeReal schemeReal1 = new SchemeReal(+0.0);
        assertEquals("0", schemeReal1.toExact().toString());

        SchemeReal schemeReal2 = new SchemeReal(+3.14);
        assertEquals("157/50", schemeReal2.toExact().toString());

        SchemeReal schemeReal3 = new SchemeReal(3.0);
        System.out.println(schemeReal3.toExact());
        assertEquals("3", schemeReal3.toExact().toString());
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