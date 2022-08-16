import 'package:flutter/material.dart';
import 'package:news/controller/favorite_controller.dart';
import 'package:news/controller/logic_controller.dart';
import 'package:news/view/favorites_view.dart';
import 'package:news/view/search_view.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> countries = [
      'ae',
      'ar',
      'at',
      'au',
      'be',
      'bg',
      'br',
      'ca',
      'ch',
      'cn',
      'co',
      'cu',
      'cz',
      'de',
      'eg',
      'fr',
      'gb',
      'gr',
      'hk',
      'hu',
      'id',
      'ie',
      'il',
      'in',
      'it',
      'jp',
      'kr',
      'lt',
      'lv',
      'ma',
      'mx',
      'my',
      'ng',
      'nl',
      'no',
      'nz',
      'ph',
      'pl',
      'pt',
      'ro',
      'rs',
      'ru',
      'sa',
      'se',
      'sg',
      'si',
      'sk',
      'th',
      'tr',
      'tw',
      'ua',
      'us',
      've',
      'za',
    ];
    return ChangeNotifierProvider(
      builder: (context, child) {
        var provider = Provider.of<LogicController>(context);
        return Scaffold(
          appBar: AppBar(
            elevation: .0,
            backgroundColor: Colors.white,
            title: const Text('News'),
            actions: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    elevation: 5,
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width - 2 * 8,
                    ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    builder: (context) {
                      return const SearchView();
                    },
                    context: context,
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesView(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.favorite,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                      ),
                      child: DropdownButton<String>(
                          underline: const SizedBox(),
                          hint: const Text('Category'),
                          value: provider.category,
                          elevation: 0,
                          items: [
                            'general',
                            'business',
                            'entertainment',
                            'health',
                            'science',
                            'sports',
                            'technology',
                          ]
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            provider.categoryChange(value);
                          }),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                      ),
                      child: DropdownButton<String>(
                          value: provider.country,
                          underline: const SizedBox(),
                          elevation: 0,
                          hint: const Text('Country'),
                          items: /*[
                            'country1',
                            'country2',
                          ]*/
                              countries
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            provider.countryChange(value);
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                  child: Center(
                    child: Divider(
                      height: 3,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: provider.allArticles.length + 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (provider.allArticles.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (index < provider.allArticles.length) {
                        var model = Provider.of<LogicController>(context)
                            .allArticles[index];
                        return SizedBox(
                          height: 340,
                          child: Column(
                            children: [
                              if (model.urlToImage == null)
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: IconButton(
                                          onPressed: () {
                                            context
                                                .read<FavoriteController>()
                                                .insertToFavorite(
                                                    model, context);
                                          },
                                          icon: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: const [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'have\'t image ',
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(model.urlToImage ?? ''),
                                    fit: BoxFit.cover,
                                  )),
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      right: 8,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<FavoriteController>()
                                            .insertToFavorite(model, context);
                                      },
                                      icon: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: const [
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 120,
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.publishedAt?.substring(8, 10) ??
                                              '2',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(model.publishedAt
                                                ?.substring(0, 7) ??
                                            'sep 12'),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.title ?? '',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.description ?? '',
                                              style: const TextStyle(
                                                /*color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,*/
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Future.delayed(const Duration(seconds: 1), () {
                          provider.continueFetching(false);
                        },);
                        return const SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      create: (BuildContext context) => LogicController(true),
    );
  }
}
