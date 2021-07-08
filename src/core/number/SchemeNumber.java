package core.number;

public abstract class SchemeNumber {
    protected int getExponent10(double value) {
        String valueStr = Double.toString(value);
        for (int i = 1; i < valueStr.length(); i++) {
            if (valueStr.charAt(i) == '.')
                return valueStr.length() - i - 1;
        }
        return 0;
    }
    abstract SchemeNumber copy();
    public abstract double getValue();
    public abstract boolean isExact();

    public abstract SchemeNumber up();

    public abstract SchemeNumber down();

    public abstract SchemeNumber toExact();

    public abstract SchemeNumber toInexact();

}

