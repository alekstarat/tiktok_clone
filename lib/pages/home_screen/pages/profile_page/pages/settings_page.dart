import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/restart_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    shadowColor: Colors.transparent,
                    stretch: true,
                    backgroundColor: Colors.grey[100],
                    pinned: true,
                    //forceMaterialTransparency: true,
                    expandedHeight: 30,
                    flexibleSpace: const FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.none,
                      title: Text(
                        "Настройки и конфиденциальность",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    centerTitle: true,
                    title: innerBoxIsScrolled
                        ? const Text(
                            "Настройки и конфиденциальность",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        : null,
                  )
                ];
              },
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(LogoutEvent());
                            RestartWidget.restartApp(context);
                          },
                          child: const ListTile(
                            leading: RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.grey,
                                )),
                            title: Text(
                              "Выйти",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
  }
}
