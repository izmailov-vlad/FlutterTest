abstract class AuthorizationState {}

class NotAuthorizedState extends AuthorizationState {}

class AuthorizingState extends AuthorizationState {}

class AuthorizedState extends AuthorizationState {}

class AuthorizationErrorState extends AuthorizationState {}
