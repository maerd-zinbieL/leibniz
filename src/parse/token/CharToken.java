package parse.token;

import exception.LexerException;

public class CharToken extends Token<Character> {
    CharToken(Character value, int lineNum, int colNum, int end) {
        super(TokenType.Character, value, lineNum, colNum, end);
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
        return new CharToken(value, lineNum, start, end);
    }

    @Override
    public String toString() {
        return Character.toString(getValue());
    }
}