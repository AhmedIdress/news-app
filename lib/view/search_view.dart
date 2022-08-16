import 'package:flutter/material.dart';
import 'package:news/controller/favorite_controller.dart';
import 'package:news/controller/logic_controller.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LogicController(false),
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<LogicController>(
                  builder: (BuildContext context, provider, Widget? child) =>
                      TextFormField(
                    onChanged: (value) {
                      provider.getSearchItem(value);
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_outlined),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<LogicController>(
                builder: (BuildContext context, provider, Widget? child) {
                  return Expanded(
                    child: ListView.separated(
                            itemCount: provider.allArticles.length+1,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 15,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              if(provider.allArticles.isEmpty)
                              {
                                return Column(
                                  children: const [
                                    SizedBox(height: 250,),
                                    Text('Write any thing'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              }
                              else if(index < provider.allArticles.length)
                              {
                                var model = Provider.of<LogicController>(context)
                                    .allArticles[index];
                                return SizedBox(
                                  height: 320,
                                  child: Column(
                                    children: [
                                      model.urlToImage == null
                                          ? SizedBox(
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
                                          : Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  model.urlToImage ?? ''),
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
                                                  .read<
                                                  FavoriteController>()
                                                  .insertToFavorite(model,context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'has been added'),
                                                ),
                                              );
                                            },
                                            icon: Stack(
                                              alignment:
                                              AlignmentDirectional
                                                  .center,
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
                                        height: 110,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.publishedAt
                                                      ?.substring(8, 10) ??
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
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      decoration: TextDecoration
                                                          .underline,
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
                                                        overflow:
                                                        TextOverflow.ellipsis,
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
                                else{
                                Future.delayed(const Duration(seconds: 1), () {
                                  provider.continueFetching(true);
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
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
