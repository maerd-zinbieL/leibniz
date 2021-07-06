package core.number;

public class SchemeReal implements SchemeNumber<SchemeComplex, SchemeRational> {
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

    private int getExponent10() {
        String valueStr = Double.toString(value);
        for (int i = 1; i < valueStr.length(); i++) {
            if (valueStr.charAt(i) == '.')
                return valueStr.length() - i - 1;
        }
        return 0;
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
    public SchemeRational down() {
        long exp = (long) Math.pow(10, getExponent10());
        long p = Math.round(value * exp);
        return new SchemeRational(p, exp);
    }

    @Override
    public String toString() {
        if (isExact)
            return Long.toString(Math.round(value));
        else
            return Double.toString(value);
    }

}
