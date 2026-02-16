import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  double rating = 0.0;

  RatingBloc() : super(RatingInitial()) {
    on<UpdateRatingPoint>((event, emit) {
      rating = event.rating;
    });

    on<SubmitReview>((event, emit) {
      print('Review: ${event.review} Rating: $rating');
    });
  }
}
