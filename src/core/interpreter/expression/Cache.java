package core.interpreter.expression;

import core.env.Frame;
import core.exception.InterpreterException;
import core.exception.ParserException;
import core.value.SchemeClosure;
import core.value.SchemeValue;
import parse.ast.ASTNode;
import parse.ast.NodeType;

import java.util.Arrays;
import java.util.HashMap;

public class Cache implements Expression {
    private final Expression app;
    private boolean isReducible;

    public Cache(ASTNode node) {
        app = Expression.ast2Expression(getAppNode(node));
        if (!(app instanceof Application)) {
            throw new InterpreterException("invalid context for " + app);
        }
        isReducible = false;
    }

    private ASTNode getAppNode(ASTNode node) {
        return node.getChild(2);
    }

    public static boolean isCache(ASTNode node) {
        return node.getType() == NodeType.LIST &&
                node.getChildrenCount() == 4 &&
                node.getChild(1).toString().equals("cache");
    }

    @Override
    public boolean isReducible() {
        return isReducible;
    }

    @Override
    public Expression reduce(Frame env) {
        Application.setCache(new Store());
        Expression result = app.reduce(env);
        isReducible = false;
        Application.setCache(null);
        return result;
    }

    @Override
    public SchemeValue<?> eval(Frame env) {
        Application.setCache(new Store());
        SchemeValue<?> result =  app.eval(env);
        Application.setCache(null);
        return result;
    }

    static class Store {
        private final HashMap<String, SchemeValue<?>> resultCache;

        public Store() {
            this.resultCache = new HashMap<>();
        }

        private String calcKey(SchemeValue<?>[] arguments, SchemeClosure operator) {
            return operator + ":" + Arrays.toString(arguments);
        }

        public SchemeValue<?> getResult(SchemeValue<?>[] arguments, SchemeClosure operator) {
            String key = calcKey(arguments, operator);
            return resultCache.get(key);
        }

        public void cacheResult(SchemeValue<?>[] arguments, SchemeClosure operator, SchemeValue<?> result) {
            String key = calcKey(arguments, operator);
            resultCache.put(key, result);
        }
    }

}
