package parser;

public class Token {
    private final TokenType type;
    private final String representation;
    private final int lineNum;
    private final int colNum;

    protected Token(TokenType type, String representation, int lineNum, int colNum) {
        this.type = type;
        this.representation = representation;
        this.lineNum = lineNum;
        this.colNum = colNum;
    }

    public static boolean isDelimiter(char c) {
        return Character.isWhitespace(c) ||
                c == '(' ||
                c == ')' ||
                c == '\"' ||
                c == ';';
    }

    public TokenType getType() {
        return type;
    }

    public String getRepresentation() {
        return representation;
    }

    public int getLineNum() {
        return lineNum;
    }

    public int getColNum() {
        return colNum;
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

class IdentifierToken extends Token {

    private IdentifierToken(String representation, int lineNum, int colNum) {
        super(TokenType.Identifier, representation, lineNum, colNum);
    }

    public static boolean isIdentifier(String line, int start) {
        return false;
    }

    public static Token getInstance(String line, int start, int lineNum, int colNum) {
        return null;
    }
}

class BooleanToken extends Token {
    private BooleanToken(String representation, int lineNum, int colNum) {
        super(TokenType.Boolean, representation, lineNum, colNum);
    }

    public static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiter(line.charAt(start + 2));
    }

    public static Token lex(String line, int start, int lineNum) {
        if (line.charAt(start + 1) == 't') {
            return new BooleanToken("#t", lineNum, start);
        } else {
            return new BooleanToken("#f", lineNum, start);
        }
    }
}

class CharToken extends Token {
    private CharToken(String representation, int lineNum, int colNum) {
        super(TokenType.Character, representation, lineNum, colNum);
    }

    public static boolean isCharacter(String line, int start) {
        return (line.startsWith("#\\", start) && isDelimiter(line.charAt(start + 3))) ||
                (line.startsWith("#\\space", start) && isDelimiter(line.charAt(start + 7))) ||
                (line.startsWith("#\\newline", start) && isDelimiter(line.charAt(start + 9)));
    }

    public static Token lex(String line, int start, int lineNum) {
        return null;
    }
}

class EOFToken extends Token {
    public EOFToken(String representation, int lineNum) {
        super(TokenType.EOF, representation, lineNum, 0);
    }
}