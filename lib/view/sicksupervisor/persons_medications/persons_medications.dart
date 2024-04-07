import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubit.dart';
import '../../../core/cubit/states.dart';
import '../../../core/widgets/arrow_back.dart';
import '../../../core/widgets/card_person_sick_active.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/navigation.dart';
import '../sick_supervisor.dart';
import 'add_treatment_sick/add_treatment_sick.dart';

class PersonsMedications extends StatelessWidget {
  const PersonsMedications(
      {super.key,
      required this.name,
      required this.nameSupervisor,
      required this.image,
      required this.phone,
      required this.phoneSupervisor,
      required this.age,
      required this.location,
      required this.documentId});

  final String name;
  final String nameSupervisor;
  final String image;
  final String phone;
  final String phoneSupervisor;
  final String age;
  final String location;
  final int documentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase3(id: documentId),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                color: Theme.of(context).cardColor,
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                child: Image.file(
                                  File(image),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateAndFinish(context, const SickSupervisor());
                                    },
                                    child: ArrowBack(
                                      iconData: Icons.arrow_back_ios,
                                      colorIcon:
                                      Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                      nameSupervisor,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:18),
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
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomBottom(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        AddTreatmentSick(
                                            name: name,
                                          nameSupervisor: nameSupervisor,
                                            imagee: image,
                                            phone: phone,
                                          phoneSupervisor: phoneSupervisor,
                                            age: age,
                                            location: location,
                                            documentId: documentId,
                                        ));
                                  },
                                  borderRadius: BorderRadius.circular(14),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  text: 'اضافة دواء جديد',
                                  colorBottom: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.newTasks3.length,
                            itemBuilder: (context, index) {
                              int out=
                                  int.parse('${cubit.newTasks3[index]['numberDoses']}') ~/
                                      int.parse('${cubit.newTasks3[index]['dosageAmount']}');
                              String outStock= out.toString();
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: CardPersonSickActive(
                                  cubit: cubit,
                                  outStock: outStock,
                                  name: cubit.newTasks3[index]['name'],
                                  image: cubit.newTasks3[index]['image'],
                                  dosageAmount: cubit.newTasks3[index]['dosageAmount'],
                                  doseTime: cubit.newTasks3[index]['doseTime'],
                                  numberDoses: cubit.newTasks3[index]['numberDoses'],
                                  type: cubit.newTasks3[index]['type'],
                                  documentId: cubit.newTasks3[index]['id'],
                                  index: index+1,
                                ),
                              );
                            }),
                        const SizedBox(height: 26,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
