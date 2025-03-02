class AppUtils {
  /// Valida si un ID es un número entero válido.
  /// Retorna el ID como entero si es válido, de lo contrario, retorna `null`.
  static int? validateInt(String? value) {
    if (value == null || int.tryParse(value) == null) {
      return null;
    }
    return int.parse(value);
  }

  /// Valida si una cadena representa un valor booleano válido.
  /// Retorna `true` para "true", "1", `false` para "false", "0", y `null` si no es válido.
  static bool? validateBool(String? value) {
    if (value == null) return null;
    final lowerValue = value.toLowerCase();
    if (lowerValue == 'true' || lowerValue == '1') return true;
    if (lowerValue == 'false' || lowerValue == '0') return false;
    return null;
  }
}
