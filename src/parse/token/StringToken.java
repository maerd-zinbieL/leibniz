package parse.token;

import core.exception.LexerException;
import core.value.SchemeString;

public class StringToken extends Token {
    private final SchemeString value;
    StringToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.String, lineNum, colNum, end);
        this.value = new SchemeString(value);
    }

    public SchemeString getSchemeValue() {
        return value;
    }
    public static boolean isString(String line, int start) {
        return line.charAt(start) == '\"' &&
                (start == 0 || line.charAt(start - 1) != '\\');
    }

    private static boolean isEscape(char c) {
        return c == '\"' ||
                c == '\\' ||
                c == 'n' ||
                c == 't' ||
                c == 'r';
    }

    public static StringToken lex(String line, int start, int lineNum) {
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
                    throw new LexerException("unrecognized escape sequence at (" + lineNum + "," + start + ")");
                }
            }
        }
        throw new LexerException("bad String token at (" + lineNum + "," + start + ")");
    }

    @Override
    public String toString() {
        return "\"" + value + "\"";
    }
}