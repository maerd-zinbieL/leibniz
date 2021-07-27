package core.value;

public class SchemeNil extends SchemeValue<Object> {
    @Override
    public Object getJavaValue() {
        return null;
    }

    @Override
    public String toString() {
        return "'()";
    }
}
