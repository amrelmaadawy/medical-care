import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/chat/data/repos/chat_repo.dart';
import 'package:medical_care/features/chat/view/dynamic_chat_view.dart';
import 'package:medical_care/features/chat/viewmodel/doctors_cubit.dart';
import 'package:medical_care/features/chat/viewmodel/conversations_cubit.dart';
import 'package:medical_care/features/chat/view/widgets/doctor_item.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DoctorsCubit(ChatRepo())..fetchDoctors()),
        BlocProvider(create: (_) => ConversationsCubit(ChatRepo())..fetchConversations()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'المحادثات',
              style: TextStyle(
                color: kTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: kPrimryColor,
              unselectedLabelColor: kSubTextColor,
              indicatorColor: kPrimryColor,
              tabs: [
                Tab(text: 'سجل الرسائل'),
                Tab(text: 'الأطباء المتاحين'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _ConversationsTab(),
              _DoctorsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationsTab extends StatelessWidget {
  const _ConversationsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationsCubit, ConversationsState>(
      builder: (context, state) {
        if (state is ConversationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ConversationsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is ConversationsSuccess) {
          final conversations = state.conversations;
          if (conversations.isEmpty) {
            return const Center(child: Text('لا توجد محادثات سابقة'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conv = conversations[index];
              
              String otherName = 'مستخدم';
              if (conv.lastMessage?.sender?.id == conv.userId) {
                otherName = conv.lastMessage?.sender?.name ?? '';
              } else if (conv.lastMessage?.receiver?.id == conv.userId) {
                otherName = conv.lastMessage?.receiver?.name ?? '';
              } else if (conv.lastMessage?.sender?.name.isNotEmpty == true) {
                 otherName = conv.lastMessage!.sender!.name;
              }

              String timeFormat = '';
              if (conv.lastMessage?.createdAt.isNotEmpty == true) {
                final parts = conv.lastMessage!.createdAt.split(' ');
                if (parts.length > 1) {
                   timeFormat = parts[1].substring(0, 5); // Assuming "2026-04-20 12:27:27" -> 12:27
                } else {
                   timeFormat = conv.lastMessage!.createdAt;
                }
              }

              return DoctorItem(
                name: otherName,
                specialty: conv.unreadCount > 0 ? 'غير مقروء: ${conv.unreadCount}' : 'لا يوجد رسائل غير مقروءة',
                status: conv.lastMessage?.message ?? 'لا يوجد رسائل',
                time: timeFormat,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DynamicChatView(
                        userId: conv.userId,
                        userName: otherName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _DoctorsTab extends StatelessWidget {
  const _DoctorsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: kgreyHighlightColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'البحث عن الأطباء',
                hintStyle: TextStyle(color: kSubTextColor, fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: kSubTextColor,
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
        ),
        Expanded(
          child: BlocBuilder<DoctorsCubit, DoctorsState>(
            builder: (context, state) {
              if (state is DoctorsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is DoctorsSuccess) {
                final doctors = state.doctors;
                if (doctors.isEmpty) {
                  return const Center(child: Text('لا يوجد أطباء متاحين حالياً'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return DoctorItem(
                      name: doctor.name,
                      specialty: doctor.specialization.isNotEmpty ? doctor.specialization : 'تخصص غير محدد',
                      status: 'بانتظار المراسلة...',
                      time: '',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DynamicChatView(
                              userId: doctor.id,
                              userName: doctor.name,
                              specialization: doctor.specialization,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
