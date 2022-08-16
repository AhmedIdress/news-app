import 'package:flutter/material.dart';
import 'package:news/controller/favorite_controller.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, child) {
        var provider = Provider.of<FavoriteController>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: .0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: provider.favorites.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                if(provider.favorites.isEmpty)
                  {
                    return const Center(
                      child: Text('no data founded'),
                    );
                  }
                else{
                  var model = provider.favorites[index];
                  return SizedBox(
                    height: 340,
                    child: Column(
                      children: [
                        model.urlToImage == null
                            ? Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                          child: const Center(child: Text('have\'t image ',),),
                        )
                            : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(model.urlToImage ?? ''),
                                fit: BoxFit.cover,
                              )),
                          alignment: Alignment.topRight,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 120,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    model.publishedAt?.substring(8, 10) ?? '2',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(model.publishedAt?.substring(0, 7) ??
                                      'sep 12'),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.title ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        decoration: TextDecoration.underline,
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
                }
              },
            ),
          ),
        );
      },
      create: (BuildContext context) {
        return FavoriteController();
      },
    );
  }
}
