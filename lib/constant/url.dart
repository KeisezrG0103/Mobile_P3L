class URL {
  static const String BASE_URL = "http://10.0.2.2:8000";
  static const String LOGIN = "$BASE_URL/api/login";
  static const String PRESENSI = "$BASE_URL/api/presensi";
  static const String FORGOT = "$BASE_URL/api/forgot-password";
  static const String VERIFY = "$BASE_URL/api/verify/pin";
  static const String RESET = "$BASE_URL/api/reset-password";
  static const String SALDO = "$BASE_URL/api/getCustomerByEmail";
  static const String REQUEST = "$BASE_URL/api/requestSaldo";
  static const String HISTORY = "$BASE_URL/api/getHistoryPenarikanSaldo";
  static const String GetProdukByRequest =
      "$BASE_URL/api/getProdukByRequestandKuota";
  static const String LAPORAN_STOK_BAHAN_BAKU =
      "$BASE_URL/api/laporan_bahan_baku";
}
