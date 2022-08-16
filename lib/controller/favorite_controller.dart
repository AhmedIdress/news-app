import 'package:flutter/material.dart';
import 'package:news/article_model.dart';
import 'package:news/data/data_base.dart';
import 'package:news/main.dart';

class FavoriteController extends ChangeNotifier{
  DataBaseHelper helper = DataBaseHelper.instance;
  List<ArticleModel> _favorites=[];
  List<ArticleModel> get favorites=>_favorites;
  FavoriteController()
  {
    getFromFavorite();
  }
  void insertToFavorite(ArticleModel model,context)
  {
    bool here = false;
    for (var e in MyApp.archived)
    {
      if(e==model.url){
        here=true;
        break;
      }
    }
    if(!here){
      helper.insert(model);
      MyApp.archived.add(model.url??'');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('has been added'),),);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('already funded'),),);
    }
  }

  void getFromFavorite() async
  {
    _favorites = await helper.get();
    notifyListeners();
  }

}