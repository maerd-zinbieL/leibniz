package parse.token;

public class EOFToken extends Token<String> {
    public EOFToken(int lineNum) {
        super(TokenType.EOF, "EOF", lineNum, 0, 0);
    }

    @Override
    public String toString() {
        return "EOF";
    }
}