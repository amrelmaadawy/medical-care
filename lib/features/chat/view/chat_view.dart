import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/chat/view/doctor_Ahmed_chat_view.dart';
import 'package:medical_care/features/chat/view/doctor_khaled_chat_view.dart';
import 'package:medical_care/features/chat/view/doctor_sara_chat_view.dart';
import 'package:medical_care/features/chat/view/widgets/doctor_item.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            'المحادثات',
            style: TextStyle(
              color: kTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: kgreyHighlightColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'البحث عن الأطباء',
                  hintStyle: TextStyle(
                    color: kgreyColor,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: kgreyColor,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Doctors List
            Expanded(
              child: ListView(
                children: [
                  DoctorItem(
                    name: 'د.احمد العلي',
                    specialty: 'طبيب اطفال',
                    status: 'سأقوم بمراجعه الحاله واعود اليك قريبا',
                    time: 'منذ 5 دقائق',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DoctorAhmedChatView(),
                        ),
                      );
                    },
                  ),
                  DoctorItem(
                    name: 'د. ساره محمد ',
                    specialty: 'الامراض الجلديه ',
                    status: 'ينصح بمراجعه العياده للفحص',
                    time: 'منذ ساعة',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(_) => const DoctorSaraChatView(), ));
                    },
                  ),
                  DoctorItem(
                    name: 'د. خالد حسن ',
                    specialty: 'طبيب اطفال',
                    status: 'شكراً لك على الاستشارة',
                    time: 'منذ 3 ساعات',
                     onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(_) => const DoctorKhaledChatView(), ));
                    },
                  ),
                  
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

