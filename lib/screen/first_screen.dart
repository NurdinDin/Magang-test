part of 'screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateApp>(context);

    final nameController = TextEditingController();
    final textPalController = TextEditingController();

    bool isPalindrome(String text) {
      final sanitizedText = text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
      return sanitizedText == sanitizedText.split('').reversed.join('');
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            FittedBox(child: Image.asset('assets/background.png', scale: 1, fit: BoxFit.fill,)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150),
                  Image.asset(
                    'assets/ic_photo.png',
                    scale: 1.8,
                  ),
                  SizedBox(height: 50),
                  textField('Name', nameController),
                  textField('Palindrome', textPalController),
                  SizedBox(height: 70,),
                  Button(
                    title: 'CHECK',
                    onTap: () {
                      final teksPal = textPalController.text.trim();
                      if (teksPal.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Isi teks terlebih dahulu!'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final isPal = isPalindrome(teksPal);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(isPal ? 'isPalindrome' : 'Not Palindrome'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    title: 'NEXT',
                    onTap: () {
                      final name = nameController.text.trim();
                      if (name.isEmpty) {
                        // Show a message if no name is entered
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Isi nama terlebih dahulu'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        state.updateName(name);
                        Navigator.pushNamed(context, '/second_screen');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}


Widget textField(title, controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        filled: true,
        fillColor: whiteColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const Button({
    super.key,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: deepTealColor),
        child: Center(
            child: Text(title,
                style: fontsStyle.copyWith(fontSize: 18, color: whiteColor))),
      ),
    );
  }
}
