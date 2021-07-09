package core.number;

import exception.BaseException;

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
        String valueStr = String.valueOf(value);
        int exponent;
        long numerator;
        String numeratorStr;
        long denominator;

        int isScientific = valueStr.indexOf('E');
        if (isScientific != -1) {
            exponent = Integer.parseInt(valueStr.substring(isScientific + 1));
            numeratorStr = valueStr.charAt(0) + valueStr.substring(2, isScientific);
            denominator = Math.round(Math.pow(10, numeratorStr.length() - exponent - 1));
        } else {
            int dotIndex = valueStr.indexOf('.');
            exponent = valueStr.length() - 1 - dotIndex;
            numeratorStr = valueStr.substring(0, dotIndex) + valueStr.substring(dotIndex + 1);
            denominator = Math.round(Math.pow(10, exponent));
        }
        try {
            numerator = Long.parseLong(numeratorStr);
        } catch (NumberFormatException e) {
//            e.printStackTrace();
            throw new BaseException("bad number");
        }

        return new SchemeRational(numerator, denominator);
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
        String valueStr;
        String sign;
        if (value >= 0) {
            sign = "";
            valueStr = String.valueOf(value);
        } else {
            sign = "-";
            valueStr = String.valueOf(-value);
        }

        int isScientific = valueStr.indexOf('E');
        if (isScientific == -1) {
            return sign + valueStr;
        } else {
            int exponent = Integer.parseInt(valueStr.substring(isScientific + 1));
            StringBuilder sb = new StringBuilder();
            return null;
            // TODO: 2021/7/9 fix this bug -4454777700.0
        }
    }

    public static void main(String[] args) {
        System.out.println(new SchemeReal(-4454777700.0).toString());
    }
}
