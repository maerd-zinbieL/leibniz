package core.interpreter;

import core.value.SchemeClosure;
import core.value.SchemeValue;

import java.util.Arrays;
import java.util.HashMap;

public class Cache {
    private final HashMap<String, SchemeValue<?>> resultCache;

    public Cache() {
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
