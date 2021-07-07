package core.number;

public class SchemeInteger extends SchemeNumber{
    private final long value;

    public SchemeInteger(long value) {
        this.value = value;
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
        return this;
    }

    @Override
    public String toString() {
        return Long.toString(value);
    }
}
