package parser;

import java.io.*;
import java.util.*;

public class Lexer {
    private static Lexer lexer;
    private final Queue<Token> tokensBuffer = new LinkedList<>();
    private final LineNumberReader lineNumberReader;

    private Lexer(String sourceFile) throws IOException {
        lineNumberReader =
                new LineNumberReader(new FileReader(sourceFile));
    }

    public synchronized Lexer getInstance(String sourceFile) throws IOException {
        if (lexer == null)
            lexer = new Lexer(sourceFile);
        return lexer;
    }

    private void lexLine(String line, int lineNum) {
        if (line == null)
            throw new IllegalArgumentException();
        int current = 0;
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
                tokensBuffer.add(BooleanToken.lex(line, current, lineNum));
                current += 2;
                continue;
            }
            if (CharToken.isCharacter(line, current)) {

            }
        }
    }

    public Token nextToken() throws IOException {
        if (tokensBuffer.isEmpty()) {
            String line = lineNumberReader.readLine();
            int lineNum = lineNumberReader.getLineNumber();
            if (line == null) {
                lineNumberReader.close();
                return new EOFToken(null, lineNum);
            }
            lexLine(line, lineNum);
            return nextToken();
        }
        return tokensBuffer.remove();
    }

    public static void main(String[] args) {

    }

}
