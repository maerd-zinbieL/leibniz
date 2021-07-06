package core.number;

import org.jetbrains.annotations.Contract;

public class SchemeComplex implements SchemeNumber<SchemeComplex, SchemeReal> {
    private final SchemeReal real;
    private final SchemeReal imag;

    protected SchemeComplex(double real, double imag) {
        this.real = new SchemeReal(real);
        this.imag = new SchemeReal(imag);
    }

    protected SchemeComplex(int real, double imag) {
        this.real = new SchemeReal(real);
        this.imag = new SchemeReal(imag);
    }

    protected SchemeComplex(int real, int imag) {
        this.real = new SchemeReal(real);
        this.imag = new SchemeReal(imag);
    }

    protected SchemeComplex(double real, int imag) {
        this.real = new SchemeReal(real);
        this.imag = new SchemeReal(imag);
    }

    public static SchemeComplex getRectangularInstance(double real, double imag) {
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getRectangularInstance(int real, double imag) {
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getRectangularInstance(double real, int imag) {
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getRectangularInstance(int real, int imag) {
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getPolarInstance(double magnitude, double angle) {
        double real = Math.cos(angle) * magnitude;
        double imag = Math.sin(angle) * magnitude;
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getPolarInstance(int magnitude, int angle) {
        if (angle == 0)
            return new SchemeComplex(magnitude, 0);
        return getPolarInstance((double) magnitude, (double) angle);
    }

    public static SchemeComplex getPolarInstance(double magnitude, int angle) {
        return getPolarInstance(magnitude, (double) angle);
    }

    public static SchemeComplex getPolarInstance(int magnitude, double angle) {
        if (magnitude == 0)
            return new SchemeComplex(0, 0);
        return getPolarInstance((double) magnitude, angle);
    }

    public double getReal() {
        return real.getValue();
    }

    public double getImag() {
        return imag.getValue();
    }

    public double getMagnitude() {
        return Math.sqrt(real.getValue() * real.getValue() +
                imag.getValue() * imag.getValue());
    }

    public double getAngle() {
        return Math.atan(imag.getValue() / real.getValue());
    }

    @Override
    public boolean isExact() {
        return real.isExact() && imag.isExact();
    }

    @Override
    public SchemeComplex up() {
        return this;
    }

    @Override
    public SchemeReal down() {
        return new SchemeReal(real.getValue());
    }

    @Override
    public String toString() {
        String sign = imag.getValue() > 0 ? "+" : "-";
        return real.toString() + sign + imag.toString()+"i";
    }
}
