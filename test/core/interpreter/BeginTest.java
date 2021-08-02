package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.value.SchemeValue;
import org.junit.Test;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;

import static org.junit.Assert.*;

public class BeginTest {

    @Test
    public void eval() throws IOException {
        Frame global = InitEnv.getInstance();
        String code = "(begin 1 2 3)";
        ASTNode node = Parser.parseLine(code, 1)[0];
        SchemeValue<?> result = Begin.eval(node, global);
        assertEquals(3.0, result.getJavaValue());
    }
}