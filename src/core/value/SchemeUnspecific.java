package core.value;

public class SchemeUnspecific extends SchemeValue<String> {
    @Override
    public String toString() {
        return "#unspecific";
    }

    @Override
    public String getJavaValue() {
        return "unspecific";
    }
}
