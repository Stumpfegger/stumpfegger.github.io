import 'package:hive_flutter/hive_flutter.dart';
import '../models/story.dart';

class StorageService {
  static const String _boxName = 'stories';
  late final Box<Story> _storiesBox;

  StorageService() {
    _storiesBox = Hive.box<Story>(_boxName);
  }

  /// Save a story to the local library
  Future<void> saveStory(Story story) async {
    try {
      // Check if story with same title already exists
      final existingStory = _storiesBox.values
          .where((s) => s.title.toLowerCase() == story.title.toLowerCase())
          .firstOrNull;
      
      if (existingStory != null) {
        // Find the key of the existing story and delete it
        final key = _storiesBox.keys.firstWhere(
          (k) => _storiesBox.get(k) == existingStory,
          orElse: () => -1,
        );
        if (key != -1) {
          await _storiesBox.delete(key);
        }
      }
      
      // Add new story
      await _storiesBox.add(story);
    } catch (e) {
      throw Exception('Failed to save story: $e');
    }
  }

  /// Get all saved stories
  List<Story> getAllStories() {
    try {
      return _storiesBox.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Newest first
    } catch (e) {
      throw Exception('Failed to get stories: $e');
    }
  }

  /// Get a specific story by index
  Story? getStoryAt(int index) {
    try {
      final stories = getAllStories();
      if (index >= 0 && index < stories.length) {
        return stories[index];
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get story at index $index: $e');
    }
  }

  /// Delete a story from the library
  Future<void> deleteStory(Story story) async {
    try {
      // Find the key of the story and delete it
      final key = _storiesBox.keys.firstWhere(
        (k) => _storiesBox.get(k) == story,
        orElse: () => -1,
      );
      if (key != -1) {
        await _storiesBox.delete(key);
      }
    } catch (e) {
      throw Exception('Failed to delete story: $e');
    }
  }

  /// Delete all stories from the library
  Future<void> deleteAllStories() async {
    try {
      await _storiesBox.clear();
    } catch (e) {
      throw Exception('Failed to delete all stories: $e');
    }
  }

  /// Get the total number of saved stories
  int getStoryCount() {
    try {
      return _storiesBox.length;
    } catch (e) {
      throw Exception('Failed to get story count: $e');
    }
  }

  /// Check if a story with given title exists
  bool storyExists(String title) {
    try {
      return _storiesBox.values
          .any((story) => story.title.toLowerCase() == title.toLowerCase());
    } catch (e) {
      throw Exception('Failed to check if story exists: $e');
    }
  }

  /// Search stories by title or theme
  List<Story> searchStories(String query) {
    try {
      if (query.isEmpty) return getAllStories();
      
      final lowercaseQuery = query.toLowerCase();
      return _storiesBox.values
          .where((story) =>
              story.title.toLowerCase().contains(lowercaseQuery) ||
              story.theme.toLowerCase().contains(lowercaseQuery))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      throw Exception('Failed to search stories: $e');
    }
  }

  /// Get stories created in the last N days
  List<Story> getRecentStories(int days) {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      return _storiesBox.values
          .where((story) => story.createdAt.isAfter(cutoffDate))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      throw Exception('Failed to get recent stories: $e');
    }
  }
}
