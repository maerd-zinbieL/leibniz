package core.env;

import core.exception.EvalException;
import core.value.*;
import core.value.number.SchemeInteger;
import core.value.number.SchemeNumber;
import core.value.number.SchemeReal;

import java.util.HashMap;
import java.util.Objects;

public class Frame {
    private final HashMap<String, SchemeValue<?>> varTable;
    private Frame preFrame;

    public Frame() {
        varTable = new HashMap<>();
        preFrame = null;
    }

    public void setPreFrame(Frame preFrame) {
        this.preFrame = preFrame;
    }

    public void extendFrame(Frame nextFrame) {
        nextFrame.setPreFrame(this);
    }

    private SchemeValue<?> lookUpVariable(String varName, Frame current) {
        if (current == null) {
            throw new EvalException("unbound variable: " + varName);
        }
        SchemeValue<?> result = current.varTable.get(varName);
        return Objects.requireNonNullElseGet(result,
                () -> lookUpVariable(varName, current.preFrame));
    }

    public SchemeValue<?> lookUpVariable(String varName) {
        return lookUpVariable(varName, this);
    }

    private void setVariable(String varName, SchemeValue<?> value, Frame current) {
        if (current == null) {
            throw new EvalException("unbound variable: " + varName);
        }
        SchemeValue<?> result = current.varTable.get(varName);
        if (result == null) {
            setVariable(varName, value, current.preFrame);
        } else {
            current.varTable.put(varName, value);
        }
    }

    public void setVariable(String varName, SchemeValue<?> value) {
        setVariable(varName, value, this);
    }

    public void defineVariable(String varName, SchemeValue<?> value) {
        assert value instanceof Primitive ||
                value instanceof SchemeNumber ||
                value instanceof SchemeBoolean ||
                value instanceof SchemeString ||
                value instanceof SchemeCharacter ||
                value instanceof SchemeQuotation ||
                value instanceof SchemePair ||
                value instanceof SchemeClosure;
        varTable.put(varName, value);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        Frame current = this;
        while (current.preFrame != null) {
            sb.append(current.varTable);
            sb.append(" -> ");
            current = current.preFrame;
        }
        sb.append(current.varTable);
        return sb.toString();
    }
}
