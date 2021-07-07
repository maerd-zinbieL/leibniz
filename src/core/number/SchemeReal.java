package core.number;

public class SchemeReal extends SchemeNumber {
    private final double value;
    private final boolean isExact;

    public SchemeReal(double value) {
        isExact = false;
        this.value = value;
    }

    public SchemeReal(int value) {
        isExact = true;
        this.value = value;
    }

    public double getValue() {
        return value;
    }

    @Override
    public boolean isExact() {
        return isExact;
    }

    @Override
    public SchemeComplex up() {
        return SchemeComplex.getRectangularInstance(value, 0);
    }

    @Override
    public SchemeNumber down() {
        long exp = (long) Math.pow(10, getExponent10(value));
        long p = Math.round(value * exp);
        return new SchemeRational(p, exp).down();
    }

    @Override
    public String toString() {
        if (isExact)
            return Long.toString(Math.round(value));
        else
            return Double.toString(value);
    }

}
