import 'package:bloc_app/src/data/dummy/dummy_brands.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';



class StoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewBrand() async {
    try {
      for (var brand in dummyBrand) {
        await _firestore
            .collection('brands')
            .add(brand.toJson()); //must be same in firebase
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<void> createProducts() async {
  //   try {
  //     for (var product in dummyProduct) {
  //       await _firestore
  //           .collection('products')
  //           .add(product.toJson()); //must be same in firebase
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<List<BrandModel>> fetchBrands() async {
    final List<BrandModel> brandList = [];
    final brandsSnapshot = await _firestore.collection('brands').get();

    try{
      for (var brand in brandsSnapshot.docs) {
        brandList.add(BrandModel.fromJson(brand.data()));
      }
    }catch(e){
      throw Exception(e);
    }

    return brandList;
  }

  Future<CategoryModel?> fetchSingleCategory(String categoryId)async{

    try {
      final data = await _firestore.collection("category").doc(categoryId).get();
      if(data.data() != null){
        final category = CategoryModel.fromJson(data.data()!);
        return category;
      }
      else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }

  }
}
