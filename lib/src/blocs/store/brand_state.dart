part of 'brand_bloc.dart';

@immutable
sealed class BrandState {}

final class BrandInitial extends BrandState {}

final class BrandFetchSuccess extends BrandState {
  final List<BrandModel> brands;

  BrandFetchSuccess(this.brands);

  @override
  List<Object> get props => [brands];
}

final class BrandFetchFailure extends BrandState {
  final String message;

  BrandFetchFailure(this.message);

  @override
  List<Object> get props => [message];
}
