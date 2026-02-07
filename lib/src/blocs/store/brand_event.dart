part of 'brand_bloc.dart';

@immutable
sealed class BrandEvent {}

class FetchBrands extends BrandEvent {}
