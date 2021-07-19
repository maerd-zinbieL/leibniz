package core.value;

public abstract class SchemeValue<T>{
    protected T value;

    public abstract T getJavaValue();
}
