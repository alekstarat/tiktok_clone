
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final FocusNode _focusNode = FocusNode();
  Widget searchIcon = const Icon(CupertinoIcons.mic_solid, color: Colors.black, size: 18);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _searchController.addListener(() {
      if (_searchController.text != "") {
        setState(() {
          searchIcon = GestureDetector(
            onTap: () {
              _searchController.clear();
              if (!_focusNode.hasFocus) {
                _focusNode.requestFocus();
              }
            },
            child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.black, size: 18)
          );
        });
      } else {
        setState(() {
          searchIcon = const Icon(CupertinoIcons.mic_solid, color: Colors.black, size: 18);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black, 
                        size: 20
                      ),
                    ),
                    const SizedBox(width: 8,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 105,
                      height: 30,
                      child: CupertinoTextField(
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: _focusNode,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'PTSans',
                          
                        ),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(CupertinoIcons.search, color: Colors.black, size: 18,),
                        ),
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: searchIcon,
                        ) ,
                        placeholder: "Ebat ebat",
                        placeholderStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: "PTSans",
                          color: Colors.grey[600]
                        ),
                        controller: _searchController,
                        cursorColor: Colors.red,
                        cursorHeight: 15,
                        cursorWidth: 2,
                        cursorRadius: const Radius.circular(90),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                          
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    const Text(
                      "Поиск",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'PTSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}