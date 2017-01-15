public class BooleanExpressionEvaluation {

	public static void evaluateBoolean(String expression) {
		Stack ops = new Stack();
		Stack vals = new Stack();

		// The expression must be space sepearted
		List<String> expList = expression.split(' ');

		String comStr = 'True False ( ) AND OR';
		if (!expression.containsOnly(comStr)) { // true: contains something ugly
			throw new ErrorException('0 Error : ' + expression);
		}

		for (Integer i = 0; i < expList.size() - 1; i++) {
			String s = expList.get(i);
			
			if (expList.get(i).equals(')') && expList.get(i + 1).equals('(')) {
				throw new ErrorException('1 Error : ' + s);
			} else if (expList.get(i).equals('(') && expList.get(i + 1).equals(')')) {
				throw new ErrorException('2 Error : ' + s);
			} else if ((expList.get(i).equals('AND') || expList.get(i).equals('OR')) && expList.get(i + 1).equals(')')) {
				throw new ErrorException('3 Error : ' + s);
			} else if (expList.get(i).equals('(') && (expList.get(i + 1).equals('AND') || expList.get(i + 1).equals('OR'))) {
				throw new ErrorException('4 Error : ' + s);
			}

			if (s.equals('(')) { }
			else if (s.equals('AND')) { ops.push(s); }
			else if (s.equals('OR'))  { ops.push(s); }
			else if (s.equals(')')) {
				String op = (String) ops.pop(); // either OR or AND
				Boolean v =  (Boolean) vals.pop(); // either False or True - after convertion from Strin to Boolean
				if (op.equals('AND')) { v = Boolean.valueOf(vals.pop()) && Boolean.valueOf(v); }
				else if (op.equals('OR')) {  v = Boolean.valueOf(vals.pop()) || Boolean.valueOf(v); }
				else { throw new ErrorException('5 Error : ' + s); }
				vals.push(v);
			} else if (s.equalsIgnoreCase('True') || s.equalsIgnoreCase('False')) {
				vals.push(Boolean.valueOf(s));
			} 
		}
		System.debug('The vals.pop() is: ' + vals.pop());
	}

	public static String cleanExpression(String expression) {

		String comStr = '1 2 3 4 5 6 7 8 9 0 ( ) AND OR';
		if (!expression.containsOnly(comStr)) { // true: contains something ugly
			throw new ErrorException('0 Error : ' + expression);
		}

		List<String> expList = expression.split(' ');
		System.debug('The explist is : ' + expList);

		List<String> indvsExp   = new List<String>();

		
		for (Integer i = 0; i < expList.size(); i++) {
			System.debug(expList.get(i));

			// The usual cases
			if (expList.get(i).isNumeric() && (expList.get(i + 1).equalsIgnoreCase('AND') || expList.get(i + 1).equalsIgnoreCase('OR'))) {
				indvsExp.add(expList.get(i));
			} else if ((expList.get(i).equalsIgnoreCase('AND') || expList.get(i).equalsIgnoreCase('OR')) &&  expList.get(i + 1).isNumeric()) {
				indvsExp.add(expList.get(i + 1));
			} else if ((expList.get(i).equalsIgnoreCase('AND') || expList.get(i).equalsIgnoreCase('OR')) && expList.get(i + 1).equals('(')) {
				indvsExp.add(expList.get(i));
			} else if (expList.get(i).isNumeric()) {
				indvsExp.add(expList.get(i));
			} else if (expList.get(i).equalsIgnoreCase('AND')) {
				indvsExp.add('AND');
			} else if (expList.get(i).equalsIgnoreCase('OR')) {
				indvsExp.add('OR');
			} else if (expList.get(i).equals('(')) {
				indvsExp.add('(');
			} else if (expList.get(i).equals(')')) {
				indvsExp.add(')');
			} else {
				System.debug('ERROR: ' + expList.get(i));
				//throw new ErrorException('Error in parsing the expression - should be seperated by spaces');
			}
		}

		System.debug('indvsExp are: '   + indvsExp);

		// Add spaces 
		return NULL;

	}



	

	private class ErrorException extends Exception {

	}

	









	
	
} // end BooleanExpressionEvaluation class