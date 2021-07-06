package parse;

import core.number.SchemeNumber;
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
    Punctuator ,
    EOF
}

class EOFToken extends Token<Object> {
    protected EOFToken(int lineNum) {
        super(TokenType.EOF, null, lineNum, 0, 0);
    }
}

class BooleanToken extends Token<Boolean> {
    private BooleanToken(boolean value, int lineNum, int colNum, int end) {
        super(TokenType.Boolean, value, lineNum, colNum, end);
    }

    protected static boolean isBoolean(String line, int start) {
        return (line.startsWith("#t", start) || line.startsWith("#f", start)) &&
                isDelimiterOrEOF(line, start + 2);
    }

    protected static BooleanToken lex(String line, int start, int lineNum) {
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

    protected static boolean isCharacter(String line, int start) {
        return (line.startsWith("#\\", start) && isDelimiterOrEOF(line, start + 3)) ||
                (line.startsWith("#\\space", start) && isDelimiterOrEOF(line, start + 7)) ||
                (line.startsWith("#\\newline", start) && isDelimiterOrEOF(line, start + 9));
    }

    protected static CharToken lex(String line, int start, int lineNum) {
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

    protected static boolean isString(String line, int start) {
        return line.charAt(start) == '\"' &&
                (start == 0 || line.charAt(start - 1) != '\\');
    }

    private static boolean isEscape(char c) {
        return c == '\"' ||
                c == '\\';
    }

    protected static StringToken lex(String line, int start, int lineNum) {
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

    PunctuatorToken(String value, int lineNum, int colNum, int end) {
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

    protected static boolean isPunctuator(String line, int start) {
        return isSingleCharPunctuator(line, start) ||
                isTwoCharPunctuator(line, start);
    }

    protected static PunctuatorToken lex(String line, int start, int lineNum) {
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

    IdentifierToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Identifier, value, lineNum, colNum, end);
    }

    private static boolean isLetter(char c) {
        return (c <= 'z' && c >= 'a') ||
                (c <= 'Z' && c >= 'A');
    }

    private static boolean isDigit(char c) {
        return c <= '9' && c >= '0';
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
            return start+1;
        }
        if (line.startsWith("...", start) && isDelimiterOrEOF(line, start + 3)) {
            return start+3;
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

    protected static boolean isIdentifier(String line, int start) {
        return isPeculiarId(line, start) != -1 ||
                isNormalId(line, start) != -1;
    }

    protected static IdentifierToken lex(String line, int start, int lineNum) {
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
class NumberToken extends Token<SchemeNumber>  {

    NumberToken(SchemeNumber value, int lineNum, int colNum, int end) {
        super(TokenType.Number, value, lineNum, colNum, end);
    }
}