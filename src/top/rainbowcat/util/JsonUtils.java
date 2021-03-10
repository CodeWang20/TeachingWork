package top.rainbowcat.util;

import com.google.gson.Gson;

import java.io.PrintWriter;

public class JsonUtils {
    public void listToJson(Object o, PrintWriter out) {
        Gson gson = new Gson();
        String json = gson.toJson(o);
        out.println(json);
        out.flush();
        out.close();
    }

}
