import 'package:comi_api/comi_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/api_error.dart';
import '../../data/session.dart';
import '../auth/restaurant_picker_screen.dart' show myRestaurantsProvider;
import 'onboarding_repository.dart';

/// Step 1 of onboarding: the restaurant's basic info. The account becomes its owner.
class RegisterRestaurantScreen extends ConsumerStatefulWidget {
  const RegisterRestaurantScreen({super.key});

  @override
  ConsumerState<RegisterRestaurantScreen> createState() => _RegisterRestaurantScreenState();
}

class _RegisterRestaurantScreenState extends ConsumerState<RegisterRestaurantScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  var _province = provinces.first.$1;
  var _priceLevel = 1;
  final _cuisine = <String>{};
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final r = await ref
          .read(onboardingRepositoryProvider)
          .register(
            RegisterRestaurantDto(
              name: _name.text.trim(),
              phone: _phone.text.replaceAll(RegExp(r'[\s.-]'), ''),
              address: _address.text.trim(),
              provinceCode: _province,
              priceLevel: _priceLevel,
              cuisineTags: _cuisine.toList(),
            ),
          );
      ref.invalidate(myRestaurantsProvider);
      await ref.read(sessionProvider.notifier).selectRestaurant(r.id, r.name);
      if (mounted) context.go('/setup');
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.from(e).userMessage);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký quán')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _form,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Thông tin cơ bản — có thể sửa sau. Quán chỉ hiện với khách sau khi comi duyệt.', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _name,
                  maxLength: 120,
                  decoration: const InputDecoration(labelText: 'Tên quán *', hintText: 'Quán Nhậu Bờ Kè', border: OutlineInputBorder()),
                  validator: (v) => (v ?? '').trim().length < 2 ? 'Nhập tên quán' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại quán *',
                    hintText: '0901234567',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      RegExp(r'^\+?[0-9]{8,15}$').hasMatch((v ?? '').replaceAll(RegExp(r'[\s.-]'), '')) ? null : 'Số điện thoại chưa đúng',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _address,
                  maxLength: 300,
                  decoration: const InputDecoration(
                    labelText: 'Địa chỉ *',
                    hintText: '12 Nguyễn Huệ, Phường Bến Nghé',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v ?? '').trim().length < 5 ? 'Nhập địa chỉ' : null,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _province,
                  decoration: const InputDecoration(labelText: 'Tỉnh / thành phố', border: OutlineInputBorder()),
                  items: [for (final p in provinces) DropdownMenuItem(value: p.$1, child: Text(p.$2))],
                  onChanged: (v) => setState(() => _province = v!),
                ),
                const SizedBox(height: 16),
                Text('Mức giá', style: theme.textTheme.labelLarge),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (var l = 1; l <= 4; l++)
                      ChoiceChip(
                        label: Text('${'₫' * l} · ${priceLevelLabel(l)}'),
                        selected: _priceLevel == l,
                        onSelected: (_) => setState(() => _priceLevel = l),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Loại món (chọn tối đa 10)', style: theme.textTheme.labelLarge),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final c in cuisineOptions)
                      FilterChip(
                        label: Text(c),
                        selected: _cuisine.contains(c),
                        onSelected: (on) => setState(() => on ? _cuisine.add(c) : _cuisine.remove(c)),
                      ),
                  ],
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _busy ? null : _submit,
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                  child: Text(_busy ? 'Đang tạo…' : 'Tạo quán'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
