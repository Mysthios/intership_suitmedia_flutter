import 'package:flutter/material.dart';
import 'package:intership_suitmedia/models/user_model.dart';
import 'package:intership_suitmedia/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppState>(context, listen: false).resetUsers();
      Provider.of<AppState>(context, listen: false).fetchUsers(isRefresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final appState = Provider.of<AppState>(context, listen: false);
        if (!appState.isLoading && appState.hasMoreData) {
          appState.fetchUsers();
        }
      }
    });
  }

  void _onRefresh() async {
    await Provider.of<AppState>(context, listen: false).fetchUsers(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _selectUser(User user) {
    Provider.of<AppState>(context, listen: false).setSelectedUserName(user.fullName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.users.isEmpty && appState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (appState.users.isEmpty && !appState.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No users found',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => appState.fetchUsers(isRefresh: true),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(0),
              itemCount: appState.users.length + (appState.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == appState.users.length) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final user = appState.users[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.avatar),
                      backgroundColor: Colors.grey[300],
                    ),
                    title: Text(
                      user.fullName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        user.email,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    onTap: () => _selectUser(user),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}