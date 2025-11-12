import 'package:flutter/material.dart';
import '../models/feedback_model.dart';
import '../widgets/rating_widget.dart';
import 'feedback_result.dart';

class FeedbackFormScreen extends StatefulWidget {
  @override
  _FeedbackFormScreenState createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Feedback',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildProfileHeader(),
                SizedBox(height: 30),
                _buildNameField(),
                SizedBox(height: 20),
                _buildCommentField(),
                SizedBox(height: 30),
                _buildRatingSection(),
                SizedBox(height: 40),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Feedback Form',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Bagikan pengalaman Anda dengan kami',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Nama',
        prefixIcon: Icon(Icons.person, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap masukkan nama';
        }
        return null;
      },
    );
  }

  Widget _buildCommentField() {
    return TextFormField(
      controller: _commentController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Komentar',
        alignLabelWithHint: true,
        prefixIcon: Icon(Icons.comment, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap masukkan komentar';
        }
        return null;
      },
    );
  }

  Widget _buildRatingSection() {
    return Column(
      children: [
        Text(
          'Rating',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 10),
        RatingWidget(
          initialRating: _rating,
          onRatingChanged: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        SizedBox(height: 10),
        Text(
          _rating == 0 ? 'Pilih rating' : 'Rating: $_rating/5',
          style: TextStyle(
            fontSize: 16,
            color: _rating == 0 ? Colors.grey : Colors.amber.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Kirim Feedback',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _rating > 0) {
      final feedback = FeedbackModel(
        name: _nameController.text,
        comment: _commentController.text,
        rating: _rating,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackResultScreen(feedback: feedback),
        ),
      );
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap pilih rating terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}