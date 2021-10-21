import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/statas.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/business/business.dart';
import 'package:newsapp/modules/science/Science.dart';
import 'package:newsapp/modules/sports/sports.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{

  NewsCubit() : super(NewsInitialState());
  // to get instance from NewsCubit
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem =
  [
    BottomNavigationBarItem(
      icon:Icon(
          Icons.business
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon:Icon(
          Icons.sports
      ),
      label: "sports",
    ),
    BottomNavigationBarItem(
      icon:Icon(
          Icons.science
      ),
      label: "science",
    ),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getSciences();
    }
    emit(NewsBottomNaState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness()
  {
   emit(NewsGetBusinessLoadingState());

   if(business.length == 0)
     {
       DioHelper.getData(
         url: 'v2/top-headlines',
         query: {
           'country':'eg',
           'category':'business',
           'apiKey':'895baa5973ad415d932e0e37181f80ea',
         },
       ).then((value) {
         // print(value.data.toString());
         business = value.data['articles'];
         print(business[0]['title']);
         emit(NewsGetBusinessSuccessState());
       }).catchError((error)
       {
         print(error.toString());
         emit(NewsGetBusinessErrorState(error.toString()));
       });
     }
   else
     {
       emit(NewsGetBusinessSuccessState());
     }


  }

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0 )
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'895baa5973ad415d932e0e37181f80ea',
          },
        ).then((value) {
          // print(value.data.toString());
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  void getSciences()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0 )
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'895baa5973ad415d932e0e37181f80ea',
          },
        ).then((value) {
          // print(value.data.toString());
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetScienceSuccessState());
      }


  }

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'895baa5973ad415d932e0e37181f80ea',
      },
    ).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }

  bool isDark = true;
  void changeAppMode({
    bool? shared,
    })
  {
    if(shared != null)
      {
        isDark = shared ;
        emit(NewsChangeAppMode());
      }
    else 
        isDark = !isDark;
    CacheHelper.saveData(key: "isDark", value: isDark).then((value) 
    {
       emit(NewsChangeAppMode());
    });
   
  }

}