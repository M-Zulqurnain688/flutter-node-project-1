import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_backend_app/config/api_config.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  String responseMessage = '';
  bool isLoading = false;

  // 🔹 Change this URL based on platform
  // String backendUrl() {
  //   // Flutter Web
  //   return 'http://localhost:3000';
  //   // Android Emulator
  //   // return 'http://10.0.2.2:3000';
  //   // Real device (replace with your PC IP)
  //   // return 'http://192.168.1.10:3000';
  // }

  // Post Method
  Future<void> sendData() async {
    if (nameController.text.trim().isEmpty) {
      setState(() {
        responseMessage = 'please enter a anme';
      });
      return;
    }

    setState(() {
      isLoading = true;
      responseMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/greet'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': nameController.text.trim()}),
      );

      final data = jsonDecode(response.body);
      setState(() {
        responseMessage = data['message'] ?? data['error'];
      });
    } catch (e) {
      setState(() {
        responseMessage = 'Error connecting to backend';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  // Get Method
  // Future<void> fetchMessage() async {
  //   // final response = await http.get(Uri.parse('http://10.0.2.2:3000/hello'));
  //   // final response = await http.get(Uri.parse('http://192.168.1.5:3000/hello'));
  //   final response = await http.get(Uri.parse('http://localhost:3000/hello'));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       responseMessage = data['message'];
  //     });
  //   } else {
  //     setState(() {
  //       responseMessage = "Error fetching data";
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchMessage();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('POST API Example With Node.JS')),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Enter your name'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              sendData();
            },
            child: isLoading
                ? const CircularProgressIndicator(color: Color(0xFFFFFFFF))
                : Text("Register"),
          ),
          const SizedBox(height: 20),
          Text(
            responseMessage,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
