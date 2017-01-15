public class PythonBooleanExpression {

    private final static Map<String, String> STR_TO_TOKEN = new Map<String, String>();
    private final static Boolean EMPTY_RESULT = true;

    public Map<String, String> stringToToken(Boolean left, Boolean right) {

        STR_TO_TOKEN.put('True', 'True');
        STR_TO_TOKEN.put('False', 'False');
        STR_TO_TOKEN.put('(', '(');
        STR_TO_TOKEN.put(')', ')');
        STR_TO_TOKEN.put('AND', AndExpression(left, right));
        STR_TO_TOKEN.put('OR', OrExpression(left, right));

        return STR_TO_TOKEN;

    }

    public String AndExpression(Boolean left, Boolean right) {
        String result;

        if (left && right) {
            result = 'True';
        } else {
            result = 'False';
        }

        return result;
    }

    public String OrExpression(Boolean left, Boolean right) {
        String result;

        if (left || right) {
            result = 'True';
        } else {
            result = 'False';
        }

        return result;
    }


    

































} // end PythonBooleanExpression class