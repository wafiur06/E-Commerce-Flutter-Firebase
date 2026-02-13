import 'package:bloc/bloc.dart';
import 'package:bloc_app/src/data/models/brand_model.dart';
import 'package:bloc_app/src/data/repository/store_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'brand_event.dart';

part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  StoreRepository repository;

  BrandBloc(this.repository) : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      try {
        final brands = await repository.fetchBrands();
        emit(BrandFetchSuccess(brands));
      } catch (e) {
        emit(BrandFetchFailure('Failed to load brands'));
      }
    });
  }
}
