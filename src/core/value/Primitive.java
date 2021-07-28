package core.value;

public class Primitive extends SchemeValue<Object>{
    private final Action action;
    public interface Action {
        SchemeValue<?> apply(SchemeValue<?>[] arguments);
    }
    public Primitive(Action action) {
        this.action = action;
    }
    public SchemeValue<?> apply(SchemeValue<?>[] arguments) {
        return action.apply(arguments);
    }
    @Override
    public Object getJavaValue() {
        return this;
    }
}

