package parse;

import exception.LexerException;

import java.io.*;
import java.util.*;

public class Lexer {
    private static Lexer lexer;
    private final Queue<Token<?>> tokensBuffer = new LinkedList<>();
    private LineNumberReader lineNumberReader;

    private Lexer(String sourceFile) throws IOException {
        lineNumberReader =
                new LineNumberReader(new FileReader(sourceFile));
    }

    protected static synchronized Lexer getInstance(String sourceFile) throws IOException {
        if (lexer == null)
            lexer = new Lexer(sourceFile);
        return lexer;
    }

    private void lexLine(String line, int lineNum) throws IOException {
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
            }
            if (StringToken.isString(line, current)) {
                token= StringToken.lex(line, current+1, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
        }
    }

    private String nextLine() throws IOException {
        String line = lineNumberReader.readLine();
        if (line == null) {
            lineNumberReader.close();
        }
        return line;
    }

    private int getLineNum() {
        return lineNumberReader.getLineNumber();
    }

    protected Token<?> nextToken() throws IOException {
        if (tokensBuffer.isEmpty()) {
            String line = nextLine();
            int lineNum = getLineNum();
            if (line == null) {
                return new EOFToken(lineNum);
            }
            lexLine(line, lineNum);
        }
        return tokensBuffer.poll();
    }
}
