package parse;

import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class LexerTest {

    @Test
    public void nextToken() throws IOException {
        String fileName = "/home/toorevitimirp/Desktop/leibniz/leibniz/test-resources/"
                +"string-token-test0.scm";
        Lexer lexer = Lexer.getInstance(fileName);
        Token<?> token = lexer.nextToken();
//        while (token.getType()!=TokenType.EOF) {
//            System.out.println(token.getValue());
//            token = lexer.nextToken();
//        }
    }
}