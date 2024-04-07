import 'dart:io';

import 'package:flutter/material.dart';
import 'package:omran/core/styles/colors.dart';
import 'package:omran/core/widgets/arrow_back.dart';
import '../cubit/cubit.dart';
import 'custom_button.dart';
import 'navigation.dart';

class PersonSick extends StatelessWidget {
  const PersonSick({
    super.key,
    required this.cubit,
    required this.name,
    required this.nameSupervisor,
    required this.image,
    required this.phone,
    required this.phoneSupervisor,
    required this.age,
    required this.location,
    required this.documentId,
    required this.index,
  });

  final AppCubit cubit;
  final String name;
  final String nameSupervisor;
  final String image;
  final String phone;
  final String phoneSupervisor;
  final String age;
  final String location;
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
                                ':اسم المريظ',
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
                                phone,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':رقم الهاتف',
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
                                age,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:18),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':العمر',
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
                                location,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':الموقع',
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
                                nameSupervisor,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':اسم الطبيب',
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
                                phoneSupervisor,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              const Text(
                                ':رقم الطبيب',
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
                                            cubit.deleteData2(id: documentId.toString());
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
                        borderRadius: BorderRadius.circular(14),
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
