part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductFetchSuccess extends ProductState {
  final List<ProductModel> products;

  ProductFetchSuccess(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductFetchFailure extends ProductState {
  final String message;

  ProductFetchFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ProductLoadSuccess extends ProductState {
  final ProductModel product;

  ProductLoadSuccess(this.product);

  @override
  List<Object> get props => [product];
}



