package parse;

import exception.LexerException;

import java.io.*;
import java.util.*;

public class Lexer {
    private final Queue<Token<?>> tokensBuffer;
    private final LineNumberReader lineNumberReader;
    private final String sourceFile;

    private Lexer(File file) throws IOException {
        sourceFile = file.getCanonicalPath();
        tokensBuffer = new LinkedList<>();
        lineNumberReader =
                new LineNumberReader(new FileReader(file));
    }

    public String getSourceFile() {
        return sourceFile;
    }

    private Lexer(String line, int lineNum) {
        sourceFile = null;
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

    public Token<?> nextToken() throws IOException {
        Token<?> token = tokensBuffer.poll();
        while (token == null && lineNumberReader != null) {
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
        String fileName = "./test-resources/token/token-mixed-test1.scm";
        Lexer lexer = getFileLexer(fileName);
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            System.out.println(token.getValue());
            token = lexer.nextToken();
        }
        System.out.println(token.getValue());
    }
}
