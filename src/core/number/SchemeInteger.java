package core.number;

public class SchemeInteger implements SchemeNumber<SchemeRational,SchemeInteger>{
    private final long value;

    public SchemeInteger(long value) {
        this.value = value;
    }

    @Override
    public SchemeRational up() {
        return new SchemeRational(value, 1);
    }

    @Override
    public SchemeInteger down() {
        return this;
    }
}
