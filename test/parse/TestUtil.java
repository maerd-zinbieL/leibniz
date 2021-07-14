package parse;

import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.util.ArrayList;
import java.util.List;

public class TestUtil {
    public final static String TEST_TOKEN_FILES_PATH = "./test-resources/token/";
    public final static String TEST_SICP_FILES_PATH = "./test-resources/sicp/";
    public final static String TEST_PARSER_FILES_PATH = "./test-resources/parser/";
    public static String[] getTestContents(String fileName) throws IOException {
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
