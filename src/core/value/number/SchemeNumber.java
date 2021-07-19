package core.value.number;

import core.value.SchemeValue;

public abstract class SchemeNumber extends SchemeValue<Double> {

    abstract SchemeNumber copy();

    public abstract boolean isExact();

    public abstract SchemeNumber up();

    public abstract SchemeNumber down();

    public abstract SchemeNumber toExact();

    public abstract SchemeNumber toInexact();

}

