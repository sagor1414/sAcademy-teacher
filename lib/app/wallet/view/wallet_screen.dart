import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgefly_academy_admin/app/Transactions/view/transaction_view.dart';
import 'package:edgefly_academy_admin/app/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../general/consts/firebase_consts.dart';
import '../../profile/services/firebase_services.dart';
import '../../withdraw/view/withdraw_screen.dart';
import '../controller/wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    WalletController controller = Get.put(WalletController());
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
          title: "Wallet balance".text.white.make(),
          backgroundColor: const Color(0xff3777c8)),
      body: StreamBuilder(
          stream: FirestoreServicesProfile.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return Stack(
                children: [
                  Container(
                    color: const Color(0xfff0f5fa),
                  ),
                  Container(
                    height: context.screenHeight * .4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff3777c8),
                          Color.fromARGB(255, 89, 215, 247),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Available balance".text.white.size(20).make(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "\$".text.white.size(70).make(),
                              10.widthBox,
                              "${data['account']}"
                                  .numCurrency
                                  .text
                                  .white
                                  .size(70)
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            height: context.screenHeight * .15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: context.screenWidth * .1,
                    top: 200,
                    child: Container(
                      height: context.screenHeight * .35,
                      width: context.screenWidth * .79,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 199, 199, 199),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: context.screenHeight * .07,
                            width: context.screenWidth * .55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff3777c8)),
                              onPressed: () {
                                Get.to(() => WithdrawScreen(
                                      data: data,
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.outbox,
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                  const Text(
                                    "withdraw",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.screenHeight * .03,
                          ),
                          SizedBox(
                            height: context.screenHeight * .07,
                            width: context.screenWidth * .55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff3777c8)),
                              onPressed: () {
                                Get.to(() => const TransactionScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.notes_rounded,
                                    color: Colors.white,
                                  ),
                                  5.widthBox,
                                  const Text(
                                    "Transactions",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
