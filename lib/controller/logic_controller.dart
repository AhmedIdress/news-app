import 'package:flutter/material.dart';
import 'package:news/article_model.dart';
import 'package:news/data/api_data.dart';

class LogicController extends ChangeNotifier {
  ApiData data = ApiData();
  String mainKey = 'cf429840dcc944fc90bac22c9a734a95',
      accentKey = '30a0740d123f42a48612140c8fa9dbd4';
  String key = '';
  String params = '';
  String linkBase = 'https://newsapi.org/v2/top-headlines';
  late String url;
  String? _country, _category;
  String? get country => _country;
  String? get category => _category;
  String? _searchItem;
  String? get searchItem => _searchItem;
  List<ArticleModel> _allArticles=[];
  List<ArticleModel> get allArticles => _allArticles;
  int page = 1;
  LogicController(bool isMainView) {
    isMainView ? getArticles(false) : /*getArticles(true)*/null;
  }

  Future<int> getArticles(bool isSearch) async {
    _allArticles = [];
    params = 'pageSize=10&page=$page';
    makeUrl(isSearch);
    print(url);
    try {
      Map<String, dynamic> responseDate = await data.getArticles(url);
      List<Map<String, dynamic>> articles = [];
      if (responseDate['articles'].length > 0) {
        articles = List<Map<String, dynamic>>.from(responseDate['articles']);
      }
      for (var e in articles) {
        _allArticles.add(ArticleModel.fromJson(e));
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
    return allArticles.length;
  }

  void countryChange(String? country) {
    _country = country;
    page = 1;
    getArticles(false);
    notifyListeners();
  }

  void categoryChange(String? category) {
    _category = category;
    page = 1;
    getArticles(false);
    notifyListeners();
  }

  void getSearchItem(String? item) {
    _searchItem = item;
    getArticles(true);
    notifyListeners();
  }

  void makeUrl(bool isSearch) {
    key = 'apiKey=$accentKey';
    if (isSearch) {
      linkBase = 'https://newsapi.org/v2/everything';
      params += searchItem != null ? '&q=$searchItem' : '';
    } else {
      if (country == null && category == null) {
        params += '&category=general';
      } else if (country == null && category != null) {
        params += '&category=$category';
      } else if (country != null && category == null) {
        params += '&country=$country';
      } else if (country != null && category != null) {
        params += '&country=$country&category=$category';
      }
    }
    url = '$linkBase?$key&$params';
  }

  Future<int> continueFetching(bool isSearch) async {
    page++;
    params = 'pageSize=10&page=$page';
    makeUrl(isSearch);
    print(url);
    try {
      Map<String, dynamic> responseDate = await data.getArticles(url);
      List<Map<String, dynamic>> articles = [];
      if (responseDate['articles'].length > 0) {
        articles = List<Map<String, dynamic>>.from(responseDate['articles']);
      }
      for (var e in articles) {
        _allArticles.add(ArticleModel.fromJson(e));
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
    return allArticles.length;
  }

}
