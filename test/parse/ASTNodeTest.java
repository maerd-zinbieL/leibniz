package parse;

import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class ASTNodeTest {

    @Test
    public void testToString1() throws IOException {
        String fileName = "./test-resources/parser/" + "parser-list-test0.scm";
        Parser parser = Parser.getInstance(fileName);

        ASTNode expression1 = parser.parseExpression();
        assertEquals("( list 1 2 3 ) ", expression1.toString());

        ASTNode expression2 = parser.parseExpression();
        assertEquals("( * 1 2 ) ", expression2.toString());

        ASTNode expression3 = parser.parseExpression();
        assertEquals("( square 2 ) ", expression3.toString());

        ASTNode expression4 = parser.parseExpression();
        assertEquals("( ) ", expression4.toString());
    }

    @Test
    public void testToString2() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-simple-test0.scm";
        Parser parser = Parser.getInstance(fileName);
        ASTNode program = parser.parseProgram();
        assertEquals("false true 7.89 157/50   a b scheme lambda define x square EOF ",
                program.toString());
    }
}