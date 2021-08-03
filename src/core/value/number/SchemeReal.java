package core.value.number;

import core.exception.BaseException;

public class SchemeReal extends SchemeNumber {
    private final double value;

    public SchemeReal(double value) {
        this.value = value;
    }

    public Double getJavaValue() {
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
        String absValueStr;
        String sign;
        if (value >= 0) {
            sign = "";
            absValueStr = String.valueOf(value);
        } else {
            sign = "-";
            absValueStr = String.valueOf(-value);
        }
        long numerator;
        long denominator;

        int isScientific = absValueStr.indexOf('E');
        if (isScientific != -1) {
            //如果是科学表示法，转换成非科学表示法;
            absValueStr = scientificToString(absValueStr, isScientific);
        }

        int dotIndex = absValueStr.indexOf('.');

        int exponent = absValueStr.length() - 1 - dotIndex;
        String numeratorStr = absValueStr.substring(0, dotIndex) + absValueStr.substring(dotIndex + 1);
        numeratorStr = sign + numeratorStr;
        denominator = Math.round(Math.pow(10, exponent));
        numerator = stringToBigNumber(numeratorStr);

        return new SchemeRational(numerator, denominator);
    }

    private long stringToBigNumber(String numberStr) {
        long result;
        try {
            result = Long.parseLong(numberStr);
        } catch (NumberFormatException e) {
            System.err.println(numberStr);
            throw new BaseException("bad number");
        }
        return result;
    }

    private String scientificToString(String absValueStr, int indexOfE) {
        int exponent = Integer.parseInt(absValueStr.substring(indexOfE + 1));
        StringBuilder sb;
        if (exponent < 0) {
            sb = new StringBuilder("0.");
            sb.append("0".repeat(-(exponent + 1)));
            sb.append(absValueStr.charAt(0));
            for (int i = 2; i < absValueStr.length(); i++) {
                char c = absValueStr.charAt(i);
                if (c == 'E' || c == 'e') {
                    break;
                }
                sb.append(c);
            }
        } else {
            sb = new StringBuilder(absValueStr.substring(0, 1));
            int charAtStr = 0;
            for (int i = 0; i < exponent; i++) {
                charAtStr = i + 2;
                if (charAtStr >= indexOfE) {
                    sb.append('0');
                    continue;
                }
                sb.append(absValueStr.charAt(charAtStr));
            }
            charAtStr++;
            if (charAtStr < indexOfE) {
                sb.append('.');
                for (int i = charAtStr; i < absValueStr.length(); i++) {
                    char c = absValueStr.charAt(i);
                    if (c == 'E' || c == 'e') {
                        break;
                    }
                    sb.append(c);
                }
            }
            if (sb.indexOf(".") == -1) {
                sb.append(".0");
            }
        }
        return sb.toString();

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
            return sign + scientificToString(valueStr, isScientific);
        }
    }
}
