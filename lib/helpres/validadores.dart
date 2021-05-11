bool validarEmail(String valor) {
  final RegExp regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(valor);
}

bool validarNomeCompleto(String valor) {
  return (valor.trim().split(" ").length > 1);
}

bool validarSenha(String valor) {
  return (valor.length >= 6);
}
