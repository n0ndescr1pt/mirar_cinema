import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/profile/bloc/auth_bloc.dart';
import 'package:mirar/src/features/review/bloc/review_bloc/review_bloc.dart';

class CustomSlider extends StatefulWidget {
  final DetailModel film;
  final BuildContext bottomsheetContext;
  const CustomSlider(
      {super.key, required this.film, required this.bottomsheetContext});

  @override
  State<CustomSlider> createState() => _NumberSliderScreen();
}

class _NumberSliderScreen extends State<CustomSlider> {
  final PageController _controller =
      PageController(viewportFraction: 0.25, initialPage: 1);
  int _currentNumber = 1;

  @override
  Widget build(BuildContext context) {
    final numbers = List.generate(10, (index) => index + 1); // 1-10

    return Column(
      children: [
        SizedBox(
          height: 70,
          child: PageView.builder(
            controller: _controller,
            itemCount: numbers.length,
            onPageChanged: (index) {
              setState(() {
                _currentNumber = numbers[index];
              });
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final isSelected = _currentNumber == numbers[index];
              return AnimatedContainer(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.blueGrey.withOpacity(0.3)
                        : Colors.transparent),
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                child: Text(
                  '${numbers[index]}',
                  style: TextStyle(
                    fontSize: isSelected ? 48 : 32,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? _getColorByIndex(_currentNumber)
                        : Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: Colors.white),
              elevation: 2,
            ),
            label: const Text(
              'Оценить',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              final authBloc = context.read<AuthBloc>();
              final reviewBloc = context.read<ReviewBloc>();
              final userId = authBloc.loginModel?.objectID;

              if (userId != null) {
                reviewBloc.add(ReviewEvent.addReviewMovie(
                  film: widget.film,
                  userId: userId,
                  review: _currentNumber.toDouble(),
                ));
              }
              if (context.mounted) {
                context.pop();
              }
            },
          ),
        ),
      ],
    );
  }

  Color _getColorByIndex(int index) {
    if (index == 5) {
      return Colors.grey;
    } else if (index < 5) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
