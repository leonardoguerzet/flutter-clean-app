enum DomainError {
  unexpected,
  invalidCredetials,
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this){
      case DomainError.invalidCredetials: return 'Credenciais inválidas.';
      default: return 'Algo errado aconteceu. Tente novamente em breve';
    }
  }

}