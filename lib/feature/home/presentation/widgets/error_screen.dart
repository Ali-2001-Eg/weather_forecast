import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_forecast/core/functions/text_styles.dart';

import '../../providers/weather_provider.dart';

class ErrorScreen extends StatefulWidget {
  final Function(WidgetRef ref) onRetry;
  const ErrorScreen({
    super.key,
    required this.onRetry,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ref.watch(searchNotifierProvider).isSearching
                  ? _searchBarBuilder(ref)
                  : Container(),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/json/error.json', height: 100),
                    15.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "City Not Found, Please type Again or check Internet connectivity.",
                        style: myStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return ElevatedButton(
                      onPressed: () => ref
                          .watch(searchNotifierProvider.notifier)
                          .startSearch(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Text(
                        'Try Again',
                        style: myStyle(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Form _searchBarBuilder(WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Container(
        // color: Colors.white,
        margin: const EdgeInsets.all(8.0)
            .add(const EdgeInsets.symmetric(horizontal: 5))
            .add(const EdgeInsets.only(top: 30)),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name';
                  }
                  return null;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: myStyle(fontSize: 16, color: Colors.grey),
                onChanged: (query) {
                  ref.watch(searchNotifierProvider.notifier).setQuery(query);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onRetry(ref);
                  ref.watch(searchNotifierProvider.notifier).stopSearch();
                }
                // searchNotifierState.removeQuery();
              },
            ),
          ],
        ),
      ),
    );
  }
}
