import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class SelectDeliveryAppPage extends StatelessWidget {
  const SelectDeliveryAppPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Method', style: kAppBarTitleStyle),
        centerTitle: true,
      ),
      body: ListView(
          children: deliveryApps.keys.listMap((c) => DeliveryAppTile(c))),
    );
  }
}

class DeliveryAppTile extends StatelessWidget {
  const DeliveryAppTile(this.deliveryApp);
  final $pb.Review_DeliveryApp deliveryApp;

  @override
  Widget build(BuildContext context) => ListTile(
      onTap: () => Navigator.pop(context, deliveryApp),
      title: Container(
          padding: const EdgeInsets.all(6),
          height:
              MediaQuery.of(context).size.height / deliveryApps.length * .66,
          alignment: Alignment.center,
          child: deliveryApp != $pb.Review_DeliveryApp.UNDEFINED
              ? Image.asset(deliveryApps[deliveryApp])
              : const AutoSizeText("OTHER",
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 36),
                  minFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1)));
}

const deliveryApps = {
  $pb.Review_DeliveryApp.postmates: "assets/images/postmates.png",
  $pb.Review_DeliveryApp.uber_eats: "assets/images/uber_eats.png",
  $pb.Review_DeliveryApp.door_dash: "assets/images/door_dash.png",
  $pb.Review_DeliveryApp.grub_hub: "assets/images/grubhub.png",
  $pb.Review_DeliveryApp.eat_24: "assets/images/eat_24.png",
  $pb.Review_DeliveryApp.seamless: "assets/images/seamless.png",
  $pb.Review_DeliveryApp.UNDEFINED: "",
};
