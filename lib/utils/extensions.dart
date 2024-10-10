extension StringExtenstions on String {
  String get png => 'assets/images/$this.png';

  String get gif => 'assets/gifs/$this.gif';

  String get jpg => 'assets/jpg_files/$this.jpg';

  String get svg => 'assets/images/$this.svg';

  String get rawBal => replaceAll(',', '');

  double get toDouble => isEmpty ? 0.0 : double.parse(this);
}
