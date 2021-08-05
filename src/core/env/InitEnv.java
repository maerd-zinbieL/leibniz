package core.env;

import core.exception.EvalException;
import core.value.Primitive;
import core.value.SchemeBoolean;
import core.value.SchemeValue;
import core.value.number.SchemeReal;

public class InitEnv extends Frame {

    private InitEnv() {
        setup();
    }

    public static InitEnv getInstance() {
        return new InitEnv();
    }

    private void setup() {

        defineVariable("+", new Primitive(arguments -> {
            double sum = 0.0;
            double value;
            for (SchemeValue<?> argument : arguments) {
                value = (double) argument.getJavaValue();
                sum += value;
            }
            return (new SchemeReal(sum)).toExact();
        }));

        defineVariable("-", new Primitive(arguments -> {
            double result = (double) arguments[0].getJavaValue();
            for (int i = 1; i < arguments.length; i++) {
                result -= (double) arguments[i].getJavaValue();
            }
            return new SchemeReal(result).toExact();
        }));

        defineVariable("<", new Primitive(arguments -> {
            if (arguments.length != 2) {
                throw new EvalException("incorrect number of arguments to: " + "<");
            }
            boolean result = (double) arguments[0].getJavaValue()
                    < (double) arguments[1].getJavaValue();
            return new SchemeBoolean(result);
        }));
    }
}
