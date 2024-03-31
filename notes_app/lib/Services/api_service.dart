import 'dart:convert';
import 'package:notes_app/Models/note_model.dart';
import "package:http/http.dart" as http;

class ApiService {
  static const String _baseUrl = "https://notes-app-backend-qsrc.onrender.com/notes";
  // static const String _baseUrl = "http://10.0.2.2:2401";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
  // static Future<void> fetchNotes(String userid) async {
    try {
      final uri = Uri.parse("$_baseUrl/list").replace(queryParameters: {
        'userid': userid,
      });
      // print(uri);
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        var decoded = jsonDecode(response.body);

        List<Note> notes = [];
        for (var noteMap in decoded) {
          Note newNote = Note.fromMap(noteMap);
          notes.add(newNote);
        }
        return notes;
      } else {
        // Log the response details for non-200 status codes
        print("Error fetching notes. Status code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return []; // Return an empty list or throw an exception based on your use case.
      }
    } catch (e) {
      // Log any exceptions that occur
      print("Exception during fetchNotes: $e");
      return []; // Return an empty list or throw an exception based on your use case.
    }
  }
}
