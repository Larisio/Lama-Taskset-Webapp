/// provides basic filter for input fields
///
/// Author: L.Kammerer
/// latest Changes: 01.10.2021
class InputValidation {
  ///Used check input fields on empty
  ///
  ///{@param} [String] as str
  static String? inputFieldIsEmpty(String? input) {
    return isEmpty(input) ? "Feld darf nicht leer sein!" : null;
  }

  ///Used to check input on empty
  ///
  ///{@param} [String] as str
  static bool isEmpty(String? input) {
    if (input != null && input != '' && input != ' ' && input.isNotEmpty)
      return false;
    return true;
  }
}
