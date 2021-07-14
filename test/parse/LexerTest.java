package parse;

import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.util.Objects;

public class LexerTest {
    Lexer lexer;

    @Test
    public void nextToken() throws IOException {
        File dir = new File(TestUtil.TEST_SICP_FILES_PATH);
        for (String fileName : Objects.requireNonNull(dir.list())) {
            if (fileName.endsWith(".scm")) {
                lexer = Lexer.getInstance(TestUtil.TEST_SICP_FILES_PATH + fileName);
                System.out.println("++++++++++++++++++++++++++++++++++++++++++");
                System.out.println(fileName);
                Token<?> token = lexer.nextToken();
                while (token.getType() != TokenType.EOF) {
//                    System.out.print(token.getValue());
                    token = lexer.nextToken();
                }
                System.out.println("\n++++++++++++++++++++++++++++++++++++++++++");
            }
        }
    }
}