import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/photo_service.dart';
import '../widgets/photo_preview.dart';



class PhotosMaster extends StatefulWidget {
  const PhotosMaster({super.key});

  @override
  State<PhotosMaster> createState() => _PhotosMasterState();
}

class _PhotosMasterState extends State<PhotosMaster> {
  List<Photo> _photos = [];
  Set<String> _likedPhotoIds = {}; // Pour retenir les photos likées
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    try {
      List<Photo> photos = await PhotoService.fetchPhotos(count: 10);
      setState(() {
        _photos = photos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _toggleLike(String photoId) {
    setState(() {
      if (_likedPhotoIds.contains(photoId)) {
        _likedPhotoIds.remove(photoId);
      } else {
        _likedPhotoIds.add(photoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text('Erreur : $_error')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('LikeIt – Photos')),
      body: ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          final isLiked = _likedPhotoIds.contains(photo.id);

          return PhotoPreview(
            photo: photo,
            isLiked: isLiked,
            onLike: () => _toggleLike(photo.id),
          );
        },
      ),
    );
  }
}
