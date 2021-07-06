package core.number;

public class SchemeReal implements SchemeNumber<SchemeComplex, SchemeRational>{
    private final double value;
    public SchemeReal(double value) {
        this.value = value;
    }

    @Override
    public SchemeComplex up() {
        return SchemeComplex.getRectangularInstance(value, 0);
    }

    @Override
    public SchemeRational down() {
        // TODO: 2021/7/6 casting a real to rational
        return new SchemeRational(Math.round(value), 1);
    }
}
