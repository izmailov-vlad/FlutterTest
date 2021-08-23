abstract class HomePageEvent {}

class HomePageLogoutEvent extends HomePageEvent {}

class HomePageRefreshEvent extends HomePageEvent {
  bool closeSearchingField;
  bool loadNewUsers;
  bool findUser;
  bool loadAndFindNewUser;
  String text;
  HomePageRefreshEvent(this.loadNewUsers, this.findUser, this.loadAndFindNewUser, this.closeSearchingField, this.text);
}

class HomePageStartSearchEvent extends HomePageEvent {}

class HomePageOnSearchTextChangedEvent extends HomePageEvent {
  String text;
  HomePageOnSearchTextChangedEvent(this.text);
}

class HomePageOnSearchButtonPressedEvent extends HomePageEvent {}