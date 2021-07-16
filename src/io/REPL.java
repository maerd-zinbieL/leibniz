package io;

import javax.swing.*;
import java.awt.*;
import java.net.URL;
import java.util.Objects;

public class REPL extends JFrame {
    private final JFrame box;
    private final Container boxContainer;
    private final int WIDTH = 900;
    private final int HEIGHT = 618;
    private final int VGAP = 10;
    private final int HGAP = 10;
    private final int PROMPT_WIDTH = 30;
    private final int INPUT_LINE_HEIGHT = 30;
    private final int INPUT_START_X = PROMPT_WIDTH + HGAP;
    private final int INPUT_WIDTH = WIDTH - 60;
    private int outputHeight = 50;
    private final Font font;
    private int lineY;

    public REPL() {
        box = new JFrame();
        boxContainer = box.getContentPane();
        font = new Font("JetBrains Mono", Font.BOLD, 20);
        lineY = 50;
        init();
        input();
    }

    private void init() {
        box.setVisible(true);
        box.setResizable(false);
        box.setSize(WIDTH, HEIGHT);
        box.setResizable(false);
        box.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        URL url = REPL.class.getResource("./scheme.png");
        ImageIcon imageIcon = new ImageIcon(
                Objects.requireNonNull(url));
        box.setIconImage(imageIcon.getImage());

        boxContainer.setBackground(Color.darkGray);
        FlowLayout layout = new FlowLayout();
        layout.setVgap(VGAP);
        layout.setHgap(HGAP);
        boxContainer.setLayout(layout);

        Label welcome = new Label("Leibniz Scheme Version 0.0.1 ");
        welcome.setForeground(Color.white);
        welcome.setFont(font);
        welcome.setBounds(0, 0, WIDTH, lineY);
        welcome.setBackground(Color.DARK_GRAY);
        welcome.setVisible(true);
        boxContainer.add(welcome, FlowLayout.LEFT);
    }

    private void input() {
        // TODO: 2021/7/17 add icon
        Label prompt = new Label("> ");
        prompt.setForeground(Color.white);
        prompt.setFont(font);
        prompt.setBounds(0, lineY, PROMPT_WIDTH, INPUT_LINE_HEIGHT);
        prompt.setBackground(Color.DARK_GRAY);
        prompt.setVisible(true);
        boxContainer.add(prompt, FlowLayout.LEFT);

        JTextField input = new JTextField();
        input.setBackground(Color.darkGray);
        input.setForeground(Color.white);
        input.setVisible(true);
        input.setBounds(INPUT_START_X, lineY, INPUT_WIDTH, INPUT_LINE_HEIGHT);
        input.setFont(font);

//        input.setBorder(new LineBorder(Color.white));
        input.addActionListener(e -> {
            input.setEditable(false);
            input.setBorder(null);
            String expr = input.getText();
            lineY = lineY + INPUT_LINE_HEIGHT + VGAP;
            output(expr);
        });
        boxContainer.add(input, FlowLayout.CENTER);

    }

    private void output(String result) {
        Label prompt = new Label("=> ");
        prompt.setForeground(Color.white);
        prompt.setFont(font);
        prompt.setBounds(0, lineY, PROMPT_WIDTH, outputHeight);
        prompt.setBackground(Color.DARK_GRAY);
        prompt.setVisible(true);
        boxContainer.add(prompt, FlowLayout.LEFT);

        Label output = new Label(result);
        output.setBackground(Color.darkGray);
        output.setForeground(Color.white);
        output.setVisible(true);
        output.setBounds(INPUT_START_X, lineY, INPUT_WIDTH, outputHeight);
        output.setFont(font);
        boxContainer.add(output, FlowLayout.CENTER);

        lineY = lineY + outputHeight + VGAP;

        input();
    }

    public static void main(String[] args) {
        new REPL();
    }
}
