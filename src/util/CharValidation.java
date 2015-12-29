package util;

public class CharValidation {

	public boolean validate(String args) {

		for (int i = 0; i < 10; i++) {
			if (args.contains(String.valueOf(i))) {
				return true;
			}
		}
		return false;
	}

	public boolean validateEmail(String args) {

		if (args.contains("@") && args.contains(".")) {
			return false;
		} else {
			return true;
		}
	}
}
