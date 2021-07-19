//package core.eval;
//
//import core.eval.expression.Expression;
//import parse.ast.ASTNode;
//import parse.Parser;
//
//import java.io.IOException;
//
//public class Eval {
//    private int lineCount;
//    public Eval() {
//        lineCount = 0;
//    }
//    public String evalExpression(String line) throws IOException {
//        if (line == null || line.equals("")) {
//            lineCount++;
//            return "";
//        }
//        EvalResult result = new EvalResult();
//        for (ASTNode node : Parser.parseLine(line, lineCount)) {
//            result.addExpr(Expression.evalAST(node));
//        }
//        lineCount++;
//        return result.toString();
//    }
//}
