import 'package:flutter/material.dart';
import '../../controllers/app_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../models/habit_goal.dart';

class AddHabitView extends StatefulWidget {
  final String? initialHabitId;

  const AddHabitView({
    super.key,
    this.initialHabitId,
  });

  @override
  State<AddHabitView> createState() => _AddHabitViewState();
}

class _AddHabitViewState extends State<AddHabitView> {
  late String _selectedHabitId;
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final controller = AppController.instance;
    _selectedHabitId = widget.initialHabitId ?? controller.habits.first.id;
    _loadHabitData(_selectedHabitId);
  }

  void _loadHabitData(String id) {
    final habit = AppController.instance.habits.firstWhere((h) => h.id == id);
    _targetController.text = _formatValue(habit.targetValue);
    _currentController.text = _formatValue(habit.currentValue);
  }

  String _formatValue(double val) {
    if (val == val.roundToDouble()) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(1);
  }

  @override
  void dispose() {
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }

  void _saveHabit() {
    if (!_formKey.currentState!.validate()) return;

    final targetVal = double.tryParse(_targetController.text.replaceAll(',', '.'));
    final currentVal = double.tryParse(_currentController.text.replaceAll(',', '.'));

    if (targetVal == null || targetVal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hedeflenen değer 0\'dan büyük olmalıdır.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (currentVal == null || currentVal < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gerçekleşen değer negatif olamaz.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final success = AppController.instance.updateHabit(
      id: _selectedHabitId,
      newTarget: targetVal,
      newCurrent: currentVal,
    );

    if (success) {
      final habit = AppController.instance.habits.firstWhere((h) => h.id == _selectedHabitId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${habit.title} başarıyla güncellendi! (%${habit.percentage.toStringAsFixed(0)})'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = AppController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alışkanlık Ekle / Güncelle'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final habit = controller.habits.firstWhere((h) => h.id == _selectedHabitId);
          final currentInputTarget = double.tryParse(_targetController.text.replaceAll(',', '.')) ?? habit.targetValue;
          final currentInputVal = double.tryParse(_currentController.text.replaceAll(',', '.')) ?? habit.currentValue;
          final previewPercentage = currentInputTarget > 0
              ? ((currentInputVal / currentInputTarget) * 100).clamp(0.0, 100.0)
              : 0.0;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // 1. Kategori Seçim Hapları
                Text(
                  'Alışkanlık Türü Seçin',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.habits.map((h) {
                      final isSelected = h.id == _selectedHabitId;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          avatar: Icon(
                            h.icon,
                            size: 18,
                            color: isSelected ? Colors.white : h.color,
                          ),
                          label: Text(h.title),
                          selected: isSelected,
                          selectedColor: h.color,
                          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedHabitId = h.id;
                                _loadHabitData(h.id);
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Canlı Önizleme Kartı
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: habit.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: habit.color.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(habit.icon, color: habit.color, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                habit.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '%${previewPercentage.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: habit.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (previewPercentage / 100).clamp(0.0, 1.0),
                          minHeight: 10,
                          backgroundColor: isDark ? Colors.white12 : Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(habit.color),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        previewPercentage >= 100
                            ? '🎉 Tebrikler! Hedef tamamlandı ve başarı rozeti açılacak!'
                            : 'Hedefe ulaşmak için ${_formatValue((currentInputTarget - currentInputVal).clamp(0.0, currentInputTarget))} ${habit.unit} kaldı.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: previewPercentage >= 100 ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Hedef Değeri Girişi
                Text(
                  'Günlük Hedeflenen Değer (${habit.unit})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _targetController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.flag_rounded),
                    suffixText: habit.unit,
                    hintText: 'Örn. ${_formatValue(habit.targetValue)}',
                  ),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Hedeflenen değer boş bırakılamaz.';
                    }
                    final parsed = double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null || parsed <= 0) {
                      return 'Pozitif bir değer giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // 4. Gerçekleşen Değer Girişi
                Text(
                  'Bugün Gerçekleşen Değer (${habit.unit})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _currentController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.check_circle_outline_rounded),
                    suffixText: habit.unit,
                    hintText: 'Örn. ${_formatValue(habit.currentValue)}',
                  ),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Gerçekleşen değer boş bırakılamaz.';
                    }
                    final parsed = double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null || parsed < 0) {
                      return 'Negatif değer girilemez.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Hızlı Artırım / Azaltım Butonları
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepButton(label: '-10%', factor: -0.1, habit: habit),
                    const SizedBox(width: 8),
                    _buildStepButton(label: '+10%', factor: 0.1, habit: habit),
                    const SizedBox(width: 8),
                    _buildStepButton(label: '+25%', factor: 0.25, habit: habit),
                    const SizedBox(width: 8),
                    _buildStepButton(label: 'Tamamla (%100)', factor: 1.0, isMax: true, habit: habit),
                  ],
                ),
                const SizedBox(height: 32),

                // 5. Kaydet Butonu
                ElevatedButton.icon(
                  onPressed: _saveHabit,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Hedefi Güncelle ve Kaydet'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepButton({
    required String label,
    required double factor,
    required HabitGoal habit,
    bool isMax = false,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        double current = double.tryParse(_currentController.text.replaceAll(',', '.')) ?? habit.currentValue;
        double target = double.tryParse(_targetController.text.replaceAll(',', '.')) ?? habit.targetValue;
        double nextVal;
        if (isMax) {
          nextVal = target;
        } else {
          nextVal = (current + (target * factor)).clamp(0.0, target * 2);
        }
        setState(() {
          _currentController.text = _formatValue(nextVal);
        });
      },
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
