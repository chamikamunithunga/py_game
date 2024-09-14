import 
name: game1

description: A new Flutter project.



# The following line prevents the package from being accidentally published to pub.dev using `pub publish`.

publish_to: 'none' # Remove this line if you wish to publish to pub.dev



# The following defines the version and build number for your application.

# A version number is three numbers separated by dots, like 1.2.43

# followed by an optional build number separated by a +.

# Both the version and the builder number may be overridden in flutter

# build by specifying --build-name and --build-number, respectively.

# In Android, build-name is used as versionName while build-number used as versionCode.

# Read more about Android versioning at https://developer.android.com/studio/publish/versioning

# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.

version: 1.0.0+1



environment:

  sdk: ">=2.12.0 <3.0.0"



dependencies:

  flutter:

    sdk: flutter



  # The following adds the Cupertino Icons font to your application.

  # Use with the CupertinoIcons class for iOS style icons.

  cupertino_icons: ^1.0.2



dev_dependencies:

  flutter_test:

    sdk: flutter



flutter:

  uses-material-design: true
;
import 'number_guessing_game.dart';  // Import the game logic

void main() {
  runApp(GuessingGameApp());
}

class GuessingGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuessingGameScreen(),
    );
  }
}

class GuessingGameScreen extends StatefulWidget {
  @override
  _GuessingGameScreenState createState() => _GuessingGameScreenState();
}

class _GuessingGameScreenState extends State<GuessingGameScreen> {
  final TextEditingController _controller = TextEditingController();
  String _message = '';
  String _hint = '';
  NumberGuessingGame _game;
  String _difficulty = 'easy';

  @override
  void initState() {
    super.initState();
    _game = NumberGuessingGame(_difficulty);  // Initialize game with default difficulty
  }

  void _handleGuess() {
    setState(() {
      int guess = int.tryParse(_controller.text) ?? 0;
      _message = _game.makeGuess(guess);
      if (_game.isGameOver()) {
        _message = 'Game Over. The correct number was ${_game.numberToGuess}.';
      } else {
        _hint = _game.provideHint();
      }
    });
  }

  void _restartGame() {
    setState(() {
      _game = NumberGuessingGame(_difficulty);
      _message = '';
      _hint = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _difficulty,
              onChanged: (String newValue) {
                setState(() {
                  _difficulty = newValue;
                  _restartGame();  // Restart the game when difficulty changes
                });
              },
              items: <String>['easy', 'medium', 'hard'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your guess',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleGuess,
              child: Text('Submit Guess'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _hint,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _restartGame,
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
