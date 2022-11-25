// Note: originally from: https://salesforce.stackexchange.com/a/187316
public class RC4 {
	private String key;

	public RC4(final String key) {
		if (key.length() < 1 || key.length() > 32) {
			throw new IllegalArgumentException('Key must be between 1 and 256 bits (Between 1 and 32 bytes/chars)');
		}
		this.key = key;
	}

	public Integer[] encrypt(final Integer[] content) {
		final Integer[] s = new Integer[256];
		final Integer[] k = new Integer[256];

		final Integer[] keyChars = key.getChars();
		final Integer keylength = keyChars.size();

		for (Integer i = 0; i < 256; i++) {
			s[i] = i;
			k[i] = keyChars[Math.mod(i, keylength)];
		}

		Integer j = 0;
		Integer tmp = 0;
		for (Integer i = 0; i < 256; i++) {
			j = Math.mod((j + s[i] + k[i]), 256);
			tmp = s[i];
			s[i] = s[j];
			s[j] = tmp;
		}

		final Integer contentSize = content.size();
		final Integer[] cipher = new List<Integer>(contentSize);

		Integer i = 0;
		j = 0;
		Integer z = 0;

		for (Integer l = 0; l < contentSize; l++) {
			i = Math.mod((l + 1), 256);
			j = Math.mod((j + s[i]), 256);
			tmp = s[i];
			s[i] = s[j];
			s[j] = tmp;
			z = s[Math.mod((s[i] + s[j]), 256)];

			cipher[l] = z ^ content[l];
		}
		return cipher;
	}

	public Integer[] decrypt(final Integer[] cipher) {
		return encrypt(cipher);
	}
}
