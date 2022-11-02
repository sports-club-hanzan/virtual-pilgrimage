// UIの文言を補完するHelperメソッド群
extension WordingHelper on String {
  /// お寺の表示名をUIに合わせる
  /// （通称）のような名称をもつデータがあるため、このメソッドで通称を表示しないようにフィルタリング
  /// ex. 【24番札所】最御崎寺（東寺）
  static String templeNameFilter(String templeName) {
    if (templeName.contains('（')) {
      return templeName.replaceRange(templeName.indexOf('（'), templeName.length, '');
    }
    return templeName;
  }

  /// m単位の数値をkm単位に補正した文字列を返す
  ///
  /// [meter] m単位の数値
  static String meterToKilometerString(int meter) {
    return (meter / 1000).toStringAsFixed(2);
  }
}
