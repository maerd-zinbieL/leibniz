package core.number;

public class SchemeReal extends SchemeNumber {
    private final double value;

    public SchemeReal(double value) {
        this.value = value;
    }

    public double getValue() {
        return value;
    }

    @Override
    SchemeReal copy() {
        return new SchemeReal(value);
    }
    @Override
    public boolean isExact() {
        return false;
    }

    @Override
    public SchemeComplex up() {
        return SchemeComplex.getRectangularInstance(value, 0);
    }

    @Override
    public SchemeRational down() {
        long exp = (long) Math.pow(10, getExponent10(value));
        long p = Math.round(value * exp);
        return new SchemeRational(p, exp);
    }

    @Override
    public SchemeNumber toExact() {
        if (value % 1 == 0)
            return new SchemeInteger(Math.round(value));
        else return down();
    }

    @Override
    public SchemeNumber toInexact() {
        return copy();
    }

    @Override
    public String toString() {
        return Double.toString(value);
    }

}
