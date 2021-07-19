package core.value.number;

public class SchemeInteger extends SchemeNumber {
    private final long value;

    public SchemeInteger(long value) {
        this.value = value;
    }

    @Override
    SchemeInteger copy() {
        return new SchemeInteger(value);
    }

    @Override
    public Double getJavaValue() {
        return (double) value;
    }

    @Override
    public boolean isExact() {
        return true;
    }

    @Override
    public SchemeRational up() {
        return new SchemeRational(value, 1);
    }

    @Override
    public SchemeInteger down() {
        return copy();
    }

    @Override
    public SchemeInteger toExact() {
        return copy();
    }

    @Override
    public SchemeReal toInexact() {
        return new SchemeReal((double) value);
    }

    @Override
    public String toString() {
        return Long.toString(value);
    }
}
