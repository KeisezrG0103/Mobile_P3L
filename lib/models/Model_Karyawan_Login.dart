class KaryawanLogin {
  String _nama;
  String _role;
  String _token;

  KaryawanLogin({required String nama, required String role, required String token})
      : _nama = nama,
        _role = role,
        _token = token;

  factory KaryawanLogin.fromJson(Map<String, dynamic> json) {
    return KaryawanLogin(
      nama: json['Nama'],
      role: json['role'],
      token: json['token'],
    );
  }
  factory KaryawanLogin.empty() {
    return KaryawanLogin(
      nama: '',
      role: '',
      token: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Nama': _nama,
    'role': _role,
    'token': _token,
  };

  @override
  String toString() {
    return 'Karyawan Login{_nama: $_nama, _role: $_role, _token: $_token}';
  }

  String get nama => _nama;
  String get role => _role;
  String get token => _token;






}