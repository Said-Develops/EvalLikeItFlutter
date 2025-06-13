import 'dart:convert'; 
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class PhotoService {
  static const String _accessKey =
      '2v0Ml_-zSCpdO-bhgIkc8tIsuuTjBUcgrmB59yztmOc'; 

  static Future<List<Photo>> fetchPhotos({int count = 20}) async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos?per_page=$count'),
      headers: {'Authorization': 'Client-ID $_accessKey'},
    );


      List data = json.decode(response.body);
      List<Photo> photos =
          data.map((jsonItem) {
            return Photo(
              id: jsonItem['id'],
              createdAt:
                  DateTime.tryParse(jsonItem['created_at'] ?? "") ??
                  DateTime.now(),
              updatedAt:
                  DateTime.tryParse(jsonItem['updated_at'] ?? "") ??
                  DateTime.now(),
              width: jsonItem['width'] ?? 0,
              height: jsonItem['height'] ?? 0,
              color: jsonItem['color'] ?? "",
              likes: jsonItem['likes'] ?? 0,
              downloads:
                  jsonItem['downloads'] ??
                  0,
              description: jsonItem['description'] ?? "",
              author: jsonItem['user']?['name'] ?? "",
              url: jsonItem['urls']?['regular'] ?? "",
            );
          }).toList();
      return photos;
    } 
  }

