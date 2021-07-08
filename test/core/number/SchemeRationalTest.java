package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeRationalTest {

    @Test
    public void toInexact() {
        SchemeRational rational1 = new SchemeRational(1, -2);
        assertEquals("-0.5", rational1.toInexact().toString());

        SchemeRational rational2 = new SchemeRational(0, -2);
        assertEquals("-0.0", rational2.toInexact().toString());
    }

    @Test
    public void testToString() {
        SchemeRational rational1 = new SchemeRational(1, -2);
        assertEquals("-1/2", rational1.toString());

        SchemeRational rational2 = new SchemeRational(0, -2);
        assertEquals("0", rational2.toString());
    }
}