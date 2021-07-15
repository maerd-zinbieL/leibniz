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

    private ASTNode parseVector(Token<?> token) {
        return null;
    }

    private boolean isListEnd(Token<?> token) {
        return token.getType() == TokenType.Punctuator &&
                token.getValue().equals(")");
    }

    private void parseNormalList(ASTNode list) throws IOException {
        Token<?> token = lexer.nextToken();
        while (!isListEnd(token)) {
            list.addChild(parseExpression(token));
            token = lexer.nextToken();
        }
        assert isListEnd(token);
        list.addChild(new ASTNode(token));
    }

    private ASTNode parseAbbreviation(Token<?> token) {
        return null;
    }

    private ASTNode parseCompoundDatum(Token<?> token) throws IOException {
        if (isVectorStart(token)) {
            return parseVector(token);
        }
        if (isNormalListStart(token)) {
            ASTNode list = new ASTNode("list");
            list.addChild(new ASTNode(token));
            parseNormalList(list);
            return list;
        }
        if (isAbbrevStart(token)) {
            return parseAbbreviation(token);
        }
        throw new ParserException("unknown expression in " + sourceFile);
    }

    private boolean isNormalListStart(Token<?> token) {
        return token.getValue().equals("(");
    }

    private boolean isAbbrevStart(Token<?> token) {
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
        return isNormalListStart(token) ||
                isVectorStart(token) ||
                isAbbrevStart(token);
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

    private ASTNode parseExpression(Token<?> token) throws IOException {
        assert token.getType() != TokenType.EOF;
        if (isSimpleDatum(token)) {
            return parseSimpleDatum(token);
        }
        if (isCompoundDatum(token)) {
            return parseCompoundDatum(token);
        }
        throw new ParserException("unknown expression in " + sourceFile);
    }
    public ASTNode parseExpression() throws IOException {
        Token<?> token = lexer.nextToken();
        return parseExpression(token);
    }

    public ASTNode parseProgram() throws IOException {
        ASTNode program = new ASTNode("program");
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            program.addChild(parseExpression(token));
            token = lexer.nextToken();
        }
        program.addChild(parseSimpleDatum(token));
        return program;
    }

    public static void main(String[] args) throws IOException {
        String fileName = "./test-resources/parser/" + "parser-list-test0.scm";
        Parser parser = new Parser(fileName);
        ASTNode expression1 = parser.parseExpression();
        System.out.println(expression1.toString());
        ASTNode expression2 = parser.parseExpression();
        System.out.println(expression2.toString());

        ASTNode expression3 = parser.parseExpression();
        System.out.println(expression3.toString());
        ASTNode expression4 = parser.parseExpression();
        System.out.println(expression4.toString());
    }
}
