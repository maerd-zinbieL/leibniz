package parse;

import exception.ParserException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Parser {
    private final String sourceFile;
    private final Lexer lexer;

    private Parser(Lexer lexer) {
        sourceFile = lexer.getSourceFile();
        this.lexer = lexer;
    }

    private Token<?> nextToken() throws IOException {
        return lexer.nextToken();
    }

    private Token<?> peekToken() throws IOException {
        return lexer.peekToken();
    }

    private ASTNode parseSimpleDatum(Token<?> token) {
        return new ASTNode(token);
    }

    private void parseVector(ASTNode vector) throws IOException {
        Token<?> token = nextToken();
        while (!isListEnd(token)) {
            vector.addChild(parseExpression(token));
            token = nextToken();
        }
        assert isListEnd(token);
        vector.addChild(new ASTNode(token));
    }

    private boolean isListEnd(Token<?> token) {
        return token.getType() == TokenType.Punctuator &&
                token.getValue().equals(")");
    }

    private boolean isDotList(Token<?> token, ASTNode list) {
        return token.getType() == TokenType.Punctuator &&
                token.toString().equals(".");
    }

    private void parseDotList(ASTNode list) throws IOException {
        if (list.getChildrenCount() <= 2)
            throw new ParserException("unexpected dot " + sourceFile);
        Token<?> token = nextToken();
        list.addChild(parseExpression(token));
        token = nextToken();
        if (isListEnd(token)) {
            list.addChild(new ASTNode(token));
        } else {
            throw new ParserException("more than one item found after dot in " + sourceFile);
        }
    }

    private void parseNormalList(ASTNode list) throws IOException {
        Token<?> token = nextToken();
        while (!isListEnd(token)) {
            if (isDotList(token, list)) {
                list.addChild(new ASTNode(token));
                parseDotList(list);
                return;
            } else {
                list.addChild(parseExpression(token));
            }
            token = nextToken();
        }
        assert isListEnd(token);
        list.addChild(new ASTNode(token));
    }

    private void parseQuote(ASTNode quote) throws IOException {
        Token<?> token = nextToken();
        if (token.getType() == TokenType.Punctuator &&
                token.toString().equals(",")) {
            quote.addChild(new ASTNode(
                    new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("unquote", -1, -1, -1)));
            quote.addChild(parseExpression(nextToken()));
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
            return;
        }
        if (token.getType() == TokenType.Punctuator &&
                token.toString().equals(",@")) {
            quote.addChild(new ASTNode(
                    new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("unquote-splicing", -1, -1, -1)));
            quote.addChild(parseExpression(nextToken()));
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
            return;
        }
        quote.addChild(parseExpression(token));
    }

    private void parseQuasiquote(ASTNode quasiquote) throws IOException {
        Token<?> token = nextToken();
        if (token.getType() == TokenType.Punctuator &&
                token.toString().equals(",")) {
            quasiquote.addChild(new ASTNode(
                    new PunctuatorToken("(", -1, -1, -1)));
            quasiquote.addChild(new ASTNode(
                    new IdentifierToken("unquote", -1, -1, -1)));
            quasiquote.addChild(parseExpression(nextToken()));
            quasiquote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
            return;
        }
        if (token.getType() == TokenType.Punctuator &&
                token.toString().equals(",@")) {
            quasiquote.addChild(new ASTNode(
                    new PunctuatorToken("(", -1, -1, -1)));
            quasiquote.addChild(new ASTNode(
                    new IdentifierToken("unquote-splicing", -1, -1, -1)));
            quasiquote.addChild(parseExpression(nextToken()));
            quasiquote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
            Token<?> nextToken = peekToken();
            if (nextToken.getType() != TokenType.Punctuator ||
                    nextToken.getValue().equals(")")) {
                throw new ParserException("syntax error");
            }
            return;
        }
        quasiquote.addChild(parseExpression(token));
    }

    private void parseQuoteAbbrev(ASTNode quote, Token<?> firstToken) throws IOException {
        String value = firstToken.toString();
        if (value.equals("'")) {
            quote.addChild(new ASTNode
                    (new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("quote", -1, -1, -1)));
            parseQuote(quote);
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
        }
        if (value.equals("`")) {
            quote.addChild(new ASTNode
                    (new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("quasiquote", -1, -1, -1)));
            parseQuasiquote(quote);
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
        }
    }

    private ASTNode parseCompoundDatum(Token<?> token) throws IOException {
        if (isNormalListStart(token)) {
            // TODO: 2021/7/15 耦合度比较高
            ASTNode list = new ASTNode("list");
            list.addChild(new ASTNode(token));
            parseNormalList(list);
            return list;
        }
        if (isVectorStart(token)) {
            ASTNode vector = new ASTNode("vector");
            vector.addChild(new ASTNode(token));
            parseVector(vector);
            return vector;
        }
        if (isQuoteAbbrevStart(token)) {
            ASTNode quote = new ASTNode("abbreviation");
            parseQuoteAbbrev(quote, token);
            return quote;
        }
        throw new ParserException("unknown expression in " + sourceFile);
    }

    private boolean isNormalListStart(Token<?> token) {
        return token.getType() == TokenType.Punctuator
                && token.getValue().equals("(");
    }

    private boolean isQuoteAbbrevStart(Token<?> token) {
        if (token.getType() != TokenType.Punctuator)
            return false;
        String value = (String) token.getValue();
        return value.equals("`") ||
                value.equals("'");
    }

    private boolean isVectorStart(Token<?> token) {
        return token.getType() == TokenType.Punctuator &&
                token.getValue().equals("#(");
    }

    private boolean isCompoundDatum(Token<?> token) {
        if (!(token.getType() == TokenType.Punctuator))
            return false;
        return isNormalListStart(token) ||
                isVectorStart(token) ||
                isQuoteAbbrevStart(token);
    }

    private boolean isSimpleDatum(Token<?> token) {
        TokenType type = token.getType();
        return type == TokenType.Boolean ||
                type == TokenType.Number ||
                type == TokenType.Character ||
                type == TokenType.String ||
                type == TokenType.Identifier;
    }

    private ASTNode parseExpression(Token<?> token) throws IOException {
        if (isSimpleDatum(token)) {
            return parseSimpleDatum(token);
        }
        if (isCompoundDatum(token)) {
            return parseCompoundDatum(token);
        }
        throw new ParserException("syntax error in " + sourceFile + " token :" + token);
    }

    private ASTNode parseProgram() throws IOException {
        ASTNode program = new ASTNode("program");
        Token<?> token = nextToken();
        while (token.getType() != TokenType.EOF) {
            program.addChild(parseExpression(token));
            token = nextToken();
        }
        assert token.getType() == TokenType.EOF;
        program.addChild(new ASTNode(token));
        return program;
    }

    public static ASTNode[] parseLine(String line, int lineNum) throws IOException {
        Parser parser = new Parser(Lexer.getLineLexer(line, lineNum));
        Token<?> token = parser.nextToken();
        List<ASTNode> nodeList = new ArrayList<>();
        while (token != null) {
            nodeList.add(parser.parseExpression(token));
            token = parser.nextToken();
        }
        ASTNode[] nodes = new ASTNode[nodeList.size()];
        return nodeList.toArray(nodes);
    }

    public static ASTNode parseFile(String sourceFile) throws IOException {
        Parser parser = new Parser(Lexer.getFileLexer(sourceFile));
        return parser.parseProgram();
    }

    public static void main(String[] args) throws IOException {
        ASTNode[] astNodes = Parser.parseLine("'(1 ,2 3)", 1);
        System.out.println(astNodes[0].toString());
    }
}
