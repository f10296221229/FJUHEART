class Login{
  final String account;
  final String password;
  final String logindt;

  const Login({
    required this.account, required this.password,required  this.logindt
  });

  factory Login.fromJson(Map<String,dynamic> json) => Login(
      account: json['account'],
      password: json['password'],
      logindt: json['logindt']
  );

  Map<String,dynamic> toJson() => {
    'account': account,
    'password': password,
    'logindt': logindt
  };
}