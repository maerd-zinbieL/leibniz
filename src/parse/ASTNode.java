package parse;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ASTNode implements Iterable<ASTNode> {
    private final Token<?> token;
    private final String type;
    private final List<ASTNode> children;
    private int childrenCount;

    public ASTNode(String type) {
        //非叶子节点
        this.type = type;
        this.token = null;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public ASTNode(Token<?> token) {
        //叶子节点
        this.token = token;
        this.type = null;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public String getType() {
        return type;
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

    private String getCode(ASTNode node) {
        if (node.token != null) {
            //叶子节点
            return node.token.toString();
        } else {
            StringBuilder sb = new StringBuilder();
            for (ASTNode child : node.children) {
                sb.append(getCode(child));
                sb.append(" ");
            }
            return sb.toString();
        }
    }

    @NotNull
    @Override
    public Iterator<ASTNode> iterator() {
        return children.iterator();
    }

    @Override
    public String toString() {
        return getCode(this);
    }

}
