import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://lepgrlxceccoozfozkay.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlcGdybHhjZWNjb296Zm96a2F5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc1NDc2NDEsImV4cCI6MjA2MzEyMzY0MX0.nPvoNGCBor1_DemgVoZti-XHaKfAh6hiup2wwlYSS68';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
