@IsTest
class RC4Test {
	// Note: test scenario extracted from: https://gist.github.com/songzhiyong/8451195?permalink_comment_id=3108046#gistcomment-3108046
	@IsTest
	static void encryptAndDecrypt() {
		final String key = 'key';
		final String content = 'input';

		final RC4 rc4 = new RC4(key);

		// Encrypt
		final List<Integer> encryptedResult = rc4.encrypt(content.getChars());
		final List<String> encryptedHexResult = new List<String>();

		final String result = '62 02 44 98 50'; // Note: represented in bytes of 2 hexadecimals, as per the result of encryption with online tools
		List<Integer> expectedDecimalResult = new List<Integer>{ 98, 2, 68, 152, 80 }; // Note: representation of hexadecimal expected results, in decimal format

		for (Integer i = 0; i < encryptedResult.size(); i++) {
			Assert.areEqual(expectedDecimalResult[i], encryptedResult[i]);

			// Note: following approach does not work when the Decimal representation is greater than 127, since it exceeds ASCII. In this case, it fails for 152:
			// String hexEncryptedResult = EncodingUtil.convertToHex(Blob.valueOf(String.fromCharArray(new List<Integer>{ encryptedResult[i] })));

			// Note: alternatievely to the approach above, we use Integers class.
			// Note: since this class purely converts Integer to hexadecimal, but not to byte (which always has 2 Decimals), we manually add 0 if value is less than 15 (hexadecimal: f)
			String hexEncryptedResult = '';
			if (encryptedResult[i] < 16) {
				hexEncryptedResult = '0';
			}
			hexEncryptedResult += Integers.toHexString(encryptedResult[i]);
			encryptedHexResult.add(hexEncryptedResult);
		}

		Assert.areEqual(result, String.join(encryptedHexResult, ' '));

		// Decrypt
		List<Integer> decryptedResult = rc4.decrypt(encryptedResult);
		Assert.areEqual(content, String.fromCharArray(decryptedResult));
	}

	// Note: test scenario extracted from: https://sites.math.washington.edu/~nichifor/310_2008_Spring/Pres_RC4%20Encryption.pdf
	@IsTest
	static void encryptAndDecrypt2() {
		final String key = 'pwd12';
		final String content = 'Math 310 Proves!';

		final RC4 rc4 = new RC4(key);

		// Encrypt
		final List<Integer> encryptedResult = rc4.encrypt(content.getChars());
		final List<String> encryptedHexResult = new List<String>();

		final String result = '6c a8 6f e3 cb c3 3c 16 25 95 c3 e7 8b 9c 97 bc';

		for (Integer i = 0; i < encryptedResult.size(); i++) {
			String hexEncryptedResult = '';
			if (encryptedResult[i] < 16) {
				hexEncryptedResult = '0';
			}
			hexEncryptedResult += Integers.toHexString(encryptedResult[i]);
			encryptedHexResult.add(hexEncryptedResult);
		}

		Assert.areEqual(result, String.join(encryptedHexResult, ' '));

		// Decrypt
		List<Integer> decryptedResult = rc4.decrypt(encryptedResult);
		Assert.areEqual(content, String.fromCharArray(decryptedResult));
	}

	// Note: test scenario extracted from: https://datatracker.ietf.org/doc/html/rfc6229
	@IsTest
	static void encryptAndDecrypt3() {
		final String key = EncodingUtil.convertFromHex('0102030405').toString();
		final String content = EncodingUtil.convertFromHex('00000000000000000000000000000000').toString();

		final RC4 rc4 = new RC4(key);

		// Encrypt
		final List<Integer> encryptedResult = rc4.encrypt(content.getChars());
		final List<String> encryptedHexResult = new List<String>();

		final String result = 'b2 39 63 05 f0 3d c0 27 cc c3 52 4a 0a 11 18 a8';

		for (Integer i = 0; i < encryptedResult.size(); i++) {
			String hexEncryptedResult = '';
			if (encryptedResult[i] < 16) {
				hexEncryptedResult = '0';
			}
			hexEncryptedResult += Integers.toHexString(encryptedResult[i]);
			encryptedHexResult.add(hexEncryptedResult);
		}

		Assert.areEqual(result, String.join(encryptedHexResult, ' '));

		// Decrypt
		List<Integer> decryptedResult = rc4.decrypt(encryptedResult);
		Assert.areEqual(content, String.fromCharArray(decryptedResult));
	}

	// Note: test scenario extracted from: https://datatracker.ietf.org/doc/html/rfc6229
	@IsTest
	static void encryptAndDecrypt4() {
		final String key = EncodingUtil.convertFromHex(
				'0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20'
			)
			.toString();
		final String content = EncodingUtil.convertFromHex('00000000000000000000000000000000').toString();

		final RC4 rc4 = new RC4(key);

		// Encrypt
		final List<Integer> encryptedResult = rc4.encrypt(content.getChars());
		final List<String> encryptedHexResult = new List<String>();

		final String result = 'ea a6 bd 25 88 0b f9 3d 3f 5d 1e 4c a2 61 1d 91';

		for (Integer i = 0; i < encryptedResult.size(); i++) {
			String hexEncryptedResult = '';
			if (encryptedResult[i] < 16) {
				hexEncryptedResult = '0';
			}
			hexEncryptedResult += Integers.toHexString(encryptedResult[i]);
			encryptedHexResult.add(hexEncryptedResult);
		}

		Assert.areEqual(result, String.join(encryptedHexResult, ' '));

		// Decrypt
		List<Integer> decryptedResult = rc4.decrypt(encryptedResult);
		Assert.areEqual(content, String.fromCharArray(decryptedResult));
	}

	@IsTest
	static void encryptAndDecrypt5() {
		final String key = EncodingUtil.convertFromHex(
				'0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122'
			)
			.toString();

		try {
			new RC4(key);
			Assert.fail('Too long key must throw an exception');
		} catch (IllegalArgumentException e) {
			System.assert(true); // Note: Success
		}
	}
}
