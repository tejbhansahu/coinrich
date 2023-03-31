extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String toShort({bool autoManage = false, int fixLength = 20}) =>
      split(' ').map((e) => e[0]).toList().reduce((value, element) => autoManage
          ? (length < fixLength ? this : (value + element).toUpperCase())
          : value + element);

  String lastChar() => substring(length - 1);

  String removeLastChar() => substring(0, length - 1);
}
