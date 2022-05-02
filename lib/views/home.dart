import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/views/widget/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 1;
  late List<Populartv_Model> popularTV = [];
  final _con = PopularTVController();
  bool isloading = true, isexpanding = true, isend = false;
  Future<void> getData({required String page}) async {
    if (!isend) {
      final mid = await _con.getPopularTv(page);
      if (mid.isEmpty) {
        setState(() {
          isend = true;
        });
      }
      if (isloading) {
        setState(() {
          isloading = false;
          popularTV.addAll(mid);
        });
      } else {
        setState(() {
          setState(() {
            isexpanding = false;
          });
          popularTV.addAll(mid);
          setState(() {
            isexpanding = true;
          });
        });
      }
    }
  }

  @override
  void initState() {
    getData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.5,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          )
        : Container(
            color: Colors.grey,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  if (isexpanding) {
                    getData(page: (page + 1).toString());
                    setState(() {
                      page += 1;
                    });
                  }
                }
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: popularTV.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return TVCard(
                              image: popularTV[index].poster_path == null
                                        ? ""
                                        : popularTV[index].poster_path!,
                                        title: popularTV[index].name==null
                                        ? ""
                                        : popularTV[index].name!,
                                        description: popularTV[index].overview==null
                                        ? ""
                                        : popularTV[index].overview!,
                              onpress: () {},
                              isfavorite: false);
                        }),
                  ),
                  Container(
                    height: isexpanding ? 0 : 100,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ));
  }
}
