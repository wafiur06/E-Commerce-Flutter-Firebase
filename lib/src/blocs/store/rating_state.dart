part of 'rating_bloc.dart';

@immutable
sealed class RatingState extends Equatable {
  final TextEditingController? reviewController;
  final List<File> images;

  const RatingState({
    this.reviewController,
    this.images = const [],
  });

  @override
  List<Object?> get props => [reviewController, images];
}

final class RatingInitial extends RatingState {
  // Pass a new controller up to the parent
  RatingInitial() : super(reviewController: TextEditingController(), images: []);
}

final class RatingLoading extends RatingState {
  const RatingLoading({super.reviewController, super.images});
}

final class RatingSubmitSuccess extends RatingState {}

final class RatingSubmitfailed extends RatingState {
  final String message;

  const RatingSubmitfailed(this.message);

  @override
  List<Object> get props => [message];
}

final class RatingPointChanged extends RatingState {
  final double ratingPoint;

  const RatingPointChanged({
    required this.ratingPoint,
    required super.reviewController,
    required super.images,
  });

  @override
  List<Object?> get props => [ratingPoint, reviewController, images];
}

final class ReviewFetchSuccess extends RatingState {
  final List<ReviewModel> reviews;

  ReviewFetchSuccess(this.reviews);

  @override
  List<Object> get props => [reviews];
}

final class ReviewFetchFailed extends RatingState {
  final String message;

  const ReviewFetchFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class ReviewPhotoAdded extends RatingState {
  final List<File> images;

  const ReviewPhotoAdded(this.images);

  @override
  List<Object> get props => [images];
}

final class ReviewPhotoRemoved extends RatingState {
  final List<File> images;

  const ReviewPhotoRemoved(this.images);

  @override
  List<Object> get props => [images];
}
