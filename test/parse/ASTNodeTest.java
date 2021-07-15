package parse;

import io.ReadFile;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class ASTNodeTest {

    @Test
    public void testToString1() throws IOException {
        String fileName = "./test-resources/parser/" + "parser-list-test0.scm";
        String[] lines = ReadFile.getLines(fileName);

        ASTNode expression1 = Parser.parseLine(lines[0], 1)[0];
        assertEquals("( list 1 2 3 ) ", expression1.toString());

        ASTNode expression2 =Parser.parseLine(lines[1], 2)[0];
        assertEquals("( * 1 2 ) ", expression2.toString());

        ASTNode expression3 = Parser.parseLine(lines[2], 3)[0];
        assertEquals("( square 2 ) ", expression3.toString());

        ASTNode expression4 = Parser.parseLine(lines[3], 4)[0];
        assertEquals("( ) ", expression4.toString());
    }

    @Test
    public void testToString2() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-simple-test0.scm";
        ASTNode program = Parser.parseFile(fileName);
        assertEquals("false true 7.89 157/50   a b \"scheme\" \"lambda\" define x square EOF ",
                program.toString());
    }
}