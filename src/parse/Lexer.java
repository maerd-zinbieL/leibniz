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
                BooleanToken token = BooleanToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
                continue;
            }
            if (CharToken.isCharacter(line, current)) {
                CharToken token = CharToken.lex(line, current, lineNum);
                tokensBuffer.add(token);
                current = token.getEnd();
            }
            if (StringToken.isOpenString(line, current)) {
                // 因为一个StringToken可能存在多行，所以写得有点复杂。
                int startColNum = current;
                int startLineNum = lineNum;

                int end = StringToken.isStringClosed(line.substring(current + 1));
                StringBuilder finalSting = new StringBuilder();
                if (end == -1) {
                    finalSting.append(line.substring(current + 1));
                    while (end == -1) {
                        line = nextLine();
                        lineNum++;
                        if (line == null) {
                            throw new LexerException("bad string at (" + startLineNum + ", " + startColNum + ")");
                        }
                        end = StringToken.isStringClosed(line);
                        if (end == -1) {
                            finalSting.append(line);
                        } else {
                            finalSting.append(line, 0, end);
                        }
                    }
                } else {
                    finalSting.append(line, current + 1, end);
                }

                StringToken token =
                        StringToken.lex(finalSting.toString(), startLineNum, startColNum, end);
                tokensBuffer.add(token);
                current = end;
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

    public static void main(String[] args) throws IOException {
        String fileName = "/home/toorevitimirp/Desktop/leibniz/leibniz/test-resources/"
                + "string-token-test0.scm";
        Lexer lexer = Lexer.getInstance(fileName);
        Token<?> token = lexer.nextToken();
        while (token.getType() != TokenType.EOF) {
            System.out.println("fuck");
            System.out.println(token.getValue());
            token = lexer.nextToken();
        }
    }

}
