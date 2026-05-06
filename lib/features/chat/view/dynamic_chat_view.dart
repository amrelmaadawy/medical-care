import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_care/core/utils/app_colors.dart';
import 'package:medical_care/features/chat/data/repos/chat_repo.dart';
import 'package:medical_care/features/chat/viewmodel/chat_messages_cubit.dart';

class DynamicChatView extends StatefulWidget {
  final int userId;
  final String userName;
  final String? specialization;

  const DynamicChatView({
    super.key,
    required this.userId,
    required this.userName,
    this.specialization,
  });

  @override
  State<DynamicChatView> createState() => _DynamicChatViewState();
}

class _DynamicChatViewState extends State<DynamicChatView> {
  final TextEditingController _msgController = TextEditingController();
  Timer? _typingTimer;

  @override
  void dispose() {
    _msgController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onTyping(BuildContext ctx, String text) {
    if (text.trim().isEmpty) return;
    if (_typingTimer?.isActive ?? false) return; // Throttle requests

    ctx.read<ChatMessagesCubit>().sendTypingIndicator(widget.userId);
    _typingTimer = Timer(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatMessagesCubit(ChatRepo())..fetchMessages(widget.userId),
      child: Builder(
        builder: (context) {
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
                  children: [
                    Text(
                      widget.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          widget.specialization ?? 'عبر الإنترنت',
                          style: const TextStyle(color: kSubTextColor, fontSize: 12),
                        ),
                        const SizedBox(width: 6),
                        const _OnlineDot(),
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
              child: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
                builder: (context, state) {
                  if (state is ChatMessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatMessagesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is ChatMessagesSuccess) {
                    final messages = state.messages;
                    if (messages.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا يوجد رسائل، كن أول من يرسل!',
                          style: TextStyle(color: kSubTextColor),
                        ),
                      );
                    }

                    final reversedMessages = messages.reversed.toList();

                    return ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: reversedMessages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final msg = reversedMessages[index];
                        // If sender ID is the peer ID then it's incoming
                        final isIncoming = msg.sender?.id == widget.userId;

                        String timeFormat = msg.createdAt;
                        if (timeFormat.contains(' ')) {
                          final parts = timeFormat.split(' ');
                          if (parts.length > 1 && parts[1].length >= 5) {
                            timeFormat = parts[1].substring(0, 5); // "HH:MM"
                          }
                        }

                        if (isIncoming) {
                          return _IncomingMessage(text: msg.message, time: timeFormat);
                        } else {
                          return _OutgoingMessage(text: msg.message, time: timeFormat, isRead: msg.isRead);
                        }
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            _ChatInputBar(
              controller: _msgController,
              onChanged: (text) => _onTyping(context, text),
              onSend: () {
                final text = _msgController.text.trim();
                if (text.isNotEmpty) {
                  context.read<ChatMessagesCubit>().sendMessage(
                    widget.userId,
                    text,
                    onError: (err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(err)),
                      );
                    },
                  );
                  _msgController.clear();
                }
              },
            ),
          ],
        ),
      );
    }),
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
  final bool isRead;

  const _OutgoingMessage({
    required this.text,
    required this.time,
    required this.isRead,
  });

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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: const TextStyle(color: kgreyColor, fontSize: 11)),
              const SizedBox(width: 4),
              Icon(
                isRead ? Icons.done_all : Icons.check,
                size: 14,
                color: isRead ? Colors.blue : kgreyColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<String>? onChanged;

  const _ChatInputBar({
    required this.controller,
    required this.onSend,
    this.onChanged,
  });

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
                onPressed: onSend,
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
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: const InputDecoration(
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
