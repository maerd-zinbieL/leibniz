package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeComplexTest {

    @Test
    public void toExact() {
        SchemeComplex complex1 = SchemeComplex.getRectangularInstance(3, 4);
        assertEquals("3+4i", complex1.toExact().toString());
        assertEquals("3.0+4.0i", complex1.toInexact().toString());

        SchemeComplex complex2 = SchemeComplex.getRectangularInstance(3.0, 4);
        assertEquals("3+4i", complex2.toExact().toString());
        assertEquals("3.0+4.0i", complex2.toInexact().toString());

        SchemeComplex complex3 = SchemeComplex.getRectangularInstance(3, 4.0);
        assertEquals("3+4i", complex3.toExact().toString());
        assertEquals("3.0+4.0i", complex3.toInexact().toString());

        SchemeComplex complex4 = SchemeComplex.getRectangularInstance(3.0, 4.0);
        assertEquals("3+4i", complex4.toExact().toString());
        assertEquals("3.0+4.0i", complex4.toInexact().toString());

        SchemeComplex complex5 = new SchemeComplex(
                new SchemeRational(3, 2),
                new SchemeRational(4, 2));
        assertEquals("3/2+2i", complex5.toExact().toString());
        assertEquals("1.5+2.0i", complex5.toInexact().toString());

    }

    @Test
    public void testToString() {
        SchemeComplex complex1 = SchemeComplex.getRectangularInstance(3, 4);
        assertEquals("3+4i", complex1.toString());

        SchemeComplex complex2 = SchemeComplex.getRectangularInstance(3.0, 4);
        assertEquals("3.0+4.0i", complex2.toString());

        SchemeComplex complex3 = SchemeComplex.getRectangularInstance(3, -4.0);
        assertEquals("3.0-4.0i", complex3.toString());

        SchemeComplex complex4 = SchemeComplex.getRectangularInstance(0.0, 0.0);
        assertEquals("0.0+0.0i", complex4.toString());

        SchemeComplex complex5 = SchemeComplex.getRectangularInstance(0, 0.0);
        assertEquals("0.0+0.0i", complex5.toString());

        SchemeComplex complex6 = SchemeComplex.getRectangularInstance(0.0, 0);
        assertEquals("0.0", complex6.toString());

        //todo ugly
        SchemeComplex complex7 = SchemeComplex.getRectangularInstance(0.0, -0.0);
        assertEquals("0.0+-0.0i", complex7.toString());

        SchemeComplex complex8 = SchemeComplex.getRectangularInstance(1.0, 0);
        assertEquals("1.0", complex8.toString());

        SchemeComplex complex9 = new SchemeComplex(
                new SchemeRational(3, 2),
                new SchemeRational(4, 2));
        assertEquals("3/2+2i",complex9.toString());

        SchemeComplex complex10 = new SchemeComplex(
                new SchemeRational(3, 2),
                new SchemeRational(-4, 3));
        assertEquals("3/2-4/3i",complex10.toString());
    }

    @Test
    public void down() {
        SchemeComplex complex1 = SchemeComplex.getRectangularInstance(1, 2);
        assertEquals("1.0", complex1.down().toString());

        SchemeComplex complex2 = SchemeComplex.getRectangularInstance(3.14, 0);
        assertEquals("3.14", complex2.down().toString());

        SchemeComplex complex3 = SchemeComplex.getRectangularInstance(3.14, 0.0);
        assertEquals("3.14", complex3.down().toString());

        SchemeComplex complex4 = SchemeComplex.getRectangularInstance(3, 0.0);
        assertEquals("3.0", complex4.down().toString());
    }

    @Test
    public void isExact() {
        SchemeComplex complex1 = SchemeComplex.getRectangularInstance(1, 1);
        assertTrue(complex1.isExact());

        SchemeComplex complex2 = SchemeComplex.getRectangularInstance(1, 1.0);
        assertFalse(complex2.isExact());

        SchemeComplex complex3 = SchemeComplex.getRectangularInstance(1.0, 1.0);
        assertFalse(complex3.isExact());

        SchemeComplex complex4 = SchemeComplex.getRectangularInstance(1.0, 1);
        assertFalse(complex4.isExact());

        SchemeComplex complex5 = SchemeComplex.getPolarInstance(1, 1);
        assertFalse(complex5.isExact());

        SchemeComplex complex6 = SchemeComplex.getPolarInstance(1, 0);
        assertTrue(complex6.isExact());

        SchemeComplex complex7 = SchemeComplex.getPolarInstance(1, 0.0);
        assertFalse(complex7.isExact());

        SchemeComplex complex8 = SchemeComplex.getPolarInstance(0, 1.0);
        assertTrue(complex8.isExact());

        SchemeComplex complex9 = SchemeComplex.getPolarInstance(0.0, 3);
        assertFalse(complex9.isExact());

        SchemeComplex complex10 = SchemeComplex.getPolarInstance(0.0, 0);
        assertFalse(complex10.isExact());

        SchemeComplex complex11 = SchemeComplex.getPolarInstance(0.0, 0.0);
        assertFalse(complex11.isExact());
    }

}