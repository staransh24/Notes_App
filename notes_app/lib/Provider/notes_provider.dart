import 'package:flutter/cupertino.dart';
import 'package:notes_app/Services/api_service.dart';

import '../Models/note_model.dart';

class NotesProvider with ChangeNotifier{

  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider(){
    fetchNotes();
  }

  void sortNotes(){
    notes.sort((a,b)=> b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note){
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async{
    notes = await ApiService.fetchNotes("ansh");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

}