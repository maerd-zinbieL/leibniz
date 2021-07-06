package core.number;

public class SchemeRational implements SchemeNumber<SchemeReal, SchemeInteger> {
    private final long p;
    private final long q;

    public SchemeRational(long p, long q) {
        this.p = p;
        this.q = q;
    }

    @Override
    public SchemeReal up() {
        return new SchemeReal((double) p / q);
    }

    @Override
    public SchemeInteger down() {
        return new SchemeInteger((int) (p / q));
    }
}
