part of 'screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateApp>(context);

    return Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Second Screen', style: fontsStyle.copyWith(fontWeight: bold),)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: purpleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome', style: fontsStyle.copyWith(fontSize: 13),),
              Text(state.name, style: fontsStyle.copyWith(fontSize: 18, fontWeight: bold),),
              const SizedBox(height: 170,),
              Center(child: Text(state.selectedUserName, style: fontsStyle.copyWith(fontSize: 24, fontWeight: bold),)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Button(title: 'Choose a User', onTap: (){ Navigator.pushNamed(context, '/third_screen');},),
      ),
    );
  }
}
