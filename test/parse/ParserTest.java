package parse;

import exception.ParserException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.Iterator;

import static org.junit.Assert.*;

public class ParserTest {

    @Test
    public void parseSimple() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-simple-test0.scm";
        Parser parser = Parser.getInstance(fileName);
        ASTNode program = parser.parseProgram();
        assertEquals(13, program.getChildrenCount());
        Token<?>[] tokens = new Token[program.getChildrenCount()];
        int i = 0;
        for (ASTNode child : program) {
            tokens[i] = child.getToken();
            i++;
        }

        assertEquals(TokenType.Boolean, tokens[0].getType());
        assertEquals(TokenType.Boolean, tokens[1].getType());
        assertEquals(TokenType.Number, tokens[2].getType());
        assertEquals(TokenType.Number, tokens[3].getType());
        assertEquals(TokenType.Character, tokens[4].getType());
        assertEquals(TokenType.Character, tokens[5].getType());
        assertEquals(TokenType.Character, tokens[6].getType());
        assertEquals(TokenType.String, tokens[7].getType());
        assertEquals(TokenType.String, tokens[8].getType());
        assertEquals(TokenType.Identifier, tokens[9].getType());
        assertEquals(TokenType.Identifier, tokens[10].getType());
        assertEquals(TokenType.Identifier, tokens[11].getType());


        assertEquals(false, tokens[0].getValue());
        assertEquals(true, tokens[1].getValue());
        assertEquals("7.89", tokens[2].getValue().toString());
        assertEquals("157/50", tokens[3].getValue().toString());
        assertEquals(' ', tokens[4].getValue());
        assertEquals('a', tokens[5].getValue());
        assertEquals('b', tokens[6].getValue());
        assertEquals("scheme", tokens[7].getValue());
        assertEquals("lambda", tokens[8].getValue());
        assertEquals("define", tokens[9].getValue());
        assertEquals("x", tokens[10].getValue());
        assertEquals("square", tokens[11].getValue());
    }

    @Test
    public void parseDotList() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test1.scm";
        Parser parser = Parser.getInstance(fileName);
        ASTNode expr1 = parser.parseExpression();
        assertEquals("( 1 2 . 3 ) ", expr1.toString());

        ASTNode expr2 = parser.parseExpression();
        assertEquals("( f x y . z ) ", expr2.toString());

        ASTNode expr3 = parser.parseExpression();
        assertEquals("( + 1 2 ( * 3 4 5 ( f x ( g x y z )  )  )  ) ", expr3.toString());
    }

    @Test(expected = ParserException.class)
    public void parseDotListError1() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test2.scm";
        Parser parser = Parser.getInstance(fileName);
        parser.parseExpression();
    }

    @Test(expected = ParserException.class)
    public void parseDotListError2() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test3.scm";
        Parser parser = Parser.getInstance(fileName);
        parser.parseExpression();
    }

    @Test(expected = ParserException.class)
    public void parseDotListError3() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test4.scm";
        Parser parser = Parser.getInstance(fileName);
        parser.parseExpression();
    }
}