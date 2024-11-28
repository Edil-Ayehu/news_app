import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';
import 'package:news_app/core/utils/helpers.dart';
import 'package:news_app/models/comment_model.dart';

class CommentSection extends StatelessWidget {
  final List<Comment> comments;
  final Function(String) onLikeComment;
  final Function(String) onReplyComment;
  final Function(String) onSubmitComment;

  const CommentSection({
    super.key,
    required this.comments,
    required this.onLikeComment,
    required this.onReplyComment,
    required this.onSubmitComment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 16,
            vertical: 12,
          ),
          child: Text(
            '${comments.length} Comments',
            style: textTheme.titleLarge,
          ),
        ),
        _CommentInput(onSubmit: onSubmitComment),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return _CommentTile(
              comment: comments[index],
              onLike: onLikeComment,
              onReply: onReplyComment,
            );
          },
        ),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;
  final Function(String) onLike;
  final Function(String) onReply;

  const _CommentTile({
    required this.comment,
    required this.onLike,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: isTablet ? 24 : 20,
            backgroundImage: comment.avatarUrl != null
                ? NetworkImage(comment.avatarUrl!)
                : null,
            child: comment.avatarUrl == null
                ? Text(comment.author[0].toUpperCase())
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.author,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Helpers.getTimeAgo(comment.timestamp),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        comment.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: comment.isLiked
                            ? (isDark
                                ? ThemeConstants.primaryDark
                                : ThemeConstants.primaryLight)
                            : null,
                      ),
                      onPressed: () => onLike(comment.id),
                    ),
                    Text(
                      comment.likes.toString(),
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () => onReply(comment.id),
                      child: Text('Reply'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  final Function(String) onSubmit;

  const _CommentInput({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isTablet ? 24 : 20,
            child: const Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDark
                    ? ThemeConstants.surfaceDark
                    : ThemeConstants.surfaceLight,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.send,
              color: isDark
                  ? ThemeConstants.primaryDark
                  : ThemeConstants.primaryLight,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSubmit(controller.text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}