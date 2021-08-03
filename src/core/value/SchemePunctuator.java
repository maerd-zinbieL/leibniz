package core.value;

public class SchemePunctuator extends SchemeValue<String> {
    public SchemePunctuator(String value) {
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
