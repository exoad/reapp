import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project_1_app/bits/debug.dart';
import 'package:project_1_app/bits/helper.dart';
import 'package:project_1_app/bits/consts.dart';
import 'package:project_1_app/parts/block.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  init().then((_) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final PageController pageController =
      PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appLaF(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endContained,
        floatingActionButton: FloatingActionButton(
          onPressed: () => pageController.animateToPage(4,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastEaseInToSlowEaseOut),
          child: const Icon(Ionicons.chatbubble),
        ),
        bottomNavigationBar: Padding(
          padding: LaF.outerComponentPadding,
          child: BottomAppBar(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              labeledIconBtn(
                  child: bottomAppBarPageControlledBtn(
                      pageNum: 0,
                      icon: const Icon(Icons.home_filled),
                      controller: pageController),
                  label: uiText["HomeLabel"]),
              labeledIconBtn(
                child: bottomAppBarPageControlledBtn(
                    pageNum: 1,
                    icon: const Icon(Icons.lightbulb_rounded),
                    controller: pageController),
                label: uiText["TipsLabel"]!,
              ),
              labeledIconBtn(
                child: bottomAppBarPageControlledBtn(
                    pageNum: 2,
                    icon: const Icon(
                        Icons.format_list_bulleted_rounded),
                    controller: pageController),
                label: uiText["LogLabel"]!,
              ),
              labeledIconBtn(
                child: bottomAppBarPageControlledBtn(
                    pageNum: 3,
                    icon: const Icon(Icons.settings),
                    controller: pageController),
                label: uiText["SettingsLabel"]!,
              ),
              const SizedBox(width: 30)
            ],
          )),
        ),
        body: PageView(
          controller: pageController,
          pageSnapping: true,
          padEnds: false,
          allowImplicitScrolling: false,
          children: <Widget>[
            Center(
                child: Column(
              children: <Widget>[
                wrapAsHomeLabel(
                  padding: LaF.homeComponentPadding,
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                            image: AssetImage(
                                "assets/app_icon/icon_64x64.png")),
                        Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            children: [
                              Text(uiText["TitleLabel"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30)),
                              Text(uiText["AuthorsSublabel"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))
                            ])
                      ]),
                ),
                const Block.claimed(
                    backgroundColor: LaF.primaryColorBlueTint,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 3,
                              child: Icon(Icons.warning_amber_rounded,
                                  size: 54)),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(text: "Placeholder\n"),
                              TextSpan(text: "Text")
                            ]),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 34),
                          )
                        ])),
                const Block(
                    backgroundColor: LaF.primaryColorGreenTint,
                    padding: LaF.homeComponentPadding,
                    child: Row())
              ],
            )),
            debug_wrapPageNumber(bg: Colors.purple, text: "Page 2"),
            debug_wrapPageNumber(bg: Colors.cyan, text: "Page 3"),
            debug_wrapPageNumber(bg: Colors.green, text: "Page 4"),
            debug_wrapPageNumber(bg: Colors.red, text: "Page 5"),
          ],
        ),
      ),
    );
  }
}
