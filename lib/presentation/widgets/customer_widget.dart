import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../sqflite_db/customer_db/model.dart';

class CustomerWidget extends StatefulWidget {
  final Customer customer;
  final bool customerScreen;
  const CustomerWidget({super.key, required this.customer, required this.customerScreen});

  @override
  State<CustomerWidget> createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.customer.profilePic,
                width: 80.w,
                height: 70.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 1,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.black12
                        ], // Replace with your desired gradient colors
                        begin: Alignment.center,
                        end: Alignment.topCenter,
                      )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 1,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.black12
                        ], // Replace with your desired gradient colors
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 170.w,
              // height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.customer.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ID : ${widget.customer.id}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "${widget.customer.street}, ${widget.customer.city}, ${widget.customer.country}",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    "Due Amount : ",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        final Uri smsLaunchUri = Uri(scheme: 'tel', path: widget.customer.mobileNum);
                        await launchUrl(smsLaunchUri, mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromRGBO(15, 31, 129, 1.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.call,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse("whatsapp://send?phone=${widget.customer.mobileNum}"));
                      },
                      child: Image.asset(
                          widget.customerScreen ? "assets/images/whatsapp.png" : "assets/images/whatsapp_blue.png",
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
