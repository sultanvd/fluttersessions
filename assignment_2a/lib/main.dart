import 'package:assignment2a/ChatItem.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const WHATSAPP_COLOR = 0xFF075e54;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green, primaryColor: Color(WHATSAPP_COLOR)),
      home: ToolbarWidget(title: 'WhatsApp'),
    );
  }
}

class ToolbarWidget extends StatelessWidget {
  final String title;

  ToolbarWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              textDirection: TextDirection.ltr,
            ),
            actions: getAppbarActions(),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(text: 'CHATS'),
                Tab(text: 'STATUS'),
                Tab(text: 'CALLS'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              getCameraTabView(),
              getChatsTabView(),
              getStatusTabView(),
              getCallTabView(),
            ],
          ),
        ));
  }

  Widget getCameraTabView() {
    return Container(
      child: Center(
        child: Text(
          "Open Camera and Capture Images",
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getStatusTabView() {
    return Container(
      child: Center(
        child: Text(
          "Friends Status list here",
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getCallTabView() {
    return Container(
      child: Center(
        child: Text(
          "Recent calls list here",
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getChatsTabView() {
    return Container(
        child: ListView.builder(
            itemCount: getChatItems().length,
            itemBuilder: (BuildContext ctx, int index) {
              return getListItemWidget(getChatItems()[index]);
            }));
  }

  List<Widget> getAppbarActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        tooltip: 'Search',
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        tooltip: 'More',
        onPressed: () {},
      )
    ];
  }

  Widget getListItemWidget(ChatItem item) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(WHATSAPP_COLOR),
                        child: Icon(Icons.person),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 5,
                          children: <Widget>[
                            Text(
                              item.name,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              item.message,
                              textDirection: TextDirection.ltr,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.time,
                    textDirection: TextDirection.ltr,
                  )
                  //image view for user image//user details
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            )
          ],
        ));
  }

  List<ChatItem> getChatItems() {
    List<ChatItem> chatItems = [];
    for (int i = 0; i < 20; i++) {
      chatItems.add(ChatItem('Contact ${i}', 'Hi, there', '02:40 pm'));
    }

    return chatItems;
  }

}
