import 'package:flutter/material.dart';
import 'package:flutter_pc/api/company_info.dart' as company;
import 'package:flutter_pc/constants.dart';
import 'package:flutter_pc/data/stock.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Stock> stockList = [];

    return Container(
      child: Column(children: [
        Header(size: size),
        Column(
          children: [
            Container(
              height: size.height * 0.08,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.1,
                      ),
                      Text(
                        "관심 목록",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: kTextColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(children: [
              Container(
                  child: Container(
                height: size.height * 0.55,
                padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: 36 + kDefaultPadding),
                decoration: BoxDecoration(
                  color: kThirdColor.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              )),
              CardView(size: size, stockList: stockList),
            ]),
          ],
        )
      ]),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.size,
    required this.stockList,
  }) : super(key: key);

  final Size size;
  final List<Stock> stockList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.55,
      child: FutureBuilder(
          future: company.fetchGetCompany('AAPL'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            } else {
              stockList.add(snapshot.data);
              return buildListView();
            }
          }),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: stockList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: stockList.length - 1 != index
                        ? [
                            BoxShadow(
                                offset: Offset(10, 0),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23))
                          ]
                        : [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.23))
                          ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(width: size.width * 0.05),
                        Text(
                          stockList[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: kPrimaryColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(width: size.width * 0.05),
                        Text(
                          "시가 총액: ${stockList[index].marketCapital} ${stockList[index].currency}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
              height: size.height * 0.02,
            ),
          ],
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.3,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.3 - 27,
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: 36 + kDefaultPadding),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "안녕하세요.",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: kPrimaryColor),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    )),
                    Icon(Icons.search),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
