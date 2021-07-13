package parse;

import exception.LexerException;

import java.io.*;
import java.util.*;

public class Lexer {
    private final Queue<Token<?>> tokensBuffer;
    private final LineNumberReader lineNumberReader;
    private final String sourceFile;

    private Lexer(String sourceFile) throws IOException {
        this.sourceFile = sourceFile;
        tokensBuffer = new LinkedList<>();
        lineNumberReader =
                new LineNumberReader(new FileReader(sourceFile));
    }

    protected static Lexer getInstance(String sourceFile) throws IOException {
        return new Lexer(sourceFile);
    }

    private void lexLine(String line, int lineNum) {
        if (line == null)
            throw new IllegalArgumentException();
        int current = 0;
        Token<?> token;
        while (current < line.length()) {
            char c = Character.toLowerCase(line.charAt(current));
            if (Character.isWhitespace(c)) {
                current++;
                continue;
            }
            if (c == ';') {
                break;
            }
            if (BooleanToken.isBoolean(line, current)) {
                token = BooleanToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (CharToken.isCharacter(line, current)) {
                token = CharToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (StringToken.isString(line, current)) {
                token = StringToken.lex(line, current + 1, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (IdentifierToken.isIdentifier(line, current)) {
                token = IdentifierToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (PunctuatorToken.isPunctuator(line, current)) {
                token = PunctuatorToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (NumberToken.isNumber(line, current)) {
                token = NumberToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            throw new LexerException(
                    "bad token at (" + lineNum + "," + current + ")" + " in file " + sourceFile);
        }
    }

    private String nextLine() throws IOException {
        String line = lineNumberReader.readLine();
        if (line == null) {
            lineNumberReader.close();
            return null;
        }
        while (line.length() == 0 || line.startsWith(";")) {
            //过滤空白和注释行
            line = lineNumberReader.readLine();
            if (line == null) {
                lineNumberReader.close();
                return null;
            }
        }
        return line;
    }

    private int getLineNum() {
        return lineNumberReader.getLineNumber();
    }

    public Token<?> nextToken() throws IOException {
        Token<?> token = tokensBuffer.poll();
        while (token == null) {
            String line = nextLine();
            int lineNum = getLineNum();
            if (line == null) {
                return new EOFToken(lineNum);
            }
            lexLine(line, lineNum);
            token = tokensBuffer.poll();
        }
        return token;
    }

    public static void main(String[] args) throws IOException {
        String fileName = "./test-resources/sicp/exer5-38-d.scm";
        Lexer lexer = getInstance(fileName);
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            System.out.println(token.getValue());
            token = lexer.nextToken();
        }
    }
}
