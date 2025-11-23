import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubProfileViewer extends StatelessWidget {
  final String username;

  const GitHubProfileViewer({Key? key, required this.username}) : super(key: key);

  Future<void> _launchGitHubProfile() async {
    final Uri url = Uri.parse('https://github.com/$username');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'with an option to retry if possible $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Viewing GitHub profile for: $username'),
                        ElevatedButton(
              onPressed: _launchGitHubProfile,
              child: const Text('Open GitHub Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
void main() {
  runApp(MaterialApp(
    home: GitHubProfileViewer(username: 'octocat'), // Replace 'octocat' with the desired username
  ));
}