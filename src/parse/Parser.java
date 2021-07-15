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

    private ASTNode parseSimpleDatum(Token<?> token) {
        return new ASTNode(token);
    }

    private void parseVector(ASTNode vector) throws IOException {
        Token<?> token = lexer.nextToken();
        while (!isListEnd(token)) {
            vector.addChild(parseExpression(token));
            token = lexer.nextToken();
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
        Token<?> token = lexer.nextToken();
        list.addChild(parseExpression(token));
        token = lexer.nextToken();
        if (isListEnd(token)) {
            list.addChild(new ASTNode(token));
        } else {
            throw new ParserException("more than one item found after dot in " + sourceFile);
        }
    }

    private void parseNormalList(ASTNode list) throws IOException {
        Token<?> token = lexer.nextToken();
        while (!isListEnd(token)) {
            if (isDotList(token, list)) {
                list.addChild(new ASTNode(token));
                parseDotList(list);
                return;
            } else {
                list.addChild(parseExpression(token));
            }
            token = lexer.nextToken();
        }
        assert isListEnd(token);
        list.addChild(new ASTNode(token));
    }

    private ASTNode parseAbbreviation(Token<?> token) {
        return null;
    }

    private ASTNode parseCompoundDatum(Token<?> token) throws IOException {
        if (isNormalListStart(token)) {
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
        if (isAbbrevStart(token)) {
            return parseAbbreviation(token);
        }
        throw new ParserException("unknown expression in " + sourceFile);
    }

    private boolean isNormalListStart(Token<?> token) {
        return token.getType() == TokenType.Punctuator
                && token.getValue().equals("(");
    }

    private boolean isAbbrevStart(Token<?> token) {
        if (token.getType() != TokenType.Punctuator)
            return false;
        String value = (String) token.getValue();
        return value.equals(",@") ||
                value.equals(",") ||
                value.equals("`") ||
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
                isAbbrevStart(token);
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
        throw new ParserException("unknown expression in " + sourceFile);
    }

    private ASTNode parseProgram() throws IOException {
        ASTNode program = new ASTNode("program");
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            program.addChild(parseExpression(token));
            token = lexer.nextToken();
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

}
