package parse;

import core.number.SchemeNumber;
import exception.LexerException;

import java.util.Locale;

public class Token<T> {
    private final TokenType type;
    private final T value;
    private final int lineNum;
    private final int colNum;
    private final int end;

    Token(TokenType type, T value, int lineNum, int colNum, int end) {
        this.type = type;
        this.value = value;
        this.lineNum = lineNum;
        this.colNum = colNum;
        this.end = end;
    }

    static boolean isLetter(char c) {
        return (c <= 'z' && c >= 'a') ||
                (c <= 'Z' && c >= 'A');
    }

    static boolean isSign(char c) {
        return c == '+' ||
                c == '-';
    }

    static boolean isDelimiter(char c) {
        return Character.isWhitespace(c) ||
                c == '(' ||
                c == ')' ||
                c == '\"' ||
                c == ';' ||
                c == '\r' ||
                c == '\n';
    }

    static int digitToInt(char c) {
        return c - '0';
    }

    static boolean isDigit(char c) {
        return c <= '9' && c >= '0';
    }

    static boolean isDelimiterOrEOF(String line, int index) {
        if (index >= line.length())
            return true;
        return isDelimiter(line.charAt(index));
    }

    public TokenType getType() {
        return type;
    }

    T getValue() {
        return value;
    }

    public int getLineNum() {
        return lineNum;
    }

    public int getColNum() {
        return colNum;
    }

    public int getEnd() {
        return end;
    }
}

enum TokenType {
    Identifier,
    Boolean,
    Number,
    Character,
    String,
    Punctuator,
    EOF
}

class EOFToken extends Token<Object> {
    EOFToken(int lineNum) {
        super(TokenType.EOF, null, lineNum, 0, 0);
    }
}

class BooleanToken extends Token<Boolean> {
    private BooleanToken(boolean value, int lineNum, int colNum, int end) {
        super(TokenType.Boolean, value, lineNum, colNum, end);
    }

    static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiterOrEOF(line, start + 2);
    }

    static BooleanToken lex(String line, int start, int lineNum) {
        if (!isBoolean(line, start)) throw new LexerException("not a boolean");
        int end = start + 2;
        if (line.charAt(start + 1) == 't') {
            return new BooleanToken(true, lineNum, start, end);
        } else {
            return new BooleanToken(false, lineNum, start, end);
        }
    }
}

class CharToken extends Token<String> {
    private CharToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Character, value, lineNum, colNum, end);
    }

    static boolean isCharacter(String line, int start) {
        return (line.startsWith("#\\", start) && isDelimiterOrEOF(line, start + 3)) ||
                (line.startsWith("#\\space", start) && isDelimiterOrEOF(line, start + 7)) ||
                (line.startsWith("#\\newline", start) && isDelimiterOrEOF(line, start + 9));
    }

    static CharToken lex(String line, int start, int lineNum) {
        if (!isCharacter(line, start)) throw new LexerException("not a character");
        int end = 0;
        String value = null;
        if (isDelimiterOrEOF(line, start + 3)) {
            end = start + 3;
            value = line.substring(start, end);
        }
        if (line.startsWith("#\\space", start)) {
            end = start + 7;
            value = "#\\space";
        }
        if (line.startsWith("#\\newline", start)) {
            end = start + 9;
            value = "#\\newline";
        }
        return new CharToken(value, lineNum, start, end);
    }
}

class StringToken extends Token<String> {
    private StringToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.String, value, lineNum, colNum, end);
    }

    static boolean isString(String line, int start) {
        return line.charAt(start) == '\"' &&
                (start == 0 || line.charAt(start - 1) != '\\');
    }

    private static boolean isEscape(char c) {
        return c == '\"' ||
                c == '\\';
    }

    static StringToken lex(String line, int start, int lineNum) {
        for (int i = start; i < line.length(); i++) {
            if (line.charAt(i) == '\"') {
                int end = i + 1;
                return new StringToken(line.substring(start, end - 1), lineNum, start, end);
            }
            if (line.charAt(i) == '\\') {
                char next = line.charAt(i + 1);
                if (isEscape(next)) {
                    i++;
                } else {
                    throw new LexerException("unrecognized escape sequence");
                }
            }
        }
        throw new LexerException("bad String token");
    }
}

class PunctuatorToken extends Token<String> {

    private PunctuatorToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Punctuator, value, lineNum, colNum, end);
    }

    private static boolean isTwoCharPunctuator(String line, int start) {
        return line.startsWith("#(", start) ||
                line.startsWith(",@", start);
    }

    private static boolean isSingleCharPunctuator(String line, int start) {
        char c = line.charAt(start);
        return c == '(' ||
                c == ')' ||
                c == ',' ||
                c == '\'' ||
                c == '`' ||
                c == ';';
    }

    static boolean isPunctuator(String line, int start) {
        return isSingleCharPunctuator(line, start) ||
                isTwoCharPunctuator(line, start);
    }

    static PunctuatorToken lex(String line, int start, int lineNum) {
        if (!isPunctuator(line, start))
            throw new LexerException("not a punctuator");
        int end = start;
        if (isSingleCharPunctuator(line, start)) {
            end = start + 1;
        }
        if (isTwoCharPunctuator(line, start)) {
            end = start + 2;
        }
        return new PunctuatorToken(line.substring(start, end), lineNum, start, end);
    }
}

class IdentifierToken extends Token<String> {

    private IdentifierToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Identifier, value, lineNum, colNum, end);
    }


    private static boolean isSpecialInitial(char c) {
        return c == '!' ||
                c == '$' ||
                c == '%' ||
                c == '&' ||
                c == '*' ||
                c == '/' ||
                c == ':' ||
                c == '<' ||
                c == '=' ||
                c == '>' ||
                c == '?' ||
                c == '^' ||
                c == '_' ||
                c == '~' ||
                c == '+' ||
                c == '-' ||
                c == '.' ||
                c == '@';

    }

    private static boolean isInitial(char c) {
        return isLetter(c) || isSpecialInitial(c);
    }

    private static boolean isSpecialSubsequent(char c) {
        return c == '+' ||
                c == '-' ||
                c == '.' ||
                c == '@';
    }

    private static int isPeculiarId(String line, int start) {
        if ((line.charAt(start) == '+' || line.charAt(start) == '-') &&
                isDelimiterOrEOF(line, start + 1)) {
            return start + 1;
        }
        if (line.startsWith("...", start) && isDelimiterOrEOF(line, start + 3)) {
            return start + 3;
        }
        return -1;
    }

    private static int isNormalId(String line, int start) {
        int i;
        if (!isInitial(line.charAt(start)))
            return -1;
        char c;
        for (i = start + 1; i < line.length(); i++) {
            c = line.charAt(i);
            if (isInitial(c))
                continue;
            if (isDigit(c))
                continue;
            if (isSpecialSubsequent(c))
                continue;
            if (isDelimiter(c))
                return i;
            return -1;
        }
        return i;
    }

    static boolean isIdentifier(String line, int start) {
        return isPeculiarId(line, start) != -1 ||
                isNormalId(line, start) != -1;
    }

    static IdentifierToken lex(String line, int start, int lineNum) {
        int end = isPeculiarId(line, start);
        if (end == -1) {
            end = isNormalId(line, start);
        }
        if (end == -1) {
            throw new LexerException("not an identifier");
        }
        return new IdentifierToken(line.substring(start, end).toLowerCase(), lineNum, start, end);
    }

}

class NumberToken extends Token<SchemeNumber> {

    private static int tokenLineNum;
    private static int tokenColNum;
    private static String lexLine;

    private NumberToken(SchemeNumber value, int lineNum, int colNum, int end) {
        super(TokenType.Number, value, lineNum, colNum, end);
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
        //todo 不同的marker之间有什么区别？
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


    private static NumberToken readDecimalAfterPrefix(int start, boolean isPositive, boolean isExact) {
        return null;
    }

    private static NumberToken readDecimalNeedExactness(int start, boolean isPositive) {
        if (lexLine.startsWith("#i", start))
            return readDecimalAfterPrefix(start + 2, isPositive, false);
        if (lexLine.startsWith("#e", start))
            return readDecimalAfterPrefix(start + 2, isPositive, true);
        if (isDigit(lexLine.charAt(start))) {
            return readDecimalAfterPrefix(start, isPositive, true);
        }
        if (lexLine.charAt(start) == '.') {
            return readDecimalAfterPrefix(start, isPositive, false);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken readExact(int start, boolean isPositive) {
        if (lexLine.startsWith("#d", start))
            return readDecimalAfterPrefix(start + 2, isPositive, true);
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + ",)" + tokenColNum);
    }

    private static NumberToken readInexact(int start, boolean isPositive) {
        if (lexLine.startsWith("#d", start))
            return readDecimalAfterPrefix(start + 2, isPositive, false);
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken afterSuffix(int start, double readSoFar, char expMarker, boolean isPositive, int expValue) {
        if (isDelimiterOrEOF(lexLine, start)) {
            //todo return a real number
        }
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            int newExpValue = expValue * 10 + digitToInt(c);
            return afterSuffix(start + 1, readSoFar, expMarker, isPositive, newExpValue);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken readSuffixNeedDigit(int start, double readSoFar, char expMarker, boolean isPositive, int expValueSign) {
        char c = lexLine.charAt(start);
        if (isDigit(c)) {
            int expValue = expValueSign * digitToInt(c);
            return afterSuffix(start + 1, readSoFar, expMarker, isPositive, expValue);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken readSuffix(int start, double readSoFar, char expMarker, boolean isPositive) {
        char c = lexLine.charAt(start);
        if (c == '-') {
            return readSuffixNeedDigit(start + 1, readSoFar, expMarker, isPositive, -1);
        }
        if (c == '+') {
            return readSuffixNeedDigit(start + 1, readSoFar, expMarker, isPositive, 1);
        }
        if (isDigit(c)) {
            return readSuffixNeedDigit(start, readSoFar, expMarker, isPositive, 1);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken readSharp(int start, double readSoFar, boolean isPositive, boolean isAfterDot) {
        char c = lexLine.charAt(start);
        if (c == '#') {
            if (isAfterDot) {
                return readSharp(start + 1, readSoFar, isPositive, true);
            } else {
                return readSharp(start + 1, readSoFar * 10, isPositive, false);
            }
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, readSoFar, c, isPositive);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken afterDot(int start, double readSoFar, boolean isPositive, int exponent) {
        char c = lexLine.charAt(start);
        if (c == '#') {
            return readSharp(start + 1, readSoFar, isPositive, true);
        }
        if (isDigit(c)) {
            readSoFar = readSoFar + digitToInt(c) / Math.pow(10, exponent);
            return afterDot(start + 1, readSoFar, isPositive, exponent + 1);
        }
        if (isExponentMarker(c)) {
            return readSuffix(start + 1, readSoFar, c, isPositive);
        }
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken afterDotNeedDigit(int start, boolean isPositive) {
        char c = lexLine.charAt(start);
        if (isDigit(c))
            return afterDot(start + 1, digitToInt(c) / 10.0, isPositive, 1);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken beforeDot(int start, boolean isPositive, long readSoFar) {
        char c = lexLine.charAt(start);
        if (c == '#')
            return readSharp(start + 1, readSoFar * 10, isPositive, false);
        if (isExponentMarker(c))
            return readSuffix(start + 1, readSoFar, c, isPositive);
        if (isDigit(c))
            return beforeDot(start + 1, isPositive, readSoFar * 10 + digitToInt(c));
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken readPrefix(int start, boolean isPositive) {
        char first = lexLine.charAt(start);
        if (first == 'i') {
            return readInexact(start + 1, isPositive);
        }
        if (first == 'e') {
            return readExact(start + 1, isPositive);
        }
        if (first == 'd') {
            return readDecimalNeedExactness(start + 1, isPositive);
        }
        supportInFuture(start - 1);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    private static NumberToken afterReadSign(int start, boolean isPositive) {
        char c = lexLine.charAt(start);
        if (c == '#')
            return readPrefix(start + 1, isPositive);
        if (isDigit(c))
            return beforeDot(start + 1, isPositive, digitToInt(c));
        if (c == '.')
            return afterDotNeedDigit(start + 1, isPositive);
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }

    public static NumberToken lex(String line, int start, int lineNum) {
        //todo exactness的信息丢了。
        //todo 终结点缺少终结处理。
        //todo 复数。
        lexLine = line.toLowerCase();
        tokenLineNum = lineNum;
        tokenColNum = start;

        char first = line.charAt(start);
        if (first == '-') {
            return afterReadSign(start + 1, false);
        }
        if (first == '+') {
            return afterReadSign(start + 1, true);
        }
        if (first == '#') {
            return readPrefix(start + 1, true);
        }
        if (isDigit(first)) {
            return beforeDot(start + 1, true, digitToInt(first));
        }
        if (first == '.') {
            return afterDotNeedDigit(start + 1, true);
        }
        supportInFuture(start);
        throw new LexerException("bad number at (" + tokenLineNum + "," + tokenColNum + ")");
    }
}