import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/models/models.dart';
import '../../data/repository/repository.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  double rating = 0.0;
  final ProductRepository repository;


  RatingBloc(this.repository) : super(RatingInitial()) {
    on<UpdateRatingPoint>((event, emit) {
      rating = event.rating;
    });

    on<RequestAddReview> ((event, emit) {
      emit(RatingInitial());
    });

    on<SubmitReview>((event, emit) async {
      emit(RatingLoading());
      final currentUser = FirebaseAuth.instance.currentUser;
      
      final review = ReviewModel(
        userId: currentUser?.uid,
        userName: currentUser?.displayName,
        userProfilePic: currentUser?.photoURL,
        createdAt: Timestamp.now(),
        productId: event.productId,
        review: event.review,
        rating: rating,
      );
      try{
        final response = await repository.submitReviewRating(review);
        if(response != null){
          emit(RatingSubmitSuccess());
        }else{
          emit(const RatingSubmitfailed('Something went wrong'));
        }
      }catch(e){
        emit(const RatingSubmitfailed("Internal Sarver Error"));
      }
    
    });

    on<FetchProductReview>((event, emit) async {
      try{
        final reviews = await repository.fetchProductReview(event.productId);
        emit(ReviewFetchSuccess(reviews));
      }catch(e){
        emit(const ReviewFetchFailed('Failed to Load Reviews!'));
      }
    });


  }
}
