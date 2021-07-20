package parse.ast;

import core.exception.ParserException;
import org.jetbrains.annotations.NotNull;
import parse.token.Token;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ASTNode implements Iterable<ASTNode> {
    private final Token token;
    private final NodeType type;
    private final List<ASTNode> children;
    private int childrenCount;

    public ASTNode(NodeType type) {
        //非叶子节点
        this.type = type;
        this.token = null;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public ASTNode(Token token) {
        //叶子节点
        this.type = NodeType.SIMPLE;
        this.token = token;
        this.children = new ArrayList<>();
        childrenCount = 0;
    }

    public boolean isLeaf() {
        return token != null;
    }

    public NodeType getType() {
        return type;
    }

    public Token getToken() {
        return token;
    }

    public void addChild(ASTNode node) {
        if (isLeaf()) {
            throw new ParserException("syntax error");
        }
        childrenCount++;
        children.add(node);
    }

    public ASTNode getFirstChild() {
        if (isLeaf())
            return null;
        return children.get(0);
    }

    public ASTNode nextChild() {
        if (isLeaf())
            return null;
        ASTNode node = children.remove(0);
        childrenCount--;
        return node;
    }

    public int getChildrenCount() {
        return childrenCount;
    }

    private String getCode(ASTNode node) {
        if (node.isLeaf()) {
            //叶子节点
            assert node.token != null;
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
