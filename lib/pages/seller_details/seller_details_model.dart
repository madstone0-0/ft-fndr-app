import 'package:ft_fndr_app/pages/seller_details/seller_details_widget.dart' show SellerDetailsWidget, SellerData;

import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'seller_details_widget.dart' show SellerDetailsWidget;
import 'package:flutter/material.dart';

class SellerContactAction {
  final IconData icon;
  final String label;
  final String? url;

  const SellerContactAction({required this.icon, required this.label, this.url});
}

class SellerProductData {
  final String imgDesc;
  final String name;
  final String price;

  const SellerProductData({required this.imgDesc, required this.name, required this.price});
}

class SellerData {
  final String coverImageUrl;
  final String avatarInitials;
  final String name;
  final String location;
  final bool isVerified;
  final String about;
  final String storeAddress;
  final LatLng storeLatLng;
  final List<SellerContactAction> contactActions;
  final List<SellerProductData> featuredProducts;

  const SellerData({
    required this.coverImageUrl,
    required this.avatarInitials,
    required this.name,
    required this.location,
    required this.isVerified,
    required this.about,
    required this.storeAddress,
    required this.storeLatLng,
    required this.contactActions,
    required this.featuredProducts,
  });
}

enum SellerDetailsStatus { initial, loading, success, error }

class SellerDetailsModel extends FlutterFlowModel<SellerDetailsWidget> {
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  List<ProductCardModel> productCardModels = [];

  // Observable state for seller id
  final sellerId = ValueNotifier<String>('');

  SellerDetailsStatus status = SellerDetailsStatus.initial;
  SellerData? seller;
  String? errorMessage;

  Future<void> loadSeller() async {
    status = SellerDetailsStatus.loading;

    try {
      seller = const SellerData(
        coverImageUrl: '...',
        avatarInitials: '1N',
        name: '1NRI Ghana',
        location: 'East Legon, Accra',
        isVerified: true,
        about: '...',
        storeAddress: 'Plot 24, Boundary Road, East Legon',
        storeLatLng: LatLng(5.6333, -0.1667),
        contactActions: [
          SellerContactAction(icon: Icons.call_rounded, label: 'Call', url: 'tel:+233...'),
          SellerContactAction(icon: Icons.chat_rounded, label: 'WhatsApp', url: 'https://wa.me/...'),
          SellerContactAction(icon: Icons.language_rounded, label: 'Website', url: 'https://...'),
          SellerContactAction(icon: Icons.photo_camera_rounded, label: 'Instagram', url: 'https://instagram.com/...'),
        ],
        featuredProducts: [
          SellerProductData(
            imgDesc: '...',
            name: 'Product 1',
            price: 'GHS 100',
          ),
          SellerProductData(
            imgDesc: '...',
            name: 'Product 2',
            price: 'GHS 150',
          ),
        ],
      );
      status = SellerDetailsStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = SellerDetailsStatus.error;
    }
  }

  @override
  void initState(BuildContext context) {}

  void initProductModels(BuildContext context, int count) {
    for (final m in productCardModels) {
      m.dispose();
    }
    productCardModels = List.generate(
      count,
      (_) => createModel(context, () => ProductCardModel()),
    );
  }

  @override
  void dispose() {
    for (final model in productCardModels) {
      model.dispose();
    }
  }
}
