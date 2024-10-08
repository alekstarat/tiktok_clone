import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/restart_widget.dart';

class SelectBirth extends StatefulWidget {
  const SelectBirth({super.key});

  @override
  State<SelectBirth> createState() => _SelectBirthState();
}

class _SelectBirthState extends State<SelectBirth> {
  int? day, month, year;
  String date = "";

  final List<int> days = List.generate(31, (int index) => index + 1);
  final List<String> months = [
    "Январь",
    "Ферваль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
  ];
  final List<int> years = List.generate(74, (int index) => index + 1950);

  @override
  Widget build(BuildContext context) {
    date =
        "${day != null ? day! < 10 ? "0$day" : day : ""}.${month != null ? month! < 10 ? "0$month" : month : ""}.${year ?? ""}";
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _birthController =
        TextEditingController(text: date.contains("..") ? null : date);
    return BlocProvider(
      create: (_) => context.read<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            RestartWidget.restartApp(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Регистрация",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Когда вы родились?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "Дата вашего рождения не будет \nпоказана публично.",
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 15),
                        ),
                      ],
                    ),
                    const Icon(CupertinoIcons.chart_pie,
                        size: 50, color: Colors.black)
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: kToolbarHeight - 10,
                  child: CupertinoTextField(
                    suffixMode: OverlayVisibilityMode.editing,
                    maxLength: 10,
                    textAlignVertical: TextAlignVertical.center,
                    placeholder: "Дата рождения",
                    readOnly: true,
                    showCursor: false,
                    placeholderStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    controller: _birthController,
                    cursorColor: Colors.red[600],
                    cursorWidth: 2,
                    cursorRadius: const Radius.circular(90),
                    cursorHeight: 20,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey[300]!, width: 1))),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 50),
                    opacity:
                        [day, month, year].where((e) => e != null).length == 3
                            ? 1.0
                            : 0.4,
                    child: GestureDetector(
                      onTap: () {
                        if ([day, month, year].where((e) => e != null).length ==
                            3) {
                              context.read<AuthBloc>().authData.addAll({'birth' : '$year-$month-$day'});
                              print(context.read<AuthBloc>().authData);
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (r) => r.isActive);
                          context.read<AuthBloc>().add(RegistrationEvent());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[600],
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: kToolbarHeight - 5,
                        child: const Center(
                          child: Text(
                            "Продолжить",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 128,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CarouselSlider.builder(
                          carouselController: CarouselSliderController(),
                          itemCount: days.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[400]!, width: 1))),
                              height: 60,
                              width: 100,
                              child: Center(
                                child: Text(
                                  days[index].toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  day = days[index];
                                });
                              },
                              aspectRatio: 2,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              height: 70,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              scrollDirection: Axis.vertical,
                              viewportFraction: 0.4)),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CarouselSlider.builder(
                          carouselController: CarouselSliderController(),
                          itemCount: months.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[400]!, width: 1))),
                              height: 60,
                              width: 100,
                              child: Center(
                                child: Text(
                                  months[index].toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  month = index + 1;
                                });
                              },
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              aspectRatio: 2,
                              height: 70,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              scrollDirection: Axis.vertical,
                              viewportFraction: 0.4)),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CarouselSlider.builder(
                          carouselController: CarouselSliderController(),
                          itemCount: years.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[400]!, width: 1))),
                              height: 60,
                              width: 100,
                              child: Center(
                                child: Text(
                                  years[index].toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              initialPage: years.length - 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  year = years[index];
                                });
                              },
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              aspectRatio: 2,
                              height: 70,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              scrollDirection: Axis.vertical,
                              viewportFraction: 0.4)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
