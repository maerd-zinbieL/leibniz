package parse.token;

import core.exception.LexerException;
import core.value.SchemeCharacter;

public class CharToken extends Token {
    private final SchemeCharacter value;

    CharToken(SchemeCharacter value, int lineNum, int colNum, int end) {
        super(TokenType.Character, lineNum, colNum, end);
        this.value = value;
    }

    public static boolean isCharacter(String line, int start) {
        return (line.startsWith("#\\", start) && isDelimiterOrEOF(line, start + 3)) ||
                (line.startsWith("#\\space", start) && isDelimiterOrEOF(line, start + 7)) ||
                (line.startsWith("#\\newline", start) && isDelimiterOrEOF(line, start + 9));
    }

    public static CharToken lex(String line, int start, int lineNum) {
        if (!isCharacter(line, start)) throw new LexerException("not a character");
        int end = 0;
        char value = '\000';
        if (isDelimiterOrEOF(line, start + 3)) {
            end = start + 3;
            value = line.charAt(start + 2);
        }
        if (line.startsWith("#\\space", start)) {
            end = start + 7;
            value = ' ';
        }
        if (line.startsWith("#\\newline", start)) {
            end = start + 9;
            value = '\n';
        }
        if (value == '\000')
            throw new LexerException("bad character at (" + lineNum + "," + end + ")");
        return new CharToken(new SchemeCharacter(value), lineNum, start, end);
    }

    public SchemeCharacter getSchemeValue() {
        return value;
    }

    @Override
    public String toString() {
        return value.toString();
    }

}