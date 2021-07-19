package core.value;

public class SchemeIdentifier extends SchemeValue<String > {
    public SchemeIdentifier(String value) {
        this.value = value;
    }
    @Override
    public String getJavaValue() {
        return value;
    }

    @Override
    public String toString() {
        return value;
    }
}
