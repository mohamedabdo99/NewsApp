abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNaState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  // if error case send error to ui if i needed
  final String error ;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{
  // if error case send error to ui if i needed
  final String error ;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{
  // if error case send error to ui if i needed
  final String error ;

  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{
  // if error case send error to ui if i needed
  final String error ;

  NewsGetSearchErrorState(this.error);
}


class NewsChangeAppMode extends NewsStates{}

