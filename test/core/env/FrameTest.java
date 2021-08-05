package core.env;

import core.value.number.SchemeInteger;
import core.value.number.SchemeReal;
import org.junit.Test;
import parse.token.NumberToken;

import static org.junit.Assert.*;

public class FrameTest {

    @Test
    public void defineLookup1() {
        Frame init = new Frame();

        init.defineVariable("pi", new SchemeReal(3.14));
        assertEquals("3.14", init.lookUpVariable("pi").toString());
        init.defineVariable("pi", new SchemeReal(2.718));
        assertEquals("2.718", init.lookUpVariable("pi").toString());
    }

    @Test
    public void defineLookup2() {
        Frame init = new Frame();
        init.defineVariable("pi", new SchemeReal(3.14));

        Frame next1 = new Frame();
        next1.setPreFrame(init);

        next1.defineVariable("pi2", new SchemeReal(6.28));

        next1.defineVariable("pi", new SchemeInteger(0));
        assertEquals("0", next1.lookUpVariable("pi").toString());
        assertEquals("6.28", next1.lookUpVariable("pi2").toString());

        assertEquals("3.14", init.lookUpVariable("pi").toString());

        Frame next2 = new Frame();
        next1.extendFrame(next2);
        next2.defineVariable("e",  new SchemeReal(2.718));
        assertEquals("0", next2.lookUpVariable("pi").toString());
        assertEquals("2.718", next2.lookUpVariable("e").toString());

    }

    @Test
    public void setVariable() {

    }

    @Test
    public void testToString() {
        Frame init = new Frame();
        init.defineVariable("pi", new SchemeReal(3.14));

        Frame next1 = new Frame();
        next1.setPreFrame(init);

        next1.defineVariable("pi2", new SchemeReal(6.28));

        next1.defineVariable("pi", new SchemeInteger(0));

        Frame next2 = new Frame();
        next1.extendFrame(next2);

        assertEquals("{} -> {pi2=6.28, pi=0} -> {pi=3.14}", next2.toString());

    }
}