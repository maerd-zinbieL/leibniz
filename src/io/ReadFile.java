package io;

import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.ArrayList;
import java.util.List;

public class ReadFile {
    static public String[] getLines(String fileName) throws IOException {
        List<String> lineList = new ArrayList<>();
        LineNumberReader lr = new LineNumberReader(new FileReader(fileName));
        String line = lr.readLine();
        while (line != null) {
            lineList.add(line);
            line = lr.readLine();
        }
        lr.close();
        String[] lines = new String[lineList.size()];
        return lineList.toArray(lines);
    }
}
