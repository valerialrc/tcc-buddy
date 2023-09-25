String getErrorString(String code) {
  switch (code) {
    case 'firebase_auth/weak_password':
    case 'weak-password':
      return 'Sua senha é muito fraca.';

    case 'firebase_auth/invalid_email':
    case 'invalid-email':
      return 'Seu e-mail é inválido.';

    case 'firebase_auth/email_already_in_use':
    case 'account-exists-with-different-credential':
      return 'E-mail já está sendo utilizado em outra conta.';

    case 'firebase_auth/invalid_credential':
    case 'invalid-credential':
      return 'Seu e-mail é inválido.';

    case 'firebase_auth/wrong_password':
    case 'wrong-password':
      return 'Sua senha está incorreta.';

    case 'firebase_auth/user_not_found':
    case 'user-not-found"':
      return 'Não há usuário com este e-mail.';

    case 'firebase_auth/user_disabled':
    case 'user-disabled':
      return 'Este usuário foi desabilitado.';

    case 'firebase_auth/too_many_requests':
      return 'Muitas solicitações. Tente novamente mais tarde.';

    case 'firebase_auth/operation_not_allowed':
    case 'operation-not-allowed':
      return 'Operação não permitida.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}
