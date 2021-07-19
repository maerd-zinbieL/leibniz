package parse.token;

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
                c == ']' ||
                c == '[' ||
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

    public T getValue() {
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

    @Override
    public String toString() {
        return "token";
    }
}