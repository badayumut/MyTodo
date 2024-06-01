import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo/service/todo_notifier.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/models.dart';
import '../service/getcolor.dart';
import '../widgets/add_bottom_sheet.dart';
import '../widgets/myExpansionTile.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoNotifier todoNotifier = TodoNotifier();


  @override
  Widget build(BuildContext context) {
    todoNotifier = Provider.of<TodoNotifier>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text("To-do List", style: GoogleFonts.poppins(
          letterSpacing: 0,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddBottomSheet(callback: () {  },));
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          if( todoNotifier.categorizedTodos['notCompleted']!.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.all(21.0),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.secondary, size: 30,),
                      const SizedBox(width: 16,),
                      Text(
                        "All Completed",
                        style: GoogleFonts.poppins(
                          letterSpacing: 0,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final todo = todoNotifier.categorizedTodos['notCompleted']![index];
                return TodoItem(todo: todo);
              },
              childCount: todoNotifier.categorizedTodos['notCompleted']!.length,
            ),
          ),
          SliverToBoxAdapter(
            child: MyExpansionTile(
              visualDensity: VisualDensity.compact,
              initiallyExpanded: true,
              dense: true,
              tilePadding:
              const EdgeInsets.only(left: 20, right: 16, top: 14),
              title: Text("Completed",  style: GoogleFonts.poppins(
                letterSpacing: 0,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),),
              children: [
                ListView.builder(
                    padding: const EdgeInsets.only(),
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemCount:
                    todoNotifier.categorizedTodos['completed']!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = todoNotifier.categorizedTodos['completed']![index];
                      return TodoItem(todo: todo);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
