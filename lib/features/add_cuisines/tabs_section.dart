import 'package:flutter/material.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_dropdown.dart';
import '/core/widgets/header_cell.dart';
import '/core/widgets/label_text.dart';
import '../../../../../config/constants/colors.dart';

class CuisinesTabsSection extends StatelessWidget {
  const CuisinesTabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const workingColor = Color(0xFF27AE60);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppColors.darkOrange,
          indicatorColor: Colors.deepOrange,
          splashFactory: NoSplash.splashFactory,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Cuisines"),
            Tab(text: "Types"),
            Tab(text: "Attributes"),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 30,
                      bottom: 5,
                      left: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.tileHeader,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Row(
                      children: const [
                        HeaderCell('Name'),
                        Spacer(),
                        HeaderCell('Created On'),
                        Spacer(),
                        HeaderCell('Actions'),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 10,
                          bottom: 5,
                          left: 10,
                        ),
                        color: AppColors.background,
                        child: Row(
                          children: [
                            Center(
                              child: Text(
                                "Restaurant",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Text(
                                "2025-05-04",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 70,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: workingColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Open Time',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  LabelText(text: "Select Vanue Category"),
                  SizedBox(height: 10),
                  CustomDropdown(
                      items: [], onChanged: (value) {}, hintText: "Select"),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                    },
                    text: 'Submit',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 30,
                      bottom: 5,
                      left: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.tileHeader,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Row(
                      children: const [
                        HeaderCell('Name'),
                        Spacer(),
                        HeaderCell('Created On'),
                        Spacer(),
                        HeaderCell('Actions'),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 10,
                          bottom: 5,
                          left: 10,
                        ),
                        color: AppColors.background,
                        child: Row(
                          children: [
                            Center(
                              child: Text(
                                "Restaurant",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Text(
                                "2025-05-04",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 70,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: workingColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Open Time',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  LabelText(text: "Select Vanue Category"),
                  SizedBox(height: 10),
                  CustomDropdown(
                      items: [], onChanged: (value) {}, hintText: "Select"),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                    },
                    text: 'Submit',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 30,
                      bottom: 5,
                      left: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.tileHeader,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Row(
                      children: const [
                        HeaderCell('Name'),
                        Spacer(),
                        HeaderCell('Created On'),
                        Spacer(),
                        HeaderCell('Actions'),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 10,
                          bottom: 5,
                          left: 10,
                        ),
                        color: AppColors.background,
                        child: Row(
                          children: [
                            Center(
                              child: Text(
                                "Restaurant",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Text(
                                "2025-05-04",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 70,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: workingColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Open Time',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  LabelText(text: "Select Vanue Category"),
                  SizedBox(height: 10),
                  CustomDropdown(
                      items: [], onChanged: (value) {}, hintText: "Select"),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {},
                    text: 'Submit',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
