part of 'rating_bloc.dart';

@immutable
sealed class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {
  final TextEditingController reviewController = TextEditingController();
}

final class RatingLoading extends RatingState {}

final class RatingSubmitSuccess extends RatingState {}

final class RatingSubmitfailed extends RatingState {
  final String message;
  const RatingSubmitfailed(this.message);
  @override
  List<Object> get props => [message];
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
