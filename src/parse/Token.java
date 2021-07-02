package parse;

import exception.LexerException;

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

    protected static boolean isDelimiter(char c) {
        return Character.isWhitespace(c) ||
                c == '(' ||
                c == ')' ||
                c == '\"' ||
                c == ';' ||
                c == '\r' ||
                c == '\n';
    }

    protected static boolean isDelimiterOrEOF(String line, int index) {
        if (index >= line.length())
            return true;
        return isDelimiter(line.charAt(index));
    }

    public TokenType getType() {
        return type;
    }

    protected T getValue() {
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

class BooleanToken extends Token<Boolean> {
    private int end = 0;

    private BooleanToken(boolean value, int lineNum, int colNum, int end) {
        super(TokenType.Boolean, value, lineNum, colNum, end);
    }

    protected static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiterOrEOF(line, start + 2);
    }

    protected static BooleanToken lex(String line, int start, int lineNum) {
        if (!isBoolean(line, start)) throw new IllegalArgumentException();
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

    protected static boolean isCharacter(String line, int start) {
        return (line.startsWith("#\\", start) && isDelimiterOrEOF(line, start + 3)) ||
                (line.startsWith("#\\space", start) && isDelimiterOrEOF(line, start + 7)) ||
                (line.startsWith("#\\newline", start) && isDelimiterOrEOF(line, start + 9));
    }

    protected static CharToken lex(String line, int start, int lineNum) {
        if (!isCharacter(line, start)) throw new IllegalArgumentException();
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

    protected static boolean isOpenString(String line, int start) {
        return line.charAt(start) == '\"';
    }

    protected static int isStringClosed(String line) {
        for (int i = 0; i < line.length(); i++) {
            if (line.charAt(i) == '\\') {
                char next = line.charAt(i + 1);
                if (next == '\"' || next == '\\') {
                    i++;
                } else {
                    throw new LexerException("unrecognized escape sequence");
                }
            }
            if (line.charAt(i) == '\"') {
                return i + 1;
            }
        }
        return -1;
    }

    protected static StringToken lex(String line, int lineNum, int start , int end) {
        return new StringToken(line, lineNum, start, end);
//        throw new LexerException("bad string at (" + lineNum + ", " + start + ")");
    }
}

class EOFToken extends Token<Object> {
    protected EOFToken(int lineNum) {
        super(TokenType.EOF, null, lineNum, 0, 0);
    }
}