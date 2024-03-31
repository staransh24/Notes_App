import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key,required this.isUpdate, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  FocusNode notefocus = FocusNode();

  void addNewNote(){
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "ansh",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );
    
    Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote(){
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context,listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            if(widget.isUpdate){
              updateNote();
            }
            else {
              addNewNote();
            }

          }, icon: const Icon(Icons.done_sharp))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (value) {
                  if(value!="") {
                    notefocus.requestFocus();
                  }
                },
                autofocus:(widget.isUpdate == true)? false: true,
                decoration: const InputDecoration(hintText: "Title",border: InputBorder.none),
                style: GoogleFonts.inter(fontSize:35,fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: notefocus,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Content",border: InputBorder.none),
                  style: GoogleFonts.inter(fontSize:20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
