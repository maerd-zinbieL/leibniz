package parse.token;

import core.value.number.SchemeInteger;
import core.value.number.SchemeNumber;
import core.value.number.SchemeReal;
import core.exception.LexerException;

public class NumberToken extends Token {

    private final SchemeNumber value;
    private static int tokenLineNum;
    private static int tokenColNum;
    private static String lexLine;
    private static StringBuilder readSoFarSB;
    private static boolean isPositive;
    private static boolean mustBeExact;
    private static boolean mustNotBeExact;
    private static int tokenEnd;

    public NumberToken(SchemeNumber value, int lineNum, int colNum, int end) {
        super(TokenType.Number, lineNum, colNum, end);
        this.value = value;
    }

    public SchemeNumber getSchemeValue() {
        return value;
    }

    private static boolean isDigit2(char c) {
        return c == '1' ||
                c == '0';
    }

    private static boolean isDigit8(char c) {
        return c <= '7' && c >= '0';
    }

    private static boolean isDigit16(char c) {
        return isDigit(c) ||
                (c <= 'f' && c >= 'a');
    }

    private static boolean isExponentMarker(char c) {
        // TODO: 2021/7/8   不同的marker之间有什么区别？
        return c == 'e' ||
                c == 's' ||
                c == 'f' ||
                c == 'd' ||
                c == 'l';
    }

    public static boolean isNumber(String line, int start) {
        line = line.toLowerCase();
        return line.startsWith("#b", start) ||
                line.startsWith("#o", start) ||
                line.startsWith("#d", start) ||
                line.startsWith("#x", start) ||
                line.startsWith("#i", start) ||
                line.startsWith("#e", start) ||
                isDigit(line.charAt(start)) ||
                (isSign(line.charAt(start)) && isDigit(line.charAt(start + 1))) ||
                (line.charAt(start) == '.' && isDigit(line.charAt(start + 1)));
    }

    private static void supportInFuture(int start) {
        if (lexLine.startsWith("#b", start) ||
                lexLine.startsWith("#o", start) ||
                lexLine.startsWith("#x", start)) {
            throw new LexerException("only support decimal numbers at this version");
        }
    }

    private static SchemeNumber afterReadSign(int start) {
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            readSoFarSB.append(c);
            return beforeDot(start + 1);
        }
        if (c == '.') {
            readSoFarSB.append(c);
            return afterDotNeedDigit(start + 1);
        }
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readDecimalAfterPrefix(int start) {
        char c = lexLine.charAt(start);
        if (c == '.') {
            readSoFarSB.append(c);
            return afterDotNeedDigit(start + 1);
        }
        if (isDigit(c)) {
            readSoFarSB.append(c);
            return beforeDot(start + 1);
        }

        if (c == '+') {
            isPositive = true;
            return afterReadSign(start + 1);
        }
        if (c == '-') {
            isPositive = false;
            return afterReadSign(start + 1);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readDecimalNeedExactness(int start) {
        if (lexLine.startsWith("#i", start)) {
            mustNotBeExact = true;
            return readDecimalAfterPrefix(start + 2);
        }
        char c = lexLine.charAt(start);
        if (lexLine.startsWith("#e", start)) {
            mustBeExact = true;
            return readDecimalAfterPrefix(start + 2);
        }
        if (isDigit(c)) {
            return readDecimalAfterPrefix(start);
        }
        if (c == '.') {
            return readDecimalAfterPrefix(start);
        }
        if (isSign(c)) {
            return readDecimalAfterPrefix(start);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readRadix(int start) {
        char c = lexLine.charAt(start);
        if (lexLine.startsWith("#d", start)) {
            return readDecimalAfterPrefix(start + 2);
        }
        if (isDigit(c) || c == '.' || isSign(c)) {
            return readDecimalAfterPrefix(start);
        }
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber afterSuffix(int start, char expMarker, int expValue) {
        if (isDelimiterOrEOF(lexLine, start)) {
            if (isExponentMarker(expMarker)) {
                return getSchemeReal(start, expValue);
            }
        }
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            int newExpValue;
            if (expValue >= 0) {
                newExpValue = expValue * 10 + digitToInt(c);
            } else {
                newExpValue = expValue * 10 - digitToInt(c);
            }
            return afterSuffix(start + 1, expMarker, newExpValue);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readSuffixNeedDigit(int start, char expMarker, int expValueSign) {
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            int expValue = expValueSign * digitToInt(c);
            return afterSuffix(start + 1, expMarker, expValue);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readSuffix(int start, char expMarker) {
        char c = lexLine.charAt(start);
        if (c == '-') {
            return readSuffixNeedDigit(start + 1, expMarker, -1);
        }
        if (c == '+') {
            return readSuffixNeedDigit(start + 1, expMarker, 1);
        }
        if (isDigit(c)) {
            return readSuffixNeedDigit(start, expMarker, 1);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber afterSharpThenDot(int start) {
        if (isDelimiterOrEOF(lexLine, start)) {
            return getSchemeReal(start);
        }
        char c = lexLine.charAt(start);
        if (c == '#') {
            return afterSharpThenDot(start + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, c);
        }
        return null;
    }

    private static SchemeNumber readSharpAfterDot(int start) {
        if (isDelimiterOrEOF(lexLine, start)) {
            return getSchemeReal(start);
        }
        char c = lexLine.charAt(start);
        if (c == '#') {
            return readSharpAfterDot(start + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, c);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static double readSoFar2Double() {
        double value;
        if (!isPositive) {
            readSoFarSB.insert(0, '-');
        }
        try {
            value = Double.parseDouble(readSoFarSB.toString());
        } catch (NumberFormatException e) {
            throw new LexerException("too large number at (" + tokenLineNum + "," + tokenColNum + ")");
        }
        return value;
    }

    private static SchemeNumber getSchemeReal(int start, int expValue) {
        double value = readSoFar2Double();
//        System.out.println(expValue);
        if (value != 0) {
            value = value * Math.pow(10, expValue);
        }
        if (Double.isInfinite(value) || Double.isNaN(value)) {
            throw new LexerException("number at (" + tokenLineNum + "," +
                    tokenColNum + ") " + "is too large");
        }
        SchemeNumber number = new SchemeReal(value);
        if (mustBeExact) {
            number = number.toExact();
        }
        tokenEnd = start;
        return number;
    }

    private static SchemeNumber getSchemeReal(int start) {
        double value = readSoFar2Double();
        SchemeNumber number = new SchemeReal(value);
        if (mustBeExact) {
            number = number.toExact();
        }
        tokenEnd = start;
        return number;
    }

    private static SchemeNumber afterDot(int start, int exponent) {
        if (isDelimiterOrEOF(lexLine, start)) {
            return getSchemeReal(start);
        }
        char c = lexLine.charAt(start);
        if (c == '#') {
            return readSharpAfterDot(start + 1);
        }
        if (isDigit(c)) {
            readSoFarSB.append(c);
            return afterDot(start + 1, exponent + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, c);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber afterDotNeedDigit(int start) {
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            readSoFarSB.append(c);
            return afterDot(start + 1, 1);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readSharpBeforeDot(int start) {
        if (isDelimiterOrEOF(lexLine, start)) {
            return getSchemeReal(start);
        }
        char c = lexLine.charAt(start);
        if (c == '#') {
            readSoFarSB.append('0');
            return readSharpBeforeDot(start + 1);
        }
        if (c == '.') {
            readSoFarSB.append(c);
            return afterSharpThenDot(start + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, c);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber getSchemeInteger(int start) {
        long value;
        if (!isPositive) {
            readSoFarSB.insert(0, '-');
        }
        try {
            value = Long.parseLong(readSoFarSB.toString());
        } catch (NumberFormatException e) {
            throw new LexerException("too large integer at (" + tokenLineNum + "," + tokenColNum + ")");
        }
        SchemeNumber number = new SchemeInteger(value);
        if (mustNotBeExact) {
            number = number.toInexact();
        }
        tokenEnd = start;
        return number;
    }

    private static SchemeNumber beforeDot(int start) {
        if (isDelimiterOrEOF(lexLine, start)) {
            return getSchemeInteger(start);
        }
        char c = lexLine.charAt(start);
        if (c == '#') {
            readSoFarSB.append('0');
            return readSharpBeforeDot(start + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, c);
        }
        if (isDigit(c)) {
            readSoFarSB.append(c);
            return beforeDot(start + 1);
        }
        if (c == '.') {
            readSoFarSB.append(c);
            return afterDot(start + 1, 1);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static SchemeNumber readPrefix(int start) {
        char first = lexLine.charAt(start);
        if (first == 'i') {
            mustNotBeExact = true;
            return readRadix(start + 1);
        }
        if (first == 'e') {
            mustBeExact = true;
            return readRadix(start + 1);
        }
        if (first == 'd') {
            return readDecimalNeedExactness(start + 1);
        }
        supportInFuture(start - 1);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    public static NumberToken lex(String line, int start, int lineNum) {
        // TODO: 2021/7/8   复数,分数
        // TODO: 2021/7/8   缺少一些数字的溢出报错
        lexLine = line.toLowerCase();
        tokenLineNum = lineNum;
        tokenColNum = start;
        readSoFarSB = new StringBuilder();
        mustBeExact = false;
        mustNotBeExact = false;
        SchemeNumber number;
        char first = line.charAt(start);
        if (first == '-') {
            isPositive = false;
            number = afterReadSign(start + 1);
            return new NumberToken(number, tokenLineNum, tokenColNum, tokenEnd);
        }
        if (first == '+') {
            isPositive = true;
            number = afterReadSign(start + 1);
            return new NumberToken(number, tokenLineNum, tokenColNum, tokenEnd);
        }
        if (first == '#') {
            isPositive = true;
            number = readPrefix(start + 1);
            return new NumberToken(number, tokenLineNum, tokenColNum, tokenEnd);
        }
        if (isDigit(first)) {
            readSoFarSB.append(first);
            isPositive = true;
            number = beforeDot(start + 1);
            return new NumberToken(number, tokenLineNum, tokenColNum, tokenEnd);
        }
        if (first == '.') {
            isPositive = true;
            number = afterDotNeedDigit(start + 1);
            return new NumberToken(number, tokenLineNum, tokenColNum, tokenEnd);
        }
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    @Override
    public String toString() {
        return value.toString();
    }

    public static void main(String[] args) {
        // TODO: 2021/7/10 fix this bug
        String line = "#d#e314152.##d22";
        NumberToken token = lex(line, 0, 1);
        System.out.println(token.getSchemeValue()); //9223372036854775807

    }
}