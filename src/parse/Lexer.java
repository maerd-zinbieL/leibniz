package parse;

import core.exception.LexerException;
import parse.token.*;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.LinkedList;
import java.util.Queue;

public class Lexer {
    private final Queue<Token> tokensBuffer;
    private final LineNumberReader lineNumberReader;
    private final String sourceFile;

    private Lexer(File file) throws IOException {
        sourceFile = file.getCanonicalPath();
        tokensBuffer = new LinkedList<>();
        lineNumberReader =
                new LineNumberReader(new FileReader(file));
    }

    private Lexer(String line, int lineNum) {
        sourceFile = "<Standard Input>";
        lineNumberReader = null;
        tokensBuffer = new LinkedList<>();
        lexLine(line, lineNum);
    }

    protected static Lexer getFileLexer(String sourceFile) throws IOException {
        File file = new File(sourceFile);
        return new Lexer(file);
    }

    protected static Lexer getLineLexer(String line, int lineNum) {
        if (line.length() == 0 || line.startsWith(";")) //空白行和注释行应该报错
            throw new IllegalArgumentException();
        return new Lexer(line, lineNum);
    }

    public String getSourceFile() {
        return sourceFile;
    }

    private void lexLine(String line, int lineNum) {
        if (line == null)
            throw new IllegalArgumentException();
        int current = 0;
        Token token;
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
                    "bad token at (" + lineNum + "," + current + ") " +
                            "in line: \n" + line + "\n in file " + sourceFile);
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

    private void fillBufferIfEmpty() throws IOException {
        if (lineNumberReader == null)   // 如果是lineLexer，那么不需要填充tokensBuffer
            return;
        while (tokensBuffer.size() == 0) {
            String line = nextLine();
            int lineNum = getLineNum();
            if (line == null) {
                tokensBuffer.add(new EOFToken(lineNum));
                return;
            }
            lexLine(line, lineNum);
        }
    }

    public Token nextToken() throws IOException {
        fillBufferIfEmpty();
        return tokensBuffer.poll();
    }

    public Token peekToken() throws IOException {
        fillBufferIfEmpty();
        return tokensBuffer.peek();
    }
}
