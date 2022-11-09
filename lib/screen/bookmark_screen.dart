import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu/bloc/bookmarks/bookmark_cubit.dart';
import 'package:relu/bloc/bookmarks/bookmark_state.dart';
import 'package:relu/bloc/connection/connection_state.dart' as cs;
import '../bloc/connection/connection_cubit.dart';
import 'lyric_screen.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ConnectionCubit>().check();
      context.read<BookMarkCubit>().getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.red,
            Colors.pink,
          ])),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.pink,
        ])),
        child: BlocBuilder<ConnectionCubit, cs.ConnectionState>(
          builder: (context, connect) {
            if (connect is cs.OnlineConnectionState) {
              return BlocBuilder<BookMarkCubit, BookMarkState>(
                  builder: (context, state) {
                if (state is InitBookMarkState ||
                    state is LoadingBookMarkState) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ));
                } else if (state is SuccessBookMarkState) {
                  return ListView.builder(
                    itemCount: state.ids.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LyricScreen(
                                          trackId: state.ids[index]['id']!,
                                          name: state.ids[index]['name']!,
                                        ))),
                            title: Text(
                              state.ids[index]['name']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                } else if (state is NoDateBookMarkState) {
                  return const Center(
                      child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ));
                } else {
                  return const Center(
                      child: Text(
                    "Oops! something went wrong",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ));
                }
              });
            } else {
              return const Center(
                  child: Text(
                "No Internet",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ));
            }
          },
        ),
      ),
    );
  }
}
