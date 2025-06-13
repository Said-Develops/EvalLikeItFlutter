import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoPreview extends StatelessWidget {
  final Photo photo;
  final bool isLiked;
  final VoidCallback onLike; 

  const PhotoPreview({
    super.key,
    required this.photo,
    required this.isLiked,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isLiked ? Colors.pink.shade50 : null, 
      leading:
          (photo.url != '')
              ? Image.network(
                photo.url,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
              : const Icon(Icons.image),
      title: Text(
        photo.description.isNotEmpty
            ? photo.description
            : '(Aucune description)',
      ),
      subtitle: Text('par ${photo.author} – ${photo.likes} likes'),
      trailing: IconButton(
        icon: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.pink : Colors.grey,
        ),
        onPressed: onLike,
      ),
      onTap: onLike, 
    );
  }
}
