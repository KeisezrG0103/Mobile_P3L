class CustomerLogin {
  String _nama;
  String _email;
  String _token;



  CustomerLogin({required String nama, required String email, required String token})
      : _nama = nama,
        _email = email,
        _token = token;

  factory CustomerLogin.fromJson(Map<String, dynamic> json) {
    return CustomerLogin(
      nama: json['Nama'],
      email: json['Email'],
      token: json['token'],
    );
  }

  factory CustomerLogin.empty() {
    return CustomerLogin(
      nama: '',
      email: '',
      token: '',
    );
  }



  //default constructor


  Map<String, dynamic> toJson() => {
    'Nama': _nama,
    'Email': _email,
    'Token': _token,
  };

  @override
  String toString() {
    return 'CustomerLogin{_nama: $_nama, _email: $_email, _token: $_token}';
  }

  String get nama => _nama;
  String get email => _email;
  String get token => _token;
}
