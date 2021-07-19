package core.value;

public class SchemeString extends SchemeValue<String>{

    public SchemeString(String value) {
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
