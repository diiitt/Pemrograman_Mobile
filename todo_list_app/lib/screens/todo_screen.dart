import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _editTextController = TextEditingController();
  
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  TodoFilter _currentFilter = TodoFilter.all;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() => _isLoading = true);
    final todos = await _todoService.getTodos();
    setState(() {
      _todos = todos;
      _applyFilter();
      _isLoading = false;
    });
  }

  void _applyFilter() {
    switch (_currentFilter) {
      case TodoFilter.all:
        _filteredTodos = List.from(_todos);
        break;
      case TodoFilter.completed:
        _filteredTodos = _todos.where((todo) => todo.isCompleted).toList();
        break;
      case TodoFilter.pending:
        _filteredTodos = _todos.where((todo) => !todo.isCompleted).toList();
        break;
    }
  }

  Future<void> _addTodo() async {
    final title = _textEditingController.text.trim();
    if (title.isEmpty) return;

    final newTodo = Todo(
      id: await _todoService.getNextId(),
      title: title,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    setState(() {
      _todos.add(newTodo);
      _applyFilter();
    });

    _textEditingController.clear();
    await _todoService.saveTodos(_todos);
  }

  Future<void> _toggleTodo(int id) async {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isCompleted = !todo.isCompleted;
      _applyFilter();
    });
    await _todoService.saveTodos(_todos);
  }

  Future<void> _deleteTodo(int id) async {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
      _applyFilter();
    });
    await _todoService.saveTodos(_todos);
  }

  Future<void> _editTodo(Todo todo) async {
    _editTextController.text = todo.title;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: TextField(
          controller: _editTextController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Masukkan todo baru',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newTitle = _editTextController.text.trim();
              if (newTitle.isNotEmpty) {
                setState(() {
                  todo.title = newTitle;
                  _applyFilter();
                });
                await _todoService.saveTodos(_todos);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _setFilter(TodoFilter filter) {
    setState(() {
      _currentFilter = filter;
      _applyFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('Semua', TodoFilter.all),
                _buildFilterChip('Selesai', TodoFilter.completed),
                _buildFilterChip('Belum Selesai', TodoFilter.pending),
              ],
            ),
          ),

          // Input Todo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Tambahkan todo baru...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: _addTodo,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Todo List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTodos.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada todo',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredTodos.length,
                        itemBuilder: (context, index) {
                          final todo = _filteredTodos[index];
                          return _buildTodoItem(todo);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, TodoFilter filter) {
    return ChoiceChip(
      label: Text(label),
      selected: _currentFilter == filter,
      onSelected: (_) => _setFilter(filter),
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: _currentFilter == filter ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildTodoItem(Todo todo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => _toggleTodo(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(
          'Dibuat: ${_formatDate(todo.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editTodo(todo),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTodo(todo.id),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

enum TodoFilter { all, completed, pending }