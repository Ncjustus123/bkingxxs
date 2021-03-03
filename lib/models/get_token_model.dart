class GetToken {
  String username;
  String password;

  GetToken({this.username, this.password});

  GetToken.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class GetTokenResponse {
  String code;
  String shortDescription;
  Object object;

  GetTokenResponse({this.code, this.shortDescription, this.object});

  GetTokenResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.toJson();
    }
    return data;
  }
}

class Object {
  String token;
  String refreshToken;
  String expires;
  String user;

  Object({this.token, this.refreshToken, this.expires, this.user});

  Object.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    expires = json['expires'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['expires'] = this.expires;
    data['user'] = this.user;
    return data;
  }
}
