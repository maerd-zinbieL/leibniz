package core.interpreter;

import core.env.Frame;
import core.env.InitEnv;
import core.interpreter.expression.Expression;
import core.value.SchemeValue;
import parse.Parser;
import parse.ast.ASTNode;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class REPLEval {
    private final Frame global;
    private int lineCount;

    public REPLEval() {
        lineCount = 0;
        global = InitEnv.getInstance();
    }

    public String evalLine(String line) throws IOException {
        if (line == null || line.equals("")) {
            lineCount++;
            return "";
        }
        List<SchemeValue<?>> result = new ArrayList<>();
        for (ASTNode node : Parser.parseLine(line, lineCount)) {
            Expression expr = Expression.ast2Expression(node);
            result.add(expr.eval(global));
        }
        lineCount++;
        StringBuilder sb = new StringBuilder();
        for (SchemeValue<?> value : result) {
            sb.append(value.toString());
            sb.append("\n");
        }
        return sb.toString();
    }
}
