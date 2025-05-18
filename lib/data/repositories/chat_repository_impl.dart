import 'package:travel_agent/data/api/chat_api.dart';
import 'package:travel_agent/domain/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';
import '../../config/supabase_config.dart';
import '../../domain/models/chat_message.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApi _api;
  final String _sessionId;
  final _uuid = const Uuid();

  ChatRepositoryImpl(this._api) : _sessionId = const Uuid().v4();

  String get sessionId => _sessionId;

  @override
  Future<String> sendMessage(String message) async {
    return await _api.sendMessage(message);
  }

  Future<void> saveMessage(ChatMessage message) async {
    try {
      print('Saving message to Supabase: ${message.toJson()}');
      final response = await SupabaseConfig.client
          .from('chat_messages')
          .insert(message.toJson());
      print('Message saved successfully: $response');
    } catch (e) {
      print('Error saving message to Supabase: $e');
      // You might want to implement retry logic or error handling here
    }
  }

  Future<List<ChatMessage>> getChatHistory() async {
    try {
      print('Fetching chat history for session: $_sessionId');
      final response = await SupabaseConfig.client
          .from('chat_messages')
          .select()
          .eq('session_id', _sessionId)
          .order('timestamp');

      print('Chat history response: $response');
      return (response as List)
          .map((json) => ChatMessage.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching chat history from Supabase: $e');
      return [];
    }
  }

  String generateMessageId() => _uuid.v4();
}
