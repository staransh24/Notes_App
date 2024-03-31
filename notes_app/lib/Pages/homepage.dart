import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Pages/add_note.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Notes App",
            style: GoogleFonts.zillaSlab(
                fontSize: 35, fontWeight: FontWeight.w600),
          ),
          actions: [
            GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                )),
            GestureDetector(
                onTap: () {},
                child: const Icon(
                    Icons.sunny
                )),
            const SizedBox(width: 7,)
          ],

      ),
      body:(notesProvider.isLoading == false)? SafeArea(
        child:(notesProvider.notes.isNotEmpty)? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              Note currentNote = notesProvider.notes[index];
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.deepOrangeAccent),
                margin: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => AddNewNotePage(
                                          isUpdate: true, note: currentNote),
                                    ));
                              },
                              child: const Icon(Icons.edit)),
                          GestureDetector(
                              onTap: () {
                                notesProvider.deleteNote(currentNote);
                              },
                              child: const Icon(Icons.delete)),
                        ],
                      ),
                      Text(
                        currentNote.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSerif(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentNote.content!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSerif(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.black45),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
      ):const Center(
        child: Text("Click on '+' to add notes."),
      ),
        ):const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    // fullscreenDialog: true,
                    builder: (context) => const AddNewNotePage(
                          isUpdate: false,
                        )));
          },
          child: const Icon(Icons.add)),
    );
  }
}
