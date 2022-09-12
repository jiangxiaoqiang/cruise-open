enum MenuType { home, sub, channels, my }

extension ResponseStatusExtension on MenuType {
  static const menuValue = {
    MenuType.channels: 2,
    MenuType.my: 3,
    MenuType.home: 0,
    MenuType.sub: 1,
  };

  int? get value => menuValue[this];
}
