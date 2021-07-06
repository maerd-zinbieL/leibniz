package core.number;

public interface SchemeNumber<Up, Down> {
    boolean isExact();

    Up up();

    Down down();

}

