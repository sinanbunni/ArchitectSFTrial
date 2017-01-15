public with sharing class InfixValidation {
	
	public static Boolean isInfix(String expr) {

		List<String> stringArray = expr.split(' ');
		System.debug('The stringArray is: ' + stringArray);

		for (Integer i = 0; i < stringArray.size(); i++) {
			System.debug('The string in array is: ' + stringArray[i]);

			if(stringArray[i].isNumeric()) {

			} else {
				if (stringArray[i].length() == 1) {
					String op = stringArray[i].substring(0, 1);
					System.debug('the operation is: ' + op);
					if (op.equals('+')) { break; }
					else if (op.equals('*')) { break; } 
					else if (op.equals('/')) { break; }
					else if (op.equals('-')) { break; }
					else {
						return false;
					}
				}
			}
		}

		if (! checkParenthesis(stringArray)) {
			return false;
		}

		return isIn(stringArray, 0, stringArray.size() - 1);
	} // end isInfix method


	private static boolean checkParenthesis(List<String> stringArray) {

		Integer parentCount = 0;

		for (Integer i = 1; i < stringArray.size() - 1; i++) {
			if (stringArray[i].substring(0, 1).equals('(')) {
				parentCount++;
			}

			if (stringArray[i].substring(0, 1).equals(')')) {
				parentCount--;
			}
		}

		System.debug('the parenth count is: ' + parentCount);
		return parentCount == 0;

	} // end checkParenthesis method


	private static Boolean isIn(List<String> stringArray, Integer start, Integer enda) {

		Integer middleOpLoc = findMiddle(stringArray, start, enda);

		if (middleOpLoc == -2) {
			return false;
		}

		if (middleOpLoc == -1) {
			return true;
		}

		return isIn(stringArray, start + 1, middleOpLoc - 1) && 
			   isIn(stringArray, middleOpLoc + 1, enda - 1);

	}


	private static Integer findMiddle(List<String> stringArray, Integer start, Integer enda) {
		if (start == enda) {
			if (!isOp(stringArray[start].substring(0, 1))) {
				return -1;
			}
		}

		Integer parentCount = 0;
		start++;
		enda--;

		while (!(start >= enda)) {
			if (stringArray[start].substring(0, 1).equals('(')) {
				parentCount++;
			} else if (stringArray[start].substring(0, 1).equals(')')) {
				parentCount--;
			} else if (parentCount == 0) {
				if (isOp(stringArray[start].substring(0, 1))) {
					return start;
				} else if (isOp(stringArray[start + 1].substring(0, 1)) && !isOp(stringArray[start].substring(0, 1))) {
					return start + 1;
				}
			}

			start++;
		}

		return -2;
	}

	private static boolean isOp(String s) {
		return s == '+' || 
		       s == '-' || 
		       s == '*' || 
		       s == '/';
	}















}