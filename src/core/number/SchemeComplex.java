package core.number;

public class SchemeComplex implements SchemeNumber<SchemeComplex, SchemeReal> {
    private final double real;
    private final double imag;

    protected SchemeComplex(double real, double imag) {
        this.real = real;
        this.imag = imag;
    }

    public static SchemeComplex getRectangularInstance(double real, double imag) {
        return new SchemeComplex(real, imag);
    }

    public static SchemeComplex getPolarInstance(double magnitude, double angle) {
        double real = Math.cos(angle) * magnitude;
        double imag = Math.sin(angle) * magnitude;
        return new SchemeComplex(real, imag);
    }

    public double getReal() {
        return real;
    }

    public double getImag() {
        return imag;
    }

    public double getMagnitude() {
        return Math.sqrt(real * real + imag * imag);
    }

    public double getAngle() {
        return Math.atan(imag / real);
    }

    @Override
    public SchemeComplex up() {
        return this;
    }

    @Override
    public SchemeReal down() {
        return new SchemeReal(real);
    }
}
