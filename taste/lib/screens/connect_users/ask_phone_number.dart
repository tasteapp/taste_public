import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/taste_brand.dart';
import 'package:taste/taste_backend_client/backend.dart';

class AskPhoneNumberWidget extends StatefulWidget {
  const AskPhoneNumberWidget({Key key}) : super(key: key);

  @override
  _AskPhoneNumberWidgetState createState() => _AskPhoneNumberWidgetState();
}

// Needs to be stateful for pages w/ dotted indicator.
class _AskPhoneNumberWidgetState extends State<AskPhoneNumberWidget> {
  final _formKey = GlobalKey<FormState>();

  CountryCode countryCode = CountryCode(dialCode: "+1");
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TasteBrand(showText: false, size: 35),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
          child: Center(
            child: AutoSizeText(
              'Help Your Friends Find You on Taste!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.grey[700]),
              maxLines: 1,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _countryCodeSelector(),
                      _enterPhoneNumberWidget(context)
                    ]))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Center(
            child: AutoSizeText(
              'Enter your phone number to help your friends find you '
              'from their contacts can follow you. We do not contact '
              'you with this number and NEVER share it with anyone!',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              maxLines: 3,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Container(
              height: 90,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 5),
                  Center(child: _finishButton(context)),
                  const SizedBox(height: 10),
                ],
              ),
            ))
      ]),
    );
  }

  Widget _countryCodeSelector() {
    return CountryCodePicker(
      onChanged: (selection) => setState(() => countryCode = selection),
      initialSelection: 'US',
    );
  }

  Widget _enterPhoneNumberWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              autocorrect: false,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[400].withOpacity(0.6),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2), width: 1.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2), width: 1.0)),
              ),
              validator: (value) {
                if (!isValidPhoneNumber(value)) {
                  return 'Phone # must be 7-12 digits';
                }
                return null;
              },
              onChanged: (value) {
                setState(() => phoneNumber = value);
              },
              onFieldSubmitted: (value) {
                if (_formKey.currentState.validate()) {
                  setState(() => phoneNumber = value);
                }
              },
            ),
          ),
        ));
  }

  Widget _finishButton(BuildContext context) {
    return IconButton(
      iconSize: 30,
      color: Colors.grey[700],
      icon: const Icon(Icons.check),
      onPressed: () async {
        if (!_formKey.currentState.validate()) {
          return;
        }
        String fullPhoneNumber = countryCode.toString() + phoneNumber;
        await updateVanity({'phone_number': fullPhoneNumber});
        Navigator.pop(context);
      },
    );
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length >= 7 && phoneNumber.length <= 12;
  }
}
