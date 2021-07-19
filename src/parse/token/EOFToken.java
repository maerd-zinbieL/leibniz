package parse.token;

import core.value.SchemeIdentifier;

public class EOFToken extends Token {
    private final SchemeIdentifier value;

    public EOFToken(int lineNum) {
        super(TokenType.EOF, lineNum, 0, 0);
        this.value = new SchemeIdentifier("EOF");
    }

    public SchemeIdentifier getSchemeValue() {
        return value;
    }

    @Override
    public String toString() {
        return "EOF";
    }
}