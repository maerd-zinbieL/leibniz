package parse;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ASTNode implements Iterable<ASTNode> {
    private final Token<?> token;
    private final List<ASTNode> children;
    private int childrenCount;

    public ASTNode() {
        token = null;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public ASTNode(Token<?> token) {
        this.token = token;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public Token<?> getToken() {
        return token;
    }

    public void addChild(ASTNode node) {
        childrenCount++;
        children.add(node);
    }

    public int getChildrenCount() {
        return childrenCount;
    }

    @NotNull
    @Override
    public Iterator<ASTNode> iterator() {
        return children.iterator();
    }
}
