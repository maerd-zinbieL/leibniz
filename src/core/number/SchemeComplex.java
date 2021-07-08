package core.number;

public class SchemeComplex extends SchemeNumber {
    private final SchemeNumber real;
    private final SchemeNumber imag;

    public SchemeComplex(SchemeNumber real, SchemeNumber imag) {
        if (real.getClass() == SchemeComplex.class ||
                imag.getClass() == SchemeComplex.class) {
            throw new IllegalArgumentException();
        }
        this.real = real;
        this.imag = imag;
    }


    public static SchemeComplex getRectangularInstance(double real, double imag) {
        return new SchemeComplex(new SchemeReal(real), new SchemeReal(imag));
    }

    public static SchemeComplex getRectangularInstance(int real, double imag) {
        return new SchemeComplex(new SchemeInteger(real), new SchemeReal(imag));
    }

    public static SchemeComplex getRectangularInstance(double real, int imag) {
        return new SchemeComplex(new SchemeReal(real), new SchemeInteger(imag));
    }

    public static SchemeComplex getRectangularInstance(int real, int imag) {
        return new SchemeComplex(new SchemeInteger(real), new SchemeInteger(imag));
    }

    public static SchemeComplex getPolarInstance(double magnitude, double angle) {
        double real = Math.cos(angle) * magnitude;
        double imag = Math.sin(angle) * magnitude;
        return new SchemeComplex(new SchemeReal(real), new SchemeReal(imag));
    }

    public static SchemeComplex getPolarInstance(int magnitude, int angle) {
        if (angle == 0)
            return new SchemeComplex(new SchemeInteger(magnitude), new SchemeInteger(0));
        return getPolarInstance((double) magnitude, (double) angle);
    }

    public static SchemeComplex getPolarInstance(double magnitude, int angle) {
        return getPolarInstance(magnitude, (double) angle);
    }

    public static SchemeComplex getPolarInstance(int magnitude, double angle) {
        if (magnitude == 0)
            return new SchemeComplex(new SchemeInteger(0), new SchemeInteger(0));
        return getPolarInstance((double) magnitude, angle);
    }

    @Override
    SchemeComplex copy() {
        if (real.getClass() == SchemeComplex.class ||
                imag.getClass() == SchemeComplex.class) {
            throw new IllegalArgumentException();
        }
        return new SchemeComplex(real.copy(), imag.copy());
    }

    @Override
    public double getValue() {
        return real.getValue();
    }

    @Override
    public boolean isExact() {
        return real.isExact() && imag.isExact();
    }

    @Override
    public SchemeComplex up() {
        return copy();
    }

    @Override
    public SchemeReal down() {
        return new SchemeReal(real.getValue());
    }

    @Override
    public SchemeNumber toExact() {
        return new SchemeComplex(real.toExact(), imag.toExact());
    }

    @Override
    public SchemeNumber toInexact() {
        return new SchemeComplex(real.toInexact(), imag.toInexact());
    }

    @Override
    public String toString() {

        // 如果虚数和实数都是exact的，返回两者的exact的表示。
        if (isExact()) {
            String sign = imag.getValue() >= 0 ? "+" : "";
            return real + sign + imag + "i";
        }

        // 如果虚数是exact的，并且为0,去掉虚数部分。
        if (imag.isExact() && imag.getValue() == 0)
            return real.toString();

        //只要虚数或实数有一个不是exact的，虚数和实数就都是inexact的。
        String sign = imag.getValue() >= 0 ? "+" : "";
        return real.getValue() + sign + imag.getValue() + "i";
    }

    public static void main(String[] args) {
        SchemeComplex complex10 = new SchemeComplex(
                new SchemeRational(3, 2),
                new SchemeRational(-4, 3));
    }
}
