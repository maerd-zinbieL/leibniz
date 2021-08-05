package core.value.number;

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
    public Double getJavaValue() {
        return real.getJavaValue();
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
        return new SchemeReal(real.getJavaValue());
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
    public SchemeNumber add(SchemeNumber other) {
        return null;
    }

    @Override
    public SchemeNumber sub(SchemeNumber other) {
        return null;
    }

    @Override
    public SchemeNumber div(SchemeNumber other) {
        return null;
    }

    @Override
    public SchemeNumber mul(SchemeNumber other) {
        return null;
    }

    @Override
    public SchemeNumber compare(SchemeNumber other) {
        return null;
    }

    @Override
    public String toString() {

        // 如果虚数和实数都是exact的，返回两者的exact的表示。
        if (isExact()) {
            String sign = imag.getJavaValue() >= 0 ? "+" : "";
            return real + sign + imag + "i";
        }

        // 如果虚数是exact的，并且为0,去掉虚数部分。
        if (imag.isExact() && imag.getJavaValue() == 0)
            return real.toString();

        //只要虚数或实数有一个不是exact的，虚数和实数就都是inexact的。
        String sign = imag.getJavaValue() >= 0 ? "+" : "";
        return real.getJavaValue() + sign + imag.getJavaValue() + "i";
    }

}
