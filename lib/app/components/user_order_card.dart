import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class UserOrderCard extends StatelessWidget {
  final OrderDetailModel orderDetail;

  const UserOrderCard({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: Text(
              orderDetail.productName ?? 'Product Name Unavailable',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('Quantity: ${orderDetail.quantity}',
                    style: TextStyle(color: Colors.black54)),
                Text('Total Amount: ${orderDetail.lineTotal}',
                    style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 10),
              ],
            ),
            trailing: orderDetail.productImage != null
                ? Image.network(
                    getImage(orderDetail.productImage!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AssetFile.cartProductImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status: ${orderDetail.status}',
                    style: TextStyle(color: Colors.black87)),
                _buildStatusIndicator(orderDetail.status ?? ''),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color getColor() {
      switch (status.toLowerCase()) {
        case 'delivered':
          return Constants.primaryColor;
        case 'pending':
          return Colors.orange;
        case 'cancelled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Icon(Icons.circle, color: getColor());
  }
}
