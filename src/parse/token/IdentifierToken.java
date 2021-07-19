package parse.token;

import core.exception.LexerException;
import core.value.SchemeIdentifier;
import core.value.SchemeString;
import io.ReadFile;

import java.io.IOException;

public class IdentifierToken extends Token {

    private final SchemeIdentifier value;
    public IdentifierToken(String value, int lineNum, int colNum, int end) {
        super(TokenType.Identifier,  lineNum, colNum, end);
        this.value = new SchemeIdentifier(value);
    }

    public SchemeIdentifier getSchemeValue() {
        return value;
    }

    private static boolean isSubsequent(String line, int start) {
        char c = line.charAt(start);
        return isInitial(line, start) ||
                isDigit(c) ||
                isSpecialSubsequent(c);
    }

    private static boolean isSpecialInitial(String line, int start) {
        char c = line.charAt(start);
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
                (c == '.' && isSubsequent(line, start + 1)) || //单独的一个点应该是一个punctuator
                c == '@';
//                c == '|';

    }

    private static boolean isInitial(String line, int start) {
        char c = line.charAt(start);
        return isLetter(c) || isSpecialInitial(line, start);
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
            return start + 1;
        }
        if (line.startsWith("...", start) && isDelimiterOrEOF(line, start + 3)) {
            return start + 3;
        }
        return -1;
    }

    private static int isNormalId(String line, int start) {
        int i;
        if (!isInitial(line, start))
            return -1;
        char c;
        for (i = start + 1; i < line.length(); i++) {
            c = line.charAt(i);
            if (isSubsequent(line, i)) {
                continue;
            }
            if (isDelimiter(c))
                return i;
            return -1;
        }
        return i;
    }

    public static boolean isIdentifier(String line, int start) {
        return isPeculiarId(line, start) != -1 ||
                isNormalId(line, start) != -1;
    }

    public static IdentifierToken lex(String line, int start, int lineNum) {
        int end = isPeculiarId(line, start);
        if (end == -1) {
            end = isNormalId(line, start);
        }
        if (end == -1) {
            throw new LexerException("not an identifier");
        }
        return new IdentifierToken(
                line.substring(start, end).toLowerCase(),
                lineNum,
                start,
                end);
    }

    @Override
    public String toString() {
        return value.toString();
    }

}