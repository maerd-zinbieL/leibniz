package io;

import core.interpreter.REPLEval;

import javax.swing.*;
import java.awt.*;
import java.net.URL;
import java.util.Objects;

public class REPL extends JFrame {
    private final JFrame box;
    private final Container boxContainer;
    private final int FRAME_WIDTH = 1000;
    private final int FRAME_HEIGHT = 618;
    private final int V_GAP = 10;
    private final int H_GAP = 10;
    private final int PROMPT_WIDTH = 30;
    private final int INPUT_LINE_HEIGHT = 30;
    private final int OUTPUT_INPUT_START_X = PROMPT_WIDTH + H_GAP;
    private final int INPUT_WIDTH = FRAME_WIDTH - 60;
    private final int TEXT_OUTPUT_HEIGHT = 50;
    private final Font font;
    private final int INIT_Y = 50;
    private final REPLEval REPLEval;
    private int currentY;

    public REPL() {
        box = new JFrame();
        boxContainer = box.getContentPane();
        font = new Font("JetBrains Mono", Font.BOLD, 20);
        REPLEval = new REPLEval();
        currentY = INIT_Y;
        init();
    }

    public static void main(String[] args) {
        new REPL();
    }

    private void init() {
        box.setVisible(true);
        box.setResizable(false);
        box.setSize(FRAME_WIDTH, FRAME_HEIGHT);
        box.setResizable(false);
        box.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        box.setLayout(null);
        URL url = REPL.class.getResource("./scheme.png");
        ImageIcon imageIcon = new ImageIcon(
                Objects.requireNonNull(url));
        box.setIconImage(imageIcon.getImage());

        boxContainer.setBackground(Color.darkGray);

        REPLLabel welcome = new REPLLabel
                ("Leibniz Scheme Version 0.0.1 ", 0, 0, FRAME_WIDTH, currentY, font);
        boxContainer.add(welcome, FlowLayout.LEFT);

        input();

    }

    private void checkCurrentY(int height) {
        if (currentY + height + V_GAP >= FRAME_HEIGHT) {
            for (Component component : boxContainer.getComponents()) {
                boxContainer.remove(component);
            }
            currentY = INIT_Y;
            boxContainer.revalidate();
            boxContainer.repaint();
            boxContainer.setLayout(null);
        }
    }

    private void input() {
        checkCurrentY(INPUT_LINE_HEIGHT);
        REPLLabel prompt = new REPLLabel("> ", 0, currentY, PROMPT_WIDTH, INPUT_LINE_HEIGHT, font);
        boxContainer.add(prompt, FlowLayout.LEFT);

        REPLInputField input = new REPLInputField
                (OUTPUT_INPUT_START_X, currentY, INPUT_WIDTH, INPUT_LINE_HEIGHT, font);
        input.addActionListener(e -> {
            input.setEditable(false);
            input.setBorder(null);
            String result = null;
            String inputText = input.getText();
            try {
                result = REPLEval.evalLine(inputText);
            } catch (Exception | Error exception) {

                result = exception.toString();
                String msg = exception.getMessage();
                if (msg != null) {
                    result = result + " : " + msg;
                }
            } finally {
                currentY = currentY + INPUT_LINE_HEIGHT + V_GAP;
                textOutput(result);
            }

        });
        boxContainer.add(input, FlowLayout.CENTER);
        input.requestFocus();

    }

    private void textOutput(String result) {
        checkCurrentY(TEXT_OUTPUT_HEIGHT);
        REPLLabel prompt = new REPLLabel
                ("=> ", 0, currentY, PROMPT_WIDTH, TEXT_OUTPUT_HEIGHT, font);
        boxContainer.add(prompt, FlowLayout.LEFT);

        REPLLabel output = new REPLLabel
                (result, OUTPUT_INPUT_START_X, currentY, INPUT_WIDTH, TEXT_OUTPUT_HEIGHT, font);
        boxContainer.add(output, FlowLayout.CENTER);

        currentY = currentY + TEXT_OUTPUT_HEIGHT + V_GAP;
        input();
    }
}

class REPLLabel extends Label {
    // TODO: 2021/7/17 add icon
    public REPLLabel(String text, int x, int y, int width, int height, Font font) {
        super(text);
        setForeground(Color.white);
        setFont(font);
        setBounds(x, y, width, height);
        setBackground(Color.DARK_GRAY);
        setVisible(true);
    }
}

class REPLInputField extends JTextField {
    public REPLInputField(int x, int y, int width, int height, Font font) {
        grabFocus();
        requestFocus();
        setBackground(Color.darkGray);
        setForeground(Color.white);
        setCaretColor(Color.WHITE);
        setVisible(true);
        setBounds(x, y, width, height);
        setFont(font);
    }
}