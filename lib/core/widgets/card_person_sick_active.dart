import 'dart:io';

import 'package:flutter/material.dart';
import 'package:omran/core/styles/colors.dart';
import '../cubit/cubit.dart';
import 'custom_button.dart';
import 'navigation.dart';

class CardPersonSickActive extends StatelessWidget {
  const CardPersonSickActive({
    super.key,
    required this.cubit,
    required this.outStock,
    required this.name,
    required this.type,
    required this.image,
    required this.dosageAmount,
    required this.doseTime,
    required this.numberDoses,
    required this.documentId,
    required this.index,
  });

  final AppCubit cubit;
  final String outStock;
  final String name;
  final String type;
  final String image;
  final String dosageAmount;
  final String doseTime;
  final String numberDoses;
  final int documentId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).backgroundColor,
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':اسم الدواء',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                type,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':نوع الجرعة',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dosageAmount,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':مقدار الجرعة(في اليوم)',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                doseTime,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:18),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':موعد الجرعة',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                numberDoses,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':عدد الجرع(الكلي)',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                      ),
                      child: Image.file(
                        File(image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('  يوم على نفاذ كمية الدواء '),
                  Text(outStock),
                  const Text(' متبقي '),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBottom(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                Theme.of(context).cardColor,
                                content: SizedBox(
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              'هل انت متأكد من عملية الحذف',
                                              textAlign: TextAlign.end,
                                              style:
                                              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomBottom(
                                          onTap: () {
                                            navigateBack(context);
                                          },
                                          text: 'الغاء',
                                          colorText: Colors.white,
                                          colorBottom: primaryColor,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: CustomBottom(
                                          onTap: () {
                                            navigateBack(context);
                                            cubit.deleteData3(id: documentId);
                                          },
                                          text: 'تأكيد',
                                          colorText: Theme.of(context).scaffoldBackgroundColor,
                                          colorBottom: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'حذف',
                        colorBottom: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
