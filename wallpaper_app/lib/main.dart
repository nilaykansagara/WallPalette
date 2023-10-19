import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper_App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WallpaperButton(),
    );
  }
}

class WallpaperButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Set the appBar to null to remove the default space
      body: Stack(
        children: [
          Image.network(
            'https://i.pinimg.com/736x/d1/cf/7f/d1cf7ff189d8675f7ae42a5562aa6574.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align content to the top and bottom
            children: [
              Expanded(
                child: Container(),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(16), // Padding for the text
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.01), // Transparent black background
                ),
                child: Text(
                  'WallPalette',
                  style: TextStyle(
                    color: Colors.white, // White text
                    backgroundColor: Colors.transparent,
                    fontSize: 50, // Larger font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
              SizedBox(height: 370), // Add space above the text
              Container(
                padding: EdgeInsets.all(16),
                width: 370,
                alignment: Alignment.center, // Center align the text
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4), // Transparent black background
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: Text(
                  'Revamp your space today \nWith colors that convey',
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                    fontSize: 28, // Attractive font size
                    fontWeight: FontWeight.bold, // Bold text
                    fontStyle: FontStyle.italic, // Italic style
                  ),
                ),
              ),
              SizedBox(height: 10), // Add space below the text
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black.withOpacity(0.4), // Transparent black background
                ),
                child: Text(
                  'Get Wallpapers!',
                  style: TextStyle(
                    color: Colors.white, // White text
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
