import '../models/post.dart';

class PostRepository {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void addPost(Post post) {
    _posts.add(post);
  }

  void updatePost(Post post) {
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = post;
    }
  }
}

final postRepository = PostRepository();
