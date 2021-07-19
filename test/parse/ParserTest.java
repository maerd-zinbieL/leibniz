package parse;

import exception.ParserException;
import io.ReadFile;
import org.junit.Test;
import parse.ast.ASTNode;
import parse.token.Token;
import parse.token.TokenType;

import java.io.IOException;

import static org.junit.Assert.*;

public class ParserTest {

    @Test
    public void parseSimple() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-simple-test0.scm";
        ASTNode program = Parser.parseFile(fileName);
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
    public void parseList1() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test1.scm";
        String[] lines = ReadFile.getLines(fileName);

        ASTNode expr1 = Parser.parseLine(lines[0], 1)[0];
        assertEquals("( 1 2 . 3 ) ", expr1.toString());

        ASTNode expr2 = Parser.parseLine(lines[1], 2)[0];
        assertEquals("( f x y . z ) ", expr2.toString());

        ASTNode expr3 = Parser.parseLine(lines[2], 3)[0];
        assertEquals("( + 1 2 ( * 3 4 5 ( f x ( g x y z )  )  )  ) ", expr3.toString());
    }

    @Test(expected = ParserException.class)
    public void parseDotListError1() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test2.scm";
        String[] lines = ReadFile.getLines(fileName);

        Parser.parseLine(lines[0], 1);
    }

    @Test(expected = ParserException.class)
    public void parseDotListError2() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test3.scm";
        String[] lines = ReadFile.getLines(fileName);

        Parser.parseLine(lines[0], 1);
    }

    @Test(expected = ParserException.class)
    public void parseDotListError3() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test4.scm";
        String[] lines = ReadFile.getLines(fileName);

        Parser.parseLine(lines[0], 1);
    }

    @Test
    public void parseVector() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-vector-test0.scm";
        String[] lines = ReadFile.getLines(fileName);

        ASTNode expr1 = Parser.parseLine(lines[0],1)[0];
        assertEquals("#( 1 2 3 ) ", expr1.toString());

        ASTNode expr2 = Parser.parseLine(lines[1],2)[0];
        assertEquals("#( 1 ( + 2 ( * 3 )  )  ) ", expr2.toString());

        ASTNode expr3 = Parser.parseLine(lines[2],3)[0];
        assertEquals("#( 1 #( \"a\" \"b\" )  ) ", expr3.toString());

        ASTNode expr4 = Parser.parseLine(lines[3],4)[0];
        assertEquals("#( ) ", expr4.toString());
    }

    @Test
    public void parseLine() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-list-test5.scm";
        String line = ReadFile.getLines(fileName)[0];
        ASTNode[] astNodes = Parser.parseLine(line, 1);
        assertEquals("( + 1 2 3 ) ", astNodes[0].toString());
        assertEquals("( * 5 6 ) ", astNodes[1].toString());
        assertEquals("( f x ( h ( z y )  )  ( g z )  ) ", astNodes[2].toString());

    }

    @Test
    public void parseQuote() throws IOException {
        String fileName = TestUtil.TEST_PARSER_FILES_PATH + "parser-quote-test0.scm";
        String[] lines = ReadFile.getLines(fileName);

        ASTNode quote = Parser.parseLine(lines[0], 1)[0];
        assertEquals("( quote x ) ",quote.toString());

        quote = Parser.parseLine(lines[1], 2)[0];
        assertEquals("( quote ( 1 x 3 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[2], 2)[0];
        assertEquals("( quote ( 1 ( unquote x ) 3 )  ) ",quote.toString());


        quote = Parser.parseLine(lines[3], 2)[0];
        assertEquals("( quote ( 1 ( unquote-splicing x ) 3 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[4], 2)[0];
        assertEquals("( quote ( 1 ( unquote x ) ( quote ( 1 2 x )  )  3 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[5], 2)[0];
        assertEquals("( quote ( 1 ( unquote x ) ( quote ( 1 2 ( unquote x ) )  )  3 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[6], 2)[0];
        assertEquals("( quote x ) ",quote.toString());

        quote = Parser.parseLine(lines[7], 2)[0];
        assertEquals("( quote ( unquote x ) ) ",quote.toString());

        quote = Parser.parseLine(lines[8], 2)[0];
        assertEquals("( quote ( unquote-splicing x ) ) ",quote.toString());

        quote = Parser.parseLine(lines[9], 2)[0];
        assertEquals("( quote #( 1 2 x )  ) ",quote.toString());

        quote = Parser.parseLine(lines[10], 2)[0];
        assertEquals("( quasiquote ( unquote-splicing x ) ) ",quote.toString());

        quote = Parser.parseLine(lines[11], 2)[0];
        assertEquals("( quasiquote ( unquote x ) ) ",quote.toString());

        quote = Parser.parseLine(lines[12], 2)[0];
        assertEquals("( quasiquote ( x )  ) ",quote.toString());

        quote = Parser.parseLine(lines[13], 2)[0];
        assertEquals("( quasiquote ( 1 2 ( unquote x ) )  ) ",quote.toString());

        quote = Parser.parseLine(lines[14], 2)[0];
        assertEquals("( quasiquote ( 1 2 ( unquote-splicing x ) )  ) ",quote.toString());

        quote = Parser.parseLine(lines[15], 2)[0];
        assertEquals("( quasiquote ( 1 2 ( unquote-splicing x ) 3 7 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[16], 2)[0];
        assertEquals("( quote #( ( unquote x ) )  ) ",quote.toString());

        quote = Parser.parseLine(lines[17], 2)[0];
        assertEquals("( quote #( 1 2 ( unquote x ) 5 )  ) ",quote.toString());

        quote = Parser.parseLine(lines[18], 2)[0];
        assertEquals("( quasiquote #( 1 2 ( unquote-splicing x ) ( quote ( 1 25 ( unquote x ) )  )  )  ) ",quote.toString());

        quote = Parser.parseLine(lines[19], 2)[0];
        assertEquals("( quote ( x ( unquote y ) ( unquote-splicing ( quasiquote ( z )  )  ) )  ) ",quote.toString());

        quote = Parser.parseLine(lines[20], 2)[0];
        assertEquals("( quote ( x ( unquote y ) ( unquote-splicing ( quasiquote ( z ( unquote-splicing x ) )  )  ) )  ) ",quote.toString());

    }
}