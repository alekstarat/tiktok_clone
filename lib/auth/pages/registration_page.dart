import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth/pages/create_password.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin {

  late final TabController _controller;
  bool phoneReady = false, emailReady = false, currReady = false;
  
  final TextEditingController _phoneController = TextEditingController(), _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      currReady = phoneReady;
    });
    _controller = TabController(length: 2, vsync: this, animationDuration: const Duration(milliseconds: 50))..addListener(() {
      setState(() {
        currReady = [phoneReady, emailReady][_controller.index];
      });
    });
    _phoneController.addListener(() {
      if (_phoneController.text.length == 10 && _controller.index == 0) {
        setState(() {
          phoneReady = true;
          currReady = phoneReady;
        });
      } else {
        setState(() {
          phoneReady = false;
          currReady = phoneReady;
        });
      }
    });
    _emailController.addListener(() {
      if (_emailController.text.contains(RegExp("@")) 
        && _emailController.text.contains(RegExp(".")) 
        && _emailController.text.length >= 8
        && _emailController.text.length <= 20) {
          setState(() {
            emailReady = true;
            currReady = emailReady;
          });
        } else {
          setState(() {
            currReady = emailReady;
          });
        }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            if (currReady) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePassword()));
            }
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 50),
            opacity: currReady ? 1.0 : 0.4,
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
        bottom: TabBar(
          controller: _controller,
          dividerHeight: 1,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600]
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600]
          ),
          indicatorColor: Colors.black,
          splashFactory: NoSplash.splashFactory,
          dividerColor: Colors.black.withOpacity(0.1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 32),
          tabs: const [
            Tab(text: "Телефон",),
            Tab(text: "Почта"),
          ],
        ),
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
      body: TabBarView(
        controller: _controller,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.5),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: kToolbarHeight-10,
                child: CupertinoTextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  prefix: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "+7",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_drop_down_rounded, color: Colors.black, size: 15)
                    ],
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  placeholder: "Номер телефона",
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
                  controller: _phoneController,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.5),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: kToolbarHeight-10,
                child: CupertinoTextField(
                    maxLength: 20,
                    textAlignVertical: TextAlignVertical.center,
                    placeholder: "Адрес эл. почты",
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
                    controller: _emailController,
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
            ),
          )
        ],
      ),
    );
  }
}