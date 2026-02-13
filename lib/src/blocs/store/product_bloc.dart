import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../data/models/models.dart';
import '../../data/repository/repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {

    on<FetchProducts>((event, emit) async {
      try {
        final products = await repository.fetchProduct();
        emit(ProductFetchSuccess(products));
      } catch (e) {
        emit(ProductFetchFailure('Failed to load Products'));
      }    });

    on<FetchSingleProduct>((event, emit) async {
      try {
        final product = await repository.fetchSingleProduct(event.productId);

        if(product != null){
          emit(ProductLoadSuccess(product));
        } else {
          emit( ProductFetchFailure('Unble to load product from server'));
        }

      } catch (e) {
        emit( ProductFetchFailure('Failed to load products'));
      }
    });
  }
}

