public class Integers {
	private static final String[] DIGITS = new List<String>{
		'0',
		'1',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'a',
		'b',
		'c',
		'd',
		'e',
		'f',
		'g',
		'h',
		'i',
		'j',
		'k',
		'l',
		'm',
		'n',
		'o',
		'p',
		'q',
		'r',
		's',
		't',
		'u',
		'v',
		'w',
		'x',
		'y',
		'z'
	};

	private static final Integer SHIFT = 4;

	public static String toHexString(Integer i) {
		Integer charPos = 32;
		final String[] buf = new List<String>(charPos);
		final Integer radix = 1 << SHIFT;
		final Integer mask = radix - 1;

		do {
			buf[--charPos] = DIGITS[i & mask];
			i >>>= SHIFT;
		} while (i != 0);

		String result = '';
		for (Integer pos = charPos; pos < 32; pos++) {
			result += buf[pos];
		}

		return result;
	}
}
