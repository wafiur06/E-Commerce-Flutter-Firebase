import 'package:bloc_app/src/data/models/product_model.dart';

final List<ProductModel> dummyProduct = [
  ProductModel(
    productName: "Winter T-Shirt",
    productPrice: 200.0,
    imageGallery: [
      ImageGallery(
        title: "Image-1",
        url:
            "https://smartdeal.com.bd/public/uploads/all/yslqy5Si2xHTJnIEkCXdKLxUlic4lCzI1yKX7tqJ.webp",
      ),
      ImageGallery(
        title: "Image-2",
        url:
            "https://smartdeal.com.bd/public/uploads/all/zqezYBPqPvyVR7e73STiJBANhemxo6rkmbljBdyF.webp",
      ),
    ],
    varient: [
      Varient(
        category: "Size",
        items: [
          Item(title: "S", description: ""),
          Item(title: "M", description: ""),
          Item(title: "XL", description: ""),
        ],
      ),
    ],
    productDetails: """Full Sleeve Cotton T-Shirt for Winter Features
    ·        Fabric: Cotton

  ·        GSM: 280

  ·        Garment Quality: High-quality fabric and construction

  ·        Available Sizes: M, L, XL

  ·        M: Length 28", Chest 38"

  ·        L: Length 29", Chest 40""",

    brand: "",
  ),
];
