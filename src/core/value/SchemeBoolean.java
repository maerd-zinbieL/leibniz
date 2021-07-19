package core.value;

public class SchemeBoolean extends SchemeValue<Boolean> {

    public SchemeBoolean(boolean value) {
        this.value = value;
    }

    @Override
    public Boolean getJavaValue() {
        return value;
    }

    @Override
    public String toString() {
        if (value)
            return "true";
        else
            return "false";
    }
}
