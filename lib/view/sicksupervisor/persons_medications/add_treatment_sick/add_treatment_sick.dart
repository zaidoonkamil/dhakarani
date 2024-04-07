import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omran/view/sicksupervisor/persons_medications/persons_medications.dart';

import '../../../../core/cubit/cubit.dart';
import '../../../../core/cubit/states.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/arrow_back.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_form_field.dart';
import '../../../../core/widgets/navigation.dart';
import '../../../../core/widgets/snack_bar.dart';

class AddTreatmentSick extends StatelessWidget {
  const AddTreatmentSick(
      {super.key,
      required this.name,
      required this.nameSupervisor,
      required this.imagee,
      required this.phone,
      required this.phoneSupervisor,
      required this.age,
      required this.location,
      required this.documentId});

  final String name;
  final String nameSupervisor;
  final String imagee;
  final String phone;
  final String phoneSupervisor;
  final String age;
  final String location;
  final int documentId;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController dosageAmountController = TextEditingController();
  static TextEditingController doseTimeController = TextEditingController();
  static TextEditingController numberDosesController = TextEditingController();
  static TextEditingController typeController = TextEditingController();
  static String image = '';
  static List<String> type =['حقنة','شراب','حبة','قطرات'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..createDatabase3(id: documentId),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            nameController.text = '';
            dosageAmountController.text = '';
            doseTimeController.text = '';
            typeController.text = '';
            numberDosesController.text = '';
            image = '';
            AppCubit.get(context).createDatabase3(id: documentId);
            navigateAndFinish(context, PersonsMedications(
                name: name, image: imagee, phone: phone, nameSupervisor: nameSupervisor, phoneSupervisor: phoneSupervisor, age: age, location: location, documentId: documentId));
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 240,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(220),
                            bottomLeft: Radius.circular(220),
                          ),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 32),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'تسجيل دواء جديد',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigateBack(context);
                                },
                                child: ArrowBack(
                                  iconData: Icons.arrow_back_ios,
                                  colorIcon:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              final imagee = await picker.pickImage(
                                  source: ImageSource.gallery);
                              image = imagee!.path;
                              cubit.emitt();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipOval(
                                  child: image.isNotEmpty
                                      ? Image.file(
                                          File(image),
                                          width: 140.0,
                                          height: 140.0,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.add_photo_alternate,
                                          size: 140,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19.0, vertical: 21),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'الاسم   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        controller: nameController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل الاسم';
                                          }
                                        },
                                        hintText: 'بنسلين',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'مقدار الجرع(في اليوم)   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textInputType: TextInputType.phone,
                                        controller: dosageAmountController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل مقدار الجرعة';
                                          }
                                        },
                                        hintText: '2',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'نوع الجرعة   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20.0),
                                              ),
                                            ),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'نوع الجرعة',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: primaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Expanded(
                                                      child: ListView.separated(
                                                        physics:
                                                        const BouncingScrollPhysics(),
                                                        itemCount:type.length,
                                                        separatorBuilder: (BuildContext context, int index) =>
                                                        const Divider(
                                                          height: 1,
                                                        ),
                                                        itemBuilder: (context, index) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.stretch,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  typeController.text = type[index];
                                                                  navigateBack(context);
                                                                },
                                                                child: Center(
                                                                    child: Text(
                                                                      type[index],
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                     ),
                                                                    )),
                                                              ),
                                                              const SizedBox(height: 10),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        textStyleHint: Theme.of(context).textTheme.headline3,
                                        textInputType: TextInputType.none,
                                        controller: typeController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل نوع الجرعة';
                                          }
                                        },
                                        hintText: 'شراب',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'موعد الجرعة   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textStyleHint: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textInputType: TextInputType.text,
                                              controller: doseTimeController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل موعد الجرعة';
                                                }
                                              },
                                              hintText: 'قبل الوجبة',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'عدد الجرع(الكلي)   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textStyleHint: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textInputType:
                                                  TextInputType.phone,
                                              controller: numberDosesController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل عدد الجرع';
                                                }
                                              },
                                              hintText: '30 ',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 42,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomBottom(
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (image.isNotEmpty) {
                                              cubit.insertToDatabase3(
                                                id: documentId,
                                                context: context,
                                                name: nameController.text.trim(),
                                                dosageAmount: dosageAmountController.text,
                                                doseTime: doseTimeController.text,
                                                numberDoses: numberDosesController.text,
                                                type: typeController.text,
                                                imagePath: image,
                                              );
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  'قم بأختيار صورة',
                                                  Colors.red);
                                            }
                                          }
                                        },
                                        horizontal: 38,
                                        borderRadius: BorderRadius.circular(14),
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: 'حفظ الدواء',
                                        colorBottom: Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .backgroundColor!,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
