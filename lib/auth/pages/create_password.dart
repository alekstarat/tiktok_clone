import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth/pages/select_birth.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {

  bool is8chars = false, is1let1num = false, isSpecialChar = false;
  bool obscure = true;
  final TextEditingController _passwordController = TextEditingController();

  final String specialChars = r'[!@#$%^&*(),.?":{}|<>]';
  final String chars = 'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm';
  final String nums = '0123456789';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        for (int i = 0; i < specialChars.length; i++) {
          if (_passwordController.text.contains(specialChars[i])) {
            isSpecialChar = true;
            break;
          }
        }
      
        is1let1num = 
          chars.split('').any((elem) => _passwordController.text.contains(elem))
          && nums.split('').any((element) =>  _passwordController.text.contains(element),);
        
        is8chars = _passwordController.text.length >= 8;

      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
          onTap: () {
            if (is8chars) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectBirth()));
            }
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: is8chars ? 1.0 : 0.4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[600],
                borderRadius: BorderRadius.circular(8)
              ),
              width: MediaQuery.of(context).size.width*0.85,
              height: kToolbarHeight-5,
              child: const Center(
                child: Text(
                  "Продолжить",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Регистрация",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(CupertinoIcons.question_circle, color: Colors.black, size: 25),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Придумайте пароль",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 32,),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: kToolbarHeight-10,
                child: CupertinoTextField(
                  obscureText: obscure,
                  suffixMode: OverlayVisibilityMode.editing,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: const Icon(Icons.remove_red_eye_rounded, color: Colors.black,),
                  ),
                    maxLength: 20,
                    textAlignVertical: TextAlignVertical.center,
                    placeholder: "Введите пароль",
                    placeholderStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    controller: _passwordController,
                    cursorColor: Colors.red[600],
                    cursorWidth: 2,
                    cursorRadius: const Radius.circular(90),
                    cursorHeight: 20,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1))
                    ),
                  ),
              ),
            const SizedBox(height: 16,),
            const Text(
              "Пароль должен содержать:",
              style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
            ),
            const SizedBox(height: 16,),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.check_rounded, size: 15, color: is8chars ? Colors.green : Colors.grey[400],),
                    const SizedBox(width: 6,),
                    Text(
                      "8 символов (максимум 20)",
                      style: TextStyle(
                        fontSize: 12, 
                        color: is8chars ? Colors.green : Colors.grey[400],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check_rounded, size: 15, color: is1let1num ? Colors.green : Colors.grey[400],),
                    const SizedBox(width: 6,),
                    Text(
                      "1 букву и 1 цифру",
                      style: TextStyle(
                        fontSize: 12, 
                        color: is1let1num ? Colors.green : Colors.grey[400],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check_rounded, size: 15, color: isSpecialChar ? Colors.green : Colors.grey[400],),
                    const SizedBox(width: 6,),
                    Text(
                      r"1 специальный символ (Например: # ? ! $ & @)",
                      style: TextStyle(
                        fontSize: 12, 
                        color: isSpecialChar ? Colors.green : Colors.grey[400],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.grey[300]
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 4,
                    width: (0.3*(MediaQuery.of(context).size.width-32))*[0, 1, 2, 3][[is1let1num, is8chars, isSpecialChar].where((x) => x == true).length],
                    color: <Color>[Colors.transparent, Colors.red, Colors.orangeAccent, Colors.green][[is1let1num, is8chars, isSpecialChar].where((x) => x == true).length],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}