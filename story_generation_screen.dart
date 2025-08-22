import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import '../models/story.dart';
import 'story_viewer_screen.dart';

class StoryGenerationScreen extends StatefulWidget {
  const StoryGenerationScreen({super.key});

  @override
  State<StoryGenerationScreen> createState() => _StoryGenerationScreenState();
}

class _StoryGenerationScreenState extends State<StoryGenerationScreen> {
  final TextEditingController _themeController = TextEditingController();
  final AIService _aiService = AIService();
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    // Tesztelés az oldal betöltésekor
    _testAIConnection();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  /// Tests the FREE GPT-2 AI model connection
  Future<void> _testAIConnection() async {
    try {
      print('🔍 Testing Ollama AI connection...');
      
      // Test Ollama connection
      final isWorking = await _aiService.testApiConnection();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isWorking 
                ? '✅ Ollama AI modell működik!' 
                : '⚠️ Ollama nem elérhető - kreatív fallback mese lesz használva'
            ),
            backgroundColor: isWorking ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      print('Error testing Ollama AI model: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Hiba történt az AI kapcsolat tesztelésekor'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _generateStory() async {
    final theme = _themeController.text.trim();
    if (theme.isEmpty) {
      _showSnackBar('Kérlek írd be a mese témáját!');
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    try {
      // Show progress dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const _GenerationProgressDialog(),
      );

      // Generate story text
      final pages = await _aiService.generateStory(theme);
      
      // No images needed - text-only stories
      final images = List.generate(pages.length, (index) => '');

      // Close progress dialog
      Navigator.of(context).pop();

      // Navigate to story viewer
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StoryViewerScreen(
              story: Story(
                title: theme,
                pages: pages,
                images: images,
                theme: theme,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      // Close progress dialog
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      if (mounted) {
        _showSnackBar('Hiba történt: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Új mese generálása'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Top spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            
            // Story icon and title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Story icon
                    Icon(
                      Icons.auto_stories,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    
                    // Title
                    Text(
                      'Mese témája',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Description
                    Text(
                      'Írd be a mese főszereplőit vagy témáját',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Middle spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            
            // Input field
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _themeController,
                  decoration: const InputDecoration(
                    hintText: 'Például: kiskutya és robot',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(Icons.edit, color: Colors.blue),
                  ),
                  style: const TextStyle(fontSize: 18),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                ),
              ),
            ),
            
            // Button spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            
            // Generate button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isGenerating ? null : _generateStory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 8,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: _isGenerating
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Generálás...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.auto_awesome, size: 24),
                            SizedBox(width: 16),
                            Text(
                              'Generálás',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
                ),
              ),
            ),
            
            // Tips spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
            
            // Tips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white30),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.yellow[300],
                      size: 30,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tippek:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Használj egyszerű, érthető szavakat\n'
                      '• Írd le a főszereplőket\n'
                      '• Vagy írd le a mese témáját',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                ),
              ),
            ),
            
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }
}

/// Progress dialog shown during story generation
class _GenerationProgressDialog extends StatelessWidget {
  const _GenerationProgressDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 4,
            ),
            const SizedBox(height: 24),
            Text(
              'Mese generálása...',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ez eltarthat néhány percig.\nKérlek várj türelmesen!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
