package core.value;

public class SchemeCharacter extends SchemeValue<Character> {

    public SchemeCharacter(char value) {
        this.value = value;
    }

    @Override
    public Character getJavaValue() {
        return value;
    }

    @Override
    public String toString() {
        return Character.toString(value);
    }
}
