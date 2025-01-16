import 'package:flutter/material.dart';
import 'database_helper.dart';

class ReviewsPage extends StatelessWidget {
  final String masterName;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ReviewsPage({required this.masterName});

  Future<List<Map<String, dynamic>>> _loadReviews() async {
    return await _databaseHelper.getReviewsByMaster(masterName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отзывы: $masterName'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки отзывов: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Отзывов пока нет.'));
          } else {
            final reviews = snapshot.data!;
            final ratings = reviews.map((e) => e['rating'] as int).toList();
            final averageRating = ratings.isNotEmpty
                ? ratings.reduce((a, b) => a + b) / ratings.length
                : 0;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Средний рейтинг: ${averageRating.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      final comment = review['comment'] ?? 'Комментарий отсутствует';
                      final rating = review['rating'];

                      return ListTile(
                        title: Text('Рейтинг: $rating'),
                        subtitle: Text(comment),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
