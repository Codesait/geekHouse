import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final supabaseUrl = dotenv.get('AUTH_URL');
  static final anonKey = dotenv.get('ANON_KEY');
  static final cloudName = dotenv.get('CLOUD_NAME');
  static final apiKey = dotenv.get('CLOUDINARY_API_KEY');
  static final apiSecret = dotenv.get('CLOUDINARY_API_SECRET');
  static final uploadPreset = dotenv.get('CLOUDINARY_PRESET');
}
