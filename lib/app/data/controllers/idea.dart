import 'dart:typed_data';

class IDEA {
  int invertKali(int a) {
    int m, m0 = m = 65537;
    int y = 0, x = 1;

    while (a > 1) {
      int q = a ~/ m;
      int t = m;

      m = a % m;
      a = t;
      t = y;

      y = x - q * y;
      x = t;
    }

    return x < 0 ? x + m0 : x;
  }

  int invertTambah(int x) {
    return (65536 - x) & 65535;
  }

  int modTambah(int a, int b) {
    return (a + b) % 65536 & 65535;
  }

  int modKali(int a, int b) {
    int m = a * b;
    // pow(2, 16) + 1 = 65537
    if (m > 0) return m % 65537 & 65535;
    if (a > 0 || b > 0) return (1 - a - b) & 65535;
    return 1;
  }

  Uint16List invertKeys(Uint16List keys) {
    Uint16List invKeys = Uint16List(52);
    int p = 0;

    // Putaran 9 (Transformasi Akhir)
    invKeys[48] = invertKali(keys[p++]);
    invKeys[49] = invertTambah(keys[p++]);
    invKeys[50] = invertTambah(keys[p++]);
    invKeys[51] = invertKali(keys[p++]);

    // Putaran (8-2)
    for (int r = 7; r > 0; r--) {
      int i = r * 6;
      invKeys[i + 4] = keys[p++];
      invKeys[i + 5] = keys[p++];
      invKeys[i] = invertKali(keys[p++]);
      invKeys[i + 2] = invertTambah(keys[p++]);
      invKeys[i + 1] = invertTambah(keys[p++]);
      invKeys[i + 3] = invertKali(keys[p++]);
    }

    // Putaran 1
    invKeys[4] = keys[p++];
    invKeys[5] = keys[p++];
    invKeys[0] = invertKali(keys[p++]);
    invKeys[1] = invertTambah(keys[p++]);
    invKeys[2] = invertTambah(keys[p++]);
    invKeys[3] = invertKali(keys[p]);

    return invKeys;
  }

  Uint16List buatKunci({required String kunci, bool dekripsi = false}) {
    if (kunci.length < 8) {
      throw ("Panjang kunci minimal 8 karakter");
    }
    // Konversi kunci ke biner
    Uint8List biner = Uint8List.fromList(kunci.codeUnits);

    // Variabel yang menampung data kunci (128 bit)
    Uint8List key = Uint8List(16);

    // Fungsi untuk memetakan biner ke dalam key (128 bit)
    for (int i = 0, j = 0; i < biner.length; i++, j = (j + 1) % key.length) {
      key[j] ^= biner[i];
    }

    //==================== Membuat kunci enkripsi =========================//
    // Variabel yang menampung data 52 sub kunci
    Uint16List keys = Uint16List(52);

    ByteData byteData =
        ByteData.view(key.buffer, key.offsetInBytes, key.lengthInBytes);

    for (int i = 0; i < 52; i++) {
      //  Partisi 128 bit kunci menjadi 8 sub kunci
      if (i < 8) {
        keys[i] = byteData.getInt16(i);
        continue;
      }

      // Rotasi ke kiri 25 bit kunci
      int b1 = keys[i - ((i + 1) % 8 != 0 ? 7 : 15)] << 9;
      int b2 = keys[i - ((i + 2) % 8 < 2 ? 14 : 6)] >> 7;
      keys[i] = b1 | b2;
    }

    //==================== Membuat kunci dekripsi =========================//
    if (dekripsi) {
      keys = invertKeys(keys);
    }

    return keys;
  }

  Uint8List konversKeBiner(String teks) {
    // Membuat panjang bit plain text kelipatan 8 (8, 16, 24, 32, ...)
    int length = teks.length;
    length += 8 - (length % 8 == 0 ? 8 : length % 8);

    Uint8List biners = Uint8List(length);
    biners.setAll(0, teks.codeUnits);

    return biners;
  }

  String enkripsi(String pesan, String kunci) {
    // Membuat kunci enkripsi
    Uint16List keys = buatKunci(kunci: kunci);

    // Mengubah pesan ke list biner
    Uint8List plainText = konversKeBiner(pesan);

    int offset = plainText.length;
    ByteData byteData = ByteData.view(plainText.buffer);

    while (offset != 0) {
      proses(byteData, (offset -= 8), keys);
    }

    String cipherText = String.fromCharCodes(plainText);
    // String cipherText = plainText.map((e) => e.toRadixString(16)).join();

    return cipherText;
  }

  String dekripsi(String pesan, String kunci) {
    // Membuat kunci dekripsi
    Uint16List keys = buatKunci(kunci: kunci, dekripsi: true);

    // Mengubah cipher teks ke list biner
    Uint8List cipherText = konversKeBiner(pesan);

    int offset = cipherText.length;
    ByteData byteData = ByteData.view(cipherText.buffer);

    while (offset != 0) {
      proses(byteData, (offset -= 8), keys);
    }

    String plainText = String.fromCharCodes(cipherText);

    return plainText;
  }

  void proses(ByteData byteData, int offset, Uint16List keys) {
    int x1 = byteData.getUint16(offset);
    int x2 = byteData.getUint16(offset + 2);
    int x3 = byteData.getUint16(offset + 4);
    int x4 = byteData.getUint16(offset + 6);

    int k = 0;
    for (int round = 0; round < 8; round++) {
      int y1 = modKali(x1, keys[k++]); // K1
      int y2 = modTambah(x2, keys[k++]); // K2
      int y3 = modTambah(x3, keys[k++]); // K3
      int y4 = modKali(x4, keys[k++]); // K4

      int y5 = y1 ^ y3;
      int y6 = y2 ^ y4;

      int y7 = modKali(y5, keys[k++]); // K5
      int y8 = modTambah(y6, y7);
      int y9 = modKali(y8, keys[k++]); // K6
      int y10 = modTambah(y7, y9);

      x1 = y1 ^ y9;
      x2 = y3 ^ y9;
      x3 = y2 ^ y10;
      x4 = y4 ^ y10;
    }

    byteData.setUint16(offset, modKali(x1, keys[48]));
    byteData.setUint16(offset + 2, modTambah(x3, keys[49]));
    byteData.setUint16(offset + 4, modTambah(x2, keys[50]));
    byteData.setUint16(offset + 6, modKali(x4, keys[51]));
  }
}
