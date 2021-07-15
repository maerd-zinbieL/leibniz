package parse;

import io.ReadFile;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.util.Objects;
import static org.junit.Assert.*;

public class LexerTest {
    Lexer lexer;

    @Test
    public void testFileLexer() throws IOException {
        File dir = new File(TestUtil.TEST_SICP_FILES_PATH);
        for (String fileName : Objects.requireNonNull(dir.list())) {
            if (fileName.endsWith(".scm")) {
                lexer = Lexer.getFileLexer(TestUtil.TEST_SICP_FILES_PATH + fileName);
                System.out.println(fileName);
                Token<?> token = lexer.nextToken();
                while (token.getType() != TokenType.EOF) {
                    System.out.print(token);
                    System.out.print(" ");
                    token = lexer.nextToken();
                }
                System.out.println(token);
                System.out.println("\n++++++++++++++++++++++++++++++++++++++++++");
            }
        }
    }

    @Test
    public void testLineLexer() throws IOException {
        File dir = new File(TestUtil.TEST_SICP_FILES_PATH);
        for (String fileName : Objects.requireNonNull(dir.list())) {
            if (fileName.endsWith(".scm")) {
                String[] lines = ReadFile.getLines(TestUtil.TEST_SICP_FILES_PATH + fileName);
                System.out.println(fileName);
                for (int i = 0; i < lines.length; i++) {
                    String line = lines[i];
                    if (line.length() == 0 || line.startsWith(";"))
                        continue;
                    lexer = Lexer.getLineLexer(line, i);
                    Token<?> token = lexer.nextToken();
                    while (token != null) {
                        System.out.print(token);
                        System.out.print(" ");
                        token = lexer.nextToken();
                    }
                }
                System.out.println("\n++++++++++++++++++++++++++++++++++++++++++");
            }
        }
    }

    @Test
    public void peekToken() throws IOException {
        Lexer lexer = Lexer.getLineLexer("(define x \"a\")", 1);
        Token<?> token = lexer.nextToken();
        assertEquals("(", token.toString());
        token = lexer.peekToken();
        assertEquals("define", token.toString());
        token = lexer.nextToken();
        assertEquals("define", token.toString());
    }
}