import 'package:flutter/material.dart';
import 'package:flutter_pc/api/company_info.dart' as company;
import 'package:flutter_pc/constants.dart';
import 'package:flutter_pc/data/stock.dart';

_BodyState bodyState = _BodyState();

class Body extends StatefulWidget {
  @override
  _BodyState createState() => bodyState;
}

class _BodyState extends State<Body> {
  bool isScrolled = false;
  List<Stock> stockList = [];
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (loaded == false) {
      stockList.add(Stock("_name", "logoUrl", "country", "_currency", 1111));
      stockList.add(Stock("_name", "logoUrl", "country", "_currency", 1111));
      stockList.add(Stock("_name", "logoUrl", "country", "_currency", 1111));

      company.fetchGetCompany("AAPL").then((value) => this.setState(() {
            stockList.add(value);
          }));
      company.fetchGetCompany("F").then((value) => this.setState(() {
            stockList.add(value);
          }));
      company.fetchGetCompany("TSLA").then((value) => this.setState(() {
            stockList.add(value);
          }));

      loaded = true;
    }

    return Container(
      child: Column(children: [
        Header(size: size),
        StockView(size: size, stockList: stockList)
      ]),
    );
  }
}

class StockView extends StatelessWidget {
  const StockView({
    Key? key,
    required this.size,
    required this.stockList,
  }) : super(key: key);

  final Size size;
  final List<Stock> stockList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 700),
          curve: Curves.fastOutSlowIn,
          height: bodyState.isScrolled ? size.height * 0.8 : size.height * 0.6,
          child: CardView(size: size, stockList: stockList),
        )
      ],
    );
  }
}

class CardView extends StatefulWidget {
  CardView({
    Key? key,
    required this.size,
    required this.stockList,
  }) : super(key: key);

  final Size size;
  final List<Stock> stockList;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset > _scrollController.position.minScrollExtent) {
      bodyState.setState(() {
        bodyState.isScrolled = true;
      });
    } else {
      bodyState.setState(() {
        bodyState.isScrolled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.68,
      child: buildListView(),
    );
  }

  void cardOnTapped() async {}

  ListView buildListView() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(8),
      itemCount: widget.stockList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
                height: widget.size.height * 0.18,
                decoration: BoxDecoration(
                    color: kThirdColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: widget.size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(width: widget.size.width * 0.05),
                        Text(
                          widget.stockList[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: kTextColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Container(
                      height: widget.size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(width: widget.size.width * 0.05),
                        Text(
                          "시가 총액: ${widget.stockList[index].marketCapital} ${widget.stockList[index].currency}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: kTextColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
            Container(
              height: widget.size.height * 0.02,
            ),
          ],
        );
      },
    );
  }
}

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: bodyState.isScrolled
            ? widget.size.height * 0.1
            : widget.size.height * 0.3,
        duration: Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
        child: Stack(
          children: [
            Container(
              height: widget.size.height * 0.3 - widget.size.height * 0.02,
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
              child: bodyState.isScrolled
                  ? null
                  : Row(
                      children: [
                        Text(
                          "안녕하세요,\n김정빈님.",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                      ],
                    ),
            ),
            Positioned(
              bottom: bodyState.isScrolled
                  ? widget.size.height * 0.025
                  : widget.size.height * 0.04,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 45,
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
                    Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
