package core.number;

public class SchemeRational extends SchemeNumber {
    private final long numerator;
    private final long denominator;

    public SchemeRational(long numerator, long denominator) {
        if (denominator == 0)
            throw new IllegalArgumentException();
        long gcd = gcd(numerator, denominator);
        this.numerator = numerator / gcd;
        this.denominator = denominator / gcd;
    }

    private long gcd(long a, long b) {
        a = Math.abs(a);
        b = Math.abs(b);
        if (a == 0)
            return b;
        while (b != 0) {
            if (a > b)
                a = a - b;
            else
                b = b - a;
        }
        return a;
    }

    @Override
    SchemeRational copy() {
        return new SchemeRational(numerator, denominator);
    }

    @Override
    public double getValue() {
        return (double) numerator / (double) denominator;
    }

    @Override
    public boolean isExact() {
        return true;
    }

    @Override
    public SchemeReal up() {
        return new SchemeReal((double) numerator / denominator);
    }

    @Override
    public SchemeInteger down() {
        return new SchemeInteger(numerator / denominator);
    }

    @Override
    public SchemeRational toExact() {
        return copy();
    }

    @Override
    public SchemeReal toInexact() {
        return new SchemeReal((double) numerator / (double) denominator);
    }

    @Override
    public String toString() {
        long numeratorAbs = Math.abs(numerator);
        long denominatorAbs = Math.abs(denominator);
        String sign = (numerator * denominator) < 0 ? "-" : "";
        if (denominatorAbs == 1) {
            return sign + numerator;
        }
        return sign + numeratorAbs + "/" + denominatorAbs;
    }
}
