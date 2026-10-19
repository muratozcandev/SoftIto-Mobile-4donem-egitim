import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/diary_entry.dart';

/// [DiaryEditor], günlük başlığı ve içeriğinin yazıldığı, kelime sayımı ve
/// yerel animasyonlu kaydetme butonunu barındıran editör bileşenidir.
class DiaryEditor extends StatefulWidget {
  const DiaryEditor({
    super.key,
    required this.entry,
    required this.selectedDate,
    required this.selectedMood,
    required this.onSave,
  });

  final DiaryEntry? entry;
  final DateTime selectedDate;
  final String selectedMood;
  final void Function({
    required String title,
    required String content,
    required String mood,
  }) onSave;

  @override
  State<DiaryEditor> createState() => _DiaryEditorState();
}

class _DiaryEditorState extends State<DiaryEditor> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  bool _isSavedRecently = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? '');
    _contentController = TextEditingController(text: widget.entry?.content ?? '');
  }

  @override
  void didUpdateWidget(covariant DiaryEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate ||
        oldWidget.entry?.id != widget.entry?.id) {
      _titleController.text = widget.entry?.title ?? '';
      _contentController.text = widget.entry?.content ?? '';
      _isSavedRecently = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(
      title: _titleController.text,
      content: _contentController.text,
      mood: widget.selectedMood,
    );
    setState(() {
      _isSavedRecently = true;
    });
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSavedRecently = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _TitleInputField(controller: _titleController),
            const SizedBox(height: 12),
            _ContentInputField(controller: _contentController),
            const SizedBox(height: 12),
            _EditorActionBar(
              controller: _contentController,
              isSavedRecently: _isSavedRecently,
              onSave: _handleSave,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleInputField extends StatelessWidget {
  const _TitleInputField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      decoration: const InputDecoration(
        hintText: 'Günün Başlığı...',
        prefixIcon: Icon(Icons.edit_note_rounded, color: AppColors.primary),
      ),
    );
  }
}

class _ContentInputField extends StatelessWidget {
  const _ContentInputField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      minLines: 8,
      style: const TextStyle(
        fontSize: 15,
        height: 1.6,
        color: AppColors.textPrimary,
      ),
      decoration: const InputDecoration(
        hintText: 'Sevgili Günlük, bugün neler yaşandı?...',
        alignLabelWithHint: true,
      ),
    );
  }
}

class _EditorActionBar extends StatelessWidget {
  const _EditorActionBar({
    required this.controller,
    required this.isSavedRecently,
    required this.onSave,
  });

  final TextEditingController controller;
  final bool isSavedRecently;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        final int charCount = value.text.length;
        final int wordCount = value.text.trim().isEmpty
            ? 0
            : value.text.trim().split(RegExp(r'\s+')).length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$wordCount kelime • $charCount karakter',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            _SaveButton(isSaved: isSavedRecently, onTap: onSave),
          ],
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.isSaved, required this.onTap});
  final bool isSaved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        isSaved ? Icons.check_circle_rounded : Icons.bookmark_added_rounded,
        size: 18,
      ),
      label: Text(isSaved ? 'Kaydedildi' : 'Kaydet'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSaved ? AppColors.success : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
