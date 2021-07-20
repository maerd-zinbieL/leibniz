package core.env;

import core.value.number.SchemeReal;

public class InitEnv extends Frame {

    private InitEnv() {
        setup();
    }

    private void setup() {
        defineVariable("pi", new SchemeReal(3.1415926));
    }

    public static InitEnv getInstance() {
        return new InitEnv();
    }
}
