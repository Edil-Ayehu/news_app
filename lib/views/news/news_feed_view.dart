import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/views/auth/login_view.dart';
import 'package:news_app/widgets/news/category_chip.dart';
import 'package:news_app/widgets/news/article_card.dart';

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
  final _authController = Get.find<AuthController>();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final newArticles = [
      Article(
        id: 'tech_1',
        title: 'AI Revolution: Latest Developments in Machine Learning',
        description:
            'New breakthroughs in AI technology are reshaping the future of computing.',
        content: 'Full article content here...',
        author: 'Tech Reporter',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrl: 'https://picsum.photos/800/400?random=1',
        category: Category(id: '1', name: 'Technology'),
        readTime: 4,
        isBookmarked: false,
        sourceUrl: 'https://technews.com/ai-news',
        sourceName: 'TechNews',
      ),
      Article(
        id: 'tech_2',
        title: 'AI Revolution: Latest Developments in Machine Learning',
        description:
            'New breakthroughs in AI technology are reshaping the future of computing.',
        content: 'Full article content here...',
        author: 'Tech Reporter',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrl: 'https://picsum.photos/800/400?random=1',
        category: Category(id: '1', name: 'Technology'),
        readTime: 4,
        isBookmarked: false,
        sourceUrl: 'https://technews.com/ai-news',
        sourceName: 'TechNews',
      ),
      Article(
        id: 'tech_3',
        title: 'AI Revolution: Latest Developments in Machine Learning',
        description:
            'New breakthroughs in AI technology are reshaping the future of computing.',
        content: 'Full article content here...',
        author: 'Tech Reporter',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrl: 'https://picsum.photos/800/400?random=1',
        category: Category(id: '1', name: 'Technology'),
        readTime: 4,
        isBookmarked: false,
        sourceUrl: 'https://technews.com/ai-news',
        sourceName: 'TechNews',
      ),
      Article(
        id: 'tech_4',
        title: 'AI Revolution: Latest Developments in Machine Learning',
        description:
            'New breakthroughs in AI technology are reshaping the future of computing.',
        content: 'Full article content here...',
        author: 'Tech Reporter',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        imageUrl: 'https://picsum.photos/800/400?random=1',
        category: Category(id: '1', name: 'Technology'),
        readTime: 4,
        isBookmarked: false,
        sourceUrl: 'https://technews.com/ai-news',
        sourceName: 'TechNews',
      ),
      // ... your other article definitions ...
    ];

    // Filter articles by selected category
    final filteredArticles = _selectedCategory == 'All'
        ? newArticles
        : newArticles
            .where((article) => article.category.name == _selectedCategory)
            .toList();

    setState(() {
      _articles = filteredArticles;
      _isLoading = false;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _articles.clear();
    });
    _loadArticles();
  }

  Future<void> _handleRefresh() async {
    _articles.clear();
    await _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await _authController.signOut();
              Get.offAll(() => const LoginView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category List
          SizedBox(
            height: isTablet ? 60 : 50,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 16,
                vertical: isTablet ? 10 : 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return CategoryChip(
                  label: category.name,
                  isSelected: category.name == _selectedCategory,
                  onTap: () => _onCategorySelected(category.name),
                );
              },
            ),
          ),
          // News List
          Expanded(
            child: _articles.isEmpty && _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _articles.isEmpty
                    ? const Center(child: Text('No articles available'))
                    : RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 24 : 16,
                                vertical: isTablet ? 20 : 16,
                              ),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width > 1200
                                      ? 4
                                      : (isTablet ? 2 : 1),
                                  mainAxisSpacing: isTablet ? 20 : 16,
                                  crossAxisSpacing: isTablet ? 20 : 16,
                                  childAspectRatio: size.width > 1200
                                      ? 0.6
                                      : (isTablet
                                          ? 0.55
                                          : 0.8),
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final article = _articles[index];
                                    return ArticleCard(
                                      title: article.title,
                                      description: article.description,
                                      imageUrl: article.imageUrl,
                                      author: article.author,
                                      publishedAt: article.publishedAt,
                                      category: article.category.name,
                                      isSaved: article.isBookmarked,
                                      onTap: () {
                                        // TODO: Navigate to article detail
                                      },
                                      onSaveToggle: () {
                                        // TODO: Implement bookmark functionality
                                        setState(() {
                                          _articles[index] = article.copyWith(
                                            isBookmarked: !article.isBookmarked,
                                          );
                                        });
                                      },
                                    );
                                  },
                                  childCount: _articles.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
