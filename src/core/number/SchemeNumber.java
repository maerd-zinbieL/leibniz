package core.number;

public abstract class SchemeNumber {
    abstract SchemeNumber copy();
    public abstract double getValue();
    public abstract boolean isExact();

    public abstract SchemeNumber up();

    public abstract SchemeNumber down();

    public abstract SchemeNumber toExact();

    public abstract SchemeNumber toInexact();

}

