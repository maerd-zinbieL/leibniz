package core.number;

public class SchemeRational extends SchemeNumber {
    private final long numerator;
    private final long denominator;

    public SchemeRational(long numerator, long denominator) {
        long gcd = gcd(numerator, denominator);
        this.numerator = numerator / gcd;
        this.denominator = denominator / gcd;
    }

    private long gcd(long a, long b) {
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
    public boolean isExact() {
        return true;
    }

    @Override
    public SchemeReal up() {
        return new SchemeReal((double) numerator / denominator);
    }

    @Override
    public SchemeNumber down() {
        if (denominator==1)
            return new SchemeInteger(numerator);
        return this;
    }

    @Override
    public String toString() {
        return numerator + "/" + denominator;
    }
}
