package parse.token;

import core.exception.LexerException;
import core.value.SchemeBoolean;

public class BooleanToken extends Token {
    private final SchemeBoolean value;

    BooleanToken(SchemeBoolean value, int lineNum, int colNum, int end) {
        super(TokenType.Boolean, lineNum, colNum, end);
        this.value = value;
    }

    public SchemeBoolean getSchemeValue() {
        return value;
    }

    @Override
    public String toString() {
        return value.toString();
    }

    public static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiterOrEOF(line, start + 2);
    }

    public static BooleanToken lex(String line, int start, int lineNum) {
        if (!isBoolean(line, start)) throw new LexerException("not a boolean");
        int end = start + 2;
        if (line.charAt(start + 1) == 't') {
            return new BooleanToken(new SchemeBoolean(true), lineNum, start, end);
        } else {
            return new BooleanToken(new SchemeBoolean(false), lineNum, start, end);
        }
    }

}