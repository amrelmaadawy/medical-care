import 'package:flutter/material.dart';
import 'package:medical_care/core/utils/app_colors.dart';

class DoctorAhmedChatView extends StatelessWidget {
  const DoctorAhmedChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: kgreyHighlightColor,
              child: Icon(Icons.person, color: kSubTextColor),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'د. أحمد العلي',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'طب الأطفال',
                        style: TextStyle(color: kSubTextColor, fontSize: 12),
                      ),
                      SizedBox(width: 6),
                      _OnlineDot(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined, color: kTextColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined, color: kTextColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: kTextColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: const [
                _IncomingMessage(
                  text: 'مرحبا، كيف يمكنني مساعدتك؟',
                  time: '٣:٣٠ م',
                ),
                SizedBox(height: 14),
                _OutgoingMessage(
                  text: 'مرحبا دكتور لدي استفسار حول حالة ابني',
                  time: '٣:٣٣ م',
                ),
                SizedBox(height: 14),
                _OutgoingMessage(
                  text: 'قمت برفع تقييم جديد وظهرت نسبة خطر عالية',
                  time: '٣:٣٣ م',
                ),
                SizedBox(height: 14),
                _IncomingMessage(
                  text: 'تمام، دعني أراجع التقييم',
                  time: '٣:٣٥ م',
                ),
                SizedBox(height: 14),
                _IncomingMessage(
                  text: 'سأقوم بمراجعة الحالة وأعود إليك قريباً',
                  time: '٣:٤٠ م',
                ),
              ],
            ),
          ),
          const _ChatInputBar(),
        ],
      ),
    );
  }
}

class _OnlineDot extends StatelessWidget {
  const _OnlineDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFF21C45D),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _IncomingMessage extends StatelessWidget {
  final String text;
  final String time;

  const _IncomingMessage({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kgreyHighlightColor),
            ),
            child: Text(
              text,
              style: const TextStyle(color: kTextColor, fontSize: 14),
            ),
          ),
          const SizedBox(height: 6),
          Text(time, style: const TextStyle(color: kgreyColor, fontSize: 11)),
        ],
      ),
    );
  }
}

class _OutgoingMessage extends StatelessWidget {
  final String text;
  final String time;

  const _OutgoingMessage({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: kPrimryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 6),
          Text(time, style: const TextStyle(color: kgreyColor, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: kPrimryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kgreyHighlightColor),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك هنا...',
                    hintStyle: TextStyle(color: kgreyColor, fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
