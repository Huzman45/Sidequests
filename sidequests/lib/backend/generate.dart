import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> storylineGen(String tasks, String prev) async {
  await dotenv.load(fileName: "lib/backend/.env");
  OpenAI.apiKey = dotenv.env["OPENAI_API_KEY"]!;
  String story_prompt = tasks;
  // Start using!
  final completion = await OpenAI.instance.completion.create(
      model: "gpt-3.5-turbo-instruct",
      prompt:
          '''Continue from ${prev.toString()}, Craft an short and interesting game storyline for me playing an adventure
     game where I must complete the task: $story_prompt. Keep my task description adventurous, concise and 2 sentences. 
     The narrative should build anticipation and curiosity, 
      encouraging me to complete the task and conclude the story 
      with a satisfying resolution that leaves me with a sense of accomplishment and excitement. Always refer to me in the 1st person.
''',
      maxTokens: 1000);

  // Printing the output to the console
  return completion.choices[0].text.toString().trim();
}

Future<void> main() async {
  List a = List.from(["meet with project supervisor", "buy groceries"]);
  String w = "";
  for (String q in a) {
    String prev = storylineGen(q, w).toString();
    w = prev;
  }
}
