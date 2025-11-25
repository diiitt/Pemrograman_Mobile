import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoService {
  static const String _todoKey = 'todos';

  Future<List<Todo>> getTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? todosString = prefs.getString(_todoKey);
      
      if (todosString == null || todosString.isEmpty) return [];
      
      // Parse JSON array yang benar
      final List<dynamic> todosJson = todosString.split('||').map((item) {
        if (item.isEmpty) return null;
        try {
          final parts = item.split('|');
          if (parts.length != 4) return null;
          
          return {
            'id': int.parse(parts[0]),
            'title': parts[1],
            'isCompleted': parts[2] == 'true',
            'createdAt': parts[3],
          };
        } catch (e) {
          return null;
        }
      }).where((item) => item != null).toList();
      
      return todosJson.map((json) => Todo.fromJson(json!)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (todos.isEmpty) {
        await prefs.remove(_todoKey);
        return;
      }
      
      final String todosString = todos.map((todo) {
        return '${todo.id}|${todo.title.replaceAll('|', '-')}|${todo.isCompleted}|${todo.createdAt.toIso8601String()}';
      }).join('||');
      
      await prefs.setString(_todoKey, todosString);
    } catch (e) {
      print('Error saving todos: $e');
    }
  }

  Future<int> getNextId() async {
    final todos = await getTodos();
    if (todos.isEmpty) return 1;
    return todos.map((todo) => todo.id).reduce((a, b) => a > b ? a : b) + 1;
  }
}