import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ChatbotApp());
}

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedBuddy Powered by Palm 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [
    Message(
      text: "I am experiencing a terrible headache",
      sender: Sender.user,
    ),
    Message(
      text:
          """MedBuddy: I'm sorry to hear that you're having a bad headache. Headaches can be caused by a variety of factors, including stress, dehydration, lack of sleep, or it could be a symptom of a medical condition. Here are a few questions to help understand your situation better: 
 
* Can you describe the pain? (Is it throbbing, constant, dull, or sharp?) 
* Have you noticed anything that makes the headaches better or worse? 
* Do you have any other symptoms, such as nausea or vision changes? 
* Have you recently changed your diet, caffeine intake, or sleep patterns? 
* Are you experiencing any stress or anxiety? 
 
Remember, while I can provide some general advice and information, it's important to consult with a healthcare professional for an accurate diagnosis and appropriate treatment, especially if your headache is severe, persistent, or associated with other symptoms. 
 
If this is an emergency or if you're experiencing the worst headache of your life, sudden vision changes, problems with speech, or weakness in your limbs, seek medical attention immediately. 
 
Would you like some suggestions for home remedies, or would you prefer to get information on when to seek medical help? 
""",
      sender: Sender.bot,
    ),
    Message(
      text: "I have been sneezing for the past couple of days",
      sender: Sender.user,
    ),
    Message(
      text:
          """ MedBuddy: Sneezing is a common reflex that helps to clear the nose of irritants, such as dust, pollen, or mucus. It is usually caused by a viral infection, such as the common cold, but it can also be caused by allergies, irritants in the air, or certain medications. 
 
If you have been sneezing for the past couple of days, it is important to try to identify the cause. If you have a cold or the flu, you will likely experience other symptoms, such as a runny nose, sore throat, and cough. If you have allergies, you may also experience a runny nose, itchy eyes, and a rash. If you are exposed to irritants in the air, such as dust or smoke, you may also experience sneezing, coughing, and a runny nose. 
 
If you are not sure what is causing your sneezing, it is best to see a doctor. They can help you to identify the cause and recommend treatment. In the meantime, there are some things you can do to help relieve your symptoms. 
 
* Drink plenty of fluids to stay hydrated. 
* Use a humidifier to add moisture to the air. 
* Take over-the-counter medications, such as ibuprofen or acetaminophen, to help relieve pain and fever. 
* Use a saline nasal spray to help clear out your sinuses. 
* Avoid touching your face, as this can spread germs. 
* Wash your hands often with soap and water. 
* Stay home from work or school if you are sick to avoid spreading germs to others. 
 
If your sneezing is severe or persistent, or if you are experiencing other symptoms, such as a fever, headache, or difficulty breathing, it is important to see a doctor right away. """,
      sender: Sender.bot,
    ),
  ];

  String _categoryValue = 'General';
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _messages.insert(
          0, Message(text: _messageController.text, sender: Sender.user));
      _messageController.clear();
    });
    // You should implement your logic to handle the message here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedBuddy Powered by Palm 2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.indigoAccent[200],
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _categoryValue,
                icon: const Icon(Icons.arrow_drop_down_circle,
                    color: Colors.white),
                style: const TextStyle(color: Colors.white, fontSize: 20),
                onChanged: (newValue) {
                  setState(() {
                    _categoryValue = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'General', child: Text('General')),
                  DropdownMenuItem(value: 'Eye', child: Text('Eye')),
                  DropdownMenuItem(value: 'Ear', child: Text('Ear')),
                  DropdownMenuItem(value: 'Mental', child: Text('Mental')),
                  DropdownMenuItem(
                      value: 'Cardiovascular', child: Text('Cardiovascular')),
                  DropdownMenuItem(
                      value: 'Body Pain', child: Text('Body Pain')),
                ],
                dropdownColor: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  bool isBot = msg.sender == Sender.bot;
                  return Align(
                    alignment:
                        isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isBot ? Colors.blue[100] : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isBot)
                            const Icon(Icons.security,
                                size: 20, color: Colors.indigo),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              msg.text,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Briefly Describe your medical concern',
                        hintStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

enum Sender { user, bot }

class Message {
  final String text;
  final Sender sender;

  Message({required this.text, required this.sender});
}
