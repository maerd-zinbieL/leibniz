package parse;

import core.exception.ParserException;
import parse.ast.ASTNode;
import parse.ast.NodeType;
import parse.token.IdentifierToken;
import parse.token.PunctuatorToken;
import parse.token.Token;
import parse.token.TokenType;

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

    public static ASTNode[] parseLine(String line, int lineNum) throws IOException {
        Parser parser = new Parser(Lexer.getLineLexer(line, lineNum));
        Token token = parser.nextToken();
        List<ASTNode> nodeList = new ArrayList<>();
        while (token != null) {
            nodeList.add(parser.parseExpression(token, false));
            token = parser.nextToken();
        }
        ASTNode[] nodes = new ASTNode[nodeList.size()];
        return nodeList.toArray(nodes);
    }

    public static ASTNode parseFile(String sourceFile) throws IOException {
        Parser parser = new Parser(Lexer.getFileLexer(sourceFile));
        return parser.parseProgram();
    }

    private Token nextToken() throws IOException {
        return lexer.nextToken();
    }

    private ASTNode parseSimpleDatum(Token token) {
        return new ASTNode(token);
    }

    private void parseVector(ASTNode vector, boolean isInQuote) throws IOException {
        Token token = nextToken();
        while (!isListEnd(token)) {

            if (isInQuote &&
                    token.getType() == TokenType.Punctuator &&
                    (token.toString().equals(",") || token.toString().equals(",@"))) {
                parseQuote(vector, token);
            } else {
                vector.addChild(parseExpression(token, isInQuote));
            }
            token = nextToken();
        }
        assert isListEnd(token);
        vector.addChild(new ASTNode(token));
    }

    private boolean isListEnd(Token token) {
        return token.getType() == TokenType.Punctuator &&
                token.getSchemeValue().toString().equals(")");
    }

    private boolean isDotList(Token token) {
        return token.getType() == TokenType.Punctuator &&
                token.toString().equals(".");
    }

    private void parseDotList(ASTNode list, boolean isInQuote) throws IOException {
        if (list.getChildrenCount() <= 2)
            throw new ParserException("unexpected dot " + sourceFile);
        Token token = nextToken();
        list.addChild(parseExpression(token, isInQuote));
        token = nextToken();
        if (isListEnd(token)) {
            list.addChild(new ASTNode(token));
        } else {
            throw new ParserException("more than one item found after dot in " + sourceFile);
        }
    }

    private void parseNormalList(ASTNode list, boolean isInQuote) throws IOException {
        Token token = nextToken();
        while (!isListEnd(token)) {
            if (isDotList(token)) {
                list.addChild(new ASTNode(token));
                parseDotList(list, isInQuote);
                return;
            }
            if (isInQuote &&
                    token.getType() == TokenType.Punctuator &&
                    (token.toString().equals(",") || token.toString().equals(",@"))) {
                parseQuote(list, token);
            } else {
                list.addChild(parseExpression(token, false));
            }
            token = nextToken();
        }
        assert isListEnd(token);
        list.addChild(new ASTNode(token));
    }

    private void parseQuote(ASTNode quote, Token token) throws IOException {
        if (token.getType() == TokenType.Punctuator &&
                token.toString().equals(",")) {
            quote.addChild(new ASTNode(
                    new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("unquote", -1, -1, -1)));
            quote.addChild(parseExpression(nextToken(), true));

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
            quote.addChild(parseExpression(nextToken(), true));
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
            return;
        }
        quote.addChild(parseExpression(token, true));
    }

    private void parseQuoteAbbrev(ASTNode quote, Token firstToken) throws IOException {
        String value = firstToken.toString();
        if (value.equals("'")) {
            quote.addChild(new ASTNode
                    (new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("quote", -1, -1, -1)));
            parseQuote(quote, nextToken());
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
        }
        if (value.equals("`")) {
            quote.addChild(new ASTNode
                    (new PunctuatorToken("(", -1, -1, -1)));
            quote.addChild(new ASTNode(
                    new IdentifierToken("quasiquote", -1, -1, -1)));
            parseQuote(quote, nextToken());
            quote.addChild(new ASTNode(
                    new PunctuatorToken(")", -1, -1, -1)));
        }
    }

    private ASTNode parseCompoundDatum(Token token, boolean isInQuote) throws IOException {
        if (isNormalListStart(token)) {
            // TODO: 2021/7/15 耦合度比较高
            ASTNode list = new ASTNode(NodeType.LIST);
            list.addChild(new ASTNode(token));
            parseNormalList(list, isInQuote);
            return list;
        }
        if (isVectorStart(token)) {
            ASTNode vector = new ASTNode(NodeType.VECTOR);
            vector.addChild(new ASTNode(token));
            parseVector(vector, isInQuote);
            return vector;
        }
        if (isQuoteAbbrevStart(token)) {
            ASTNode quote;
            if (token.toString().equals("'"))
                quote = new ASTNode(NodeType.QUOTE);
            else {
                quote = new ASTNode(NodeType.QUASIQUOTE);
            }
            parseQuoteAbbrev(quote, token);
            return quote;
        }
        throw new ParserException("unknown expression in " + sourceFile);
    }

    private boolean isNormalListStart(Token token) {
        return token.getType() == TokenType.Punctuator
                && token.getSchemeValue().toString().equals("(");
    }

    private boolean isQuoteAbbrevStart(Token token) {
        if (token.getType() != TokenType.Punctuator)
            return false;
        String value = token.toString();
        return value.equals("`") ||
                value.equals("'");
    }

    private boolean isVectorStart(Token token) {
        return token.getType() == TokenType.Punctuator &&
                token.getSchemeValue().toString().equals("#(");
    }

    private boolean isCompoundDatum(Token token) {
        if (!(token.getType() == TokenType.Punctuator))
            return false;
        return isNormalListStart(token) ||
                isVectorStart(token) ||
                isQuoteAbbrevStart(token);
    }

    private boolean isSimpleDatum(Token token) {
        TokenType type = token.getType();
        return type == TokenType.Boolean ||
                type == TokenType.Number ||
                type == TokenType.Character ||
                type == TokenType.String ||
                type == TokenType.Identifier;
    }

    private ASTNode parseExpression(Token token, boolean isInQuote) throws IOException {
        if (isSimpleDatum(token)) {
            return parseSimpleDatum(token);
        }
        if (isCompoundDatum(token)) {
            return parseCompoundDatum(token, isInQuote);
        }
        if (isInQuote &&
                token.getType() == TokenType.Punctuator &&
                (token.toString().equals(",") || token.toString().equals(",@"))) {
            ASTNode quote = new ASTNode(NodeType.QUOTE);
            parseQuote(quote, token);
            return quote;
        }
        throw new ParserException("syntax error in " + sourceFile + " token :" + token);
    }

    private ASTNode parseProgram() throws IOException {
        ASTNode program = new ASTNode(NodeType.PROGRAM);
        Token token = nextToken();
        while (token.getType() != TokenType.EOF) {
            program.addChild(parseExpression(token, false));
            token = nextToken();
        }
        assert token.getType() == TokenType.EOF;
        program.addChild(new ASTNode(token));
        return program;
    }
}
