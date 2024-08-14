part of 'screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late StateApp state;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    state = Provider.of<StateApp>(context, listen: false);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          state.fetchUsers();
        }
      });
    state.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          'Second Screen', style: fontsStyle.copyWith(fontWeight: bold),)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: purpleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<StateApp>(
        builder: (context, appState, child) {
          return RefreshIndicator(
            onRefresh: () async {
              appState.fetchUsers();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: appState.users.length + 1,
              itemBuilder: (context, index) {
                if (index == appState.users.length) {
                  return appState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }
                final user = appState.users[index];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar)),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () {
                    appState.selectUser(user);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
