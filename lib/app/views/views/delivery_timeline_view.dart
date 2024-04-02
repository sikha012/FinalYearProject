import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/modules/order_status/controllers/order_status_controller.dart';
import 'package:happytails/app/utils/constants.dart';

enum DeliveryStage {
  shipped,
  onTheWay,
  delivered,
}

class DeliveryTimeline extends GetView<OrderStatusController> {
  final int orderId;

  DeliveryTimeline({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderStatusController>(
      builder: (controller) {
        var currentOrder = controller.userOrders.firstWhere(
            (order) => order.orderId == orderId,
            orElse: () => OrderDetailModel());

        DeliveryStage stage = _getStageForStatus(currentOrder.status);

        return Scaffold(
          appBar: AppBar(
            title: Text('Delivery Timeline for Order #$orderId'),
            backgroundColor: Constants.primaryColor,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TimelineTile(
                stage: DeliveryStage.shipped,
                isActive: stage.index >= DeliveryStage.shipped.index,
                description: 'Your order has been shipped.',
              ),
              Padding(
                padding: EdgeInsets.only(left: 35),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LineConnector(
                      isActive: stage.index > DeliveryStage.shipped.index),
                ),
              ),
              TimelineTile(
                stage: DeliveryStage.onTheWay,
                isActive: stage.index >= DeliveryStage.onTheWay.index,
                description: 'Your order is on the way.',
              ),
              Padding(
                padding: EdgeInsets.only(left: 35),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LineConnector(
                      isActive: stage.index > DeliveryStage.onTheWay.index),
                ),
              ),
              TimelineTile(
                stage: DeliveryStage.delivered,
                isActive: stage.index >= DeliveryStage.delivered.index,
                description: 'Your order has been delivered.',
              ),
            ],
          ),
        );
      },
    );
  }

  DeliveryStage _getStageForStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'shipped':
        return DeliveryStage.shipped;
      case 'on the way':
        return DeliveryStage.onTheWay;
      case 'delivered':
        return DeliveryStage.delivered;
      default:
        return DeliveryStage.shipped; // Default stage if status is unknown
    }
  }
}

class LineConnector extends StatelessWidget {
  final bool isActive;

  const LineConnector({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1, 150), // You can adjust the size for proper spacing
      painter: _LineConnectorPainter(isActive: isActive),
    );
  }
}

class _LineConnectorPainter extends CustomPainter {
  final bool isActive;

  _LineConnectorPainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isActive ? Constants.primaryColor : Colors.grey
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TimelineTile extends StatelessWidget {
  final DeliveryStage stage;
  final bool isActive;
  final String description;

  const TimelineTile({
    Key? key,
    required this.stage,
    required this.isActive,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.circle; // Default icon
    switch (stage) {
      case DeliveryStage.shipped:
        icon = Icons.local_shipping;
        break;
      case DeliveryStage.onTheWay:
        icon = Icons.delivery_dining;
        break;
      case DeliveryStage.delivered:
        icon = Icons.home;
        break;
    }

    Color color = isActive ? Constants.primaryColor : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getDescriptionForStage(stage),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 25,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDescriptionForStage(DeliveryStage stage) {
    switch (stage) {
      case DeliveryStage.shipped:
        return 'Shipped';
      case DeliveryStage.onTheWay:
        return 'On the Way';
      case DeliveryStage.delivered:
        return 'Delivered';
      default:
        return '';
    }
  }
}
