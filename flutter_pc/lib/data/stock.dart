class Stock {
  String _name;
  String _logoUrl;
  String _country;
  String _currency;
  int _marketCapital;

  String get name => this._name;
  String get logoUrl => this._logoUrl;
  String get country => this._country;
  String get currency => this._currency;
  int get marketCapital => this._marketCapital;

  Stock(this._name, this._logoUrl, this._country, this._currency,
      this._marketCapital);

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      json['name'],
      json['logo'],
      json['country'],
      json['currency'],
      json['marketCapitalization'],
    );
  }
}
