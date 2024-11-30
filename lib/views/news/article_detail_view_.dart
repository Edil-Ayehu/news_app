import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/widgets/news/category_chip.dart';

class NewsFeedView extends StatefulWidget {
  const NewsFeedView({super.key});

  @override
  State<NewsFeedView> createState() => _NewsFeedViewState();
}

class _NewsFeedViewState extends State<NewsFeedView> {
  final _scrollController = ScrollController();
  final _categories = Category.defaultCategories();
  bool _isLoading = false;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    // TODO: Implement article loading logic
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadArticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text('News Feed'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(isTablet ? 60 : 50),
              child: Container(
                height: isTablet ? 60 : 50,
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: isTablet ? 12 : 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return CategoryChip(
                      label: category.name,
                      isSelected: category.isSelected,
                      onTap: () {
                        setState(() {
                          for (var i = 0; i < _categories.length; i++) {
                            _categories[i] = _categories[i].copyWith(
                              isSelected: i == index,
                            );
                          }
                        });
                        _loadArticles();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 24 : 16,
              vertical: isTablet ? 20 : 16,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 1200 ? 4 : (isTablet ? 3 : 1),
                mainAxisSpacing: isTablet ? 20 : 16,
                crossAxisSpacing: isTablet ? 20 : 16,
                childAspectRatio: isTablet ? 0.8 : 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == _articles.length) {
                    return _isLoading ? _buildLoadingCard() : null;
                  }
                  return _ArticleCard(article: _articles[index]);
                },
                childCount: _articles.length + (_isLoading ? 1 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Article article;

  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to article detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: isDark ? ThemeConstants.surfaceDark : ThemeConstants.surfaceLight,
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 16 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isTablet ? 12 : 8),
                    Text(
                      article.description,
                      style: textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: isTablet ? 18 : 16,
                          color: isDark ? ThemeConstants.textSecondaryDark : ThemeConstants.textSecondaryLight,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${article.readTime} min read',
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark ? ThemeConstants.textSecondaryDark : ThemeConstants.textSecondaryLight,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            article.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight,
                          ),
                          onPressed: () {
                            // TODO: Implement bookmark functionality
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
