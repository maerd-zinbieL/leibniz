package parse.token;

import core.exception.LexerException;
import core.value.SchemePunctuator;

public class PunctuatorToken extends Token {

    private final SchemePunctuator value;

    public PunctuatorToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Punctuator, lineNum, colNum, end);
        this.value = new SchemePunctuator(value);
    }

    public SchemePunctuator getSchemeValue() {
        return value;
    }

    private static boolean isTwoCharPunctuator(String line, int start) {
        return line.startsWith("#(", start) ||
                line.startsWith(",@", start);
    }

    private static boolean isSingleCharPunctuator(String line, int start) {
        char c = line.charAt(start);
        return c == '(' ||
                c == ')' ||
                c == '[' ||
                c == ']' ||
                c == ',' ||
                c == '\'' ||
                c == '`' ||
                (c == '.' && isDelimiterOrEOF(line, start + 1)) ||
                c == ';';
    }

    public static boolean isPunctuator(String line, int start) {
        return isSingleCharPunctuator(line, start) ||
                isTwoCharPunctuator(line, start);
    }

    public static PunctuatorToken lex(String line, int start, int lineNum) {
        if (!isPunctuator(line, start))
            throw new LexerException("not a punctuator");
        int end = start;
        String value = "";
        if (isSingleCharPunctuator(line, start)) {
            end = start + 1;
            value = line.substring(start, end);
            if (value.equals("["))
                value = "(";
            if (value.equals("]"))
                value = ")";
        }
        if (isTwoCharPunctuator(line, start)) {
            end = start + 2;
            value = line.substring(start, end);
        }
        return new PunctuatorToken(value, lineNum, start, end);
    }

    @Override
    public String toString() {
        return value.toString();
    }
}