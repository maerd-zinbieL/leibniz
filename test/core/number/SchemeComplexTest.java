package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeComplexTest {

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