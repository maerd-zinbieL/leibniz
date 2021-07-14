package parse;

import exception.ParserException;

import java.io.IOException;

public class Parser {
    private final String sourceFile;
    private final Lexer lexer;

    private Parser(String sourceFile) throws IOException {
        this.sourceFile = sourceFile;
        lexer = Lexer.getInstance(sourceFile);
    }

    public static Parser getInstance(String sourceFile) throws IOException {
        return new Parser(sourceFile);
    }

    private ASTNode parseSimpleDatum(Token<?> token) {
        return new ASTNode(token);
    }

    private ASTNode parseCompoundDatum(Token<?> token) {
        return null;
    }

    private boolean isListStart(Token<?> token) {
        return token.getValue().equals("(");
    }

    private boolean isAbbrevPrefix(Token<?> token) {
        String value = (String) token.getValue();
        return value.equals(",@") ||
                value.equals(",") ||
                value.equals("`") ||
                value.equals("'");
    }

    private boolean isVectorStart(Token<?> token) {
        return token.getValue().equals("#(");
    }

    private boolean isCompoundDatum(Token<?> token) {
        if (!(token.getType() == TokenType.Punctuator))
            return false;
        return isListStart(token) ||
                isVectorStart(token) ||
                isAbbrevPrefix(token);
    }

    private boolean isSimpleDatum(Token<?> token) {
        TokenType type = token.getType();
        return type == TokenType.EOF ||
                type == TokenType.Boolean ||
                type == TokenType.Number ||
                type == TokenType.Character ||
                type == TokenType.String ||
                type == TokenType.Identifier;
    }

    public ASTNode parseProgram() throws IOException {
        ASTNode program = new ASTNode();
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            if (isSimpleDatum(token)) {
                program.addChild(parseSimpleDatum(token));
                token = lexer.nextToken();
                continue;
            }
            if (isCompoundDatum(token)) {
                program.addChild(parseCompoundDatum(token));
                token = lexer.nextToken();
                continue;
            }
            throw new ParserException("unknown expression in " + sourceFile);
        }
        program.addChild(parseSimpleDatum(token));
        return program;
    }

    public static void main(String[] args) throws IOException {
        String fileName = "./test-resources/parser/" + "parser-simple-test0.scm";
        Parser parser = new Parser(fileName);
        ASTNode program = parser.parseProgram();
    }
}
