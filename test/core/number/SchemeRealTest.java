package core.number;

import org.junit.Test;

import static org.junit.Assert.*;

public class SchemeRealTest {

    @Test
    public void testToString() {
        SchemeReal schemeReal0 = new SchemeReal(3);
        System.out.println(schemeReal0);

        SchemeReal schemeReal1 = new SchemeReal(3.0);
        System.out.println(schemeReal1);
    }
}