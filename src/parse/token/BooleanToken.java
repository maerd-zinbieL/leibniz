package parse.token;

import exception.LexerException;

public class BooleanToken extends Token<Boolean> {
    BooleanToken(boolean value, int lineNum, int colNum, int end) {
        super(TokenType.Boolean, value, lineNum, colNum, end);
    }

    public static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiterOrEOF(line, start + 2);
    }

    public static BooleanToken lex(String line, int start, int lineNum) {
        if (!isBoolean(line, start)) throw new LexerException("not a boolean");
        int end = start + 2;
        if (line.charAt(start + 1) == 't') {
            return new BooleanToken(true, lineNum, start, end);
        } else {
            return new BooleanToken(false, lineNum, start, end);
        }
    }

    @Override
    public String toString() {
        if (getValue()) {
            return "true";
        } else {
            return "false";
        }
    }
}