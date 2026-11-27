import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api_error.dart';
import 'layout_draft.dart';
import 'layout_mapper.dart';
import 'tables_repository.dart';

/// Loads one area's map, keeps the draft + undo history, saves it.
class MapEditorController extends AsyncNotifier<LayoutDraft> {
  MapEditorController(this.areaId);
  final String areaId;

  final _undo = <LayoutDraft>[];

  /// Re-entrancy guard; the screen shows its own progress indicator.
  bool saving = false;

  bool get canUndo => _undo.isNotEmpty;

  @override
  Future<LayoutDraft> build() async {
    _undo.clear();
    return draftFromDto(await ref.read(tablesRepositoryProvider).getLayout(areaId));
  }

  /// Applies a change. Selection-only changes are not added to the undo history.
  void edit(LayoutDraft Function(LayoutDraft d) change, {bool undoable = true}) {
    final d = state.value;
    if (d == null) return;
    if (undoable) {
      _undo.add(d);
      if (_undo.length > 50) _undo.removeAt(0);
    }
    state = AsyncData(change(d));
  }

  void undo() {
    if (_undo.isEmpty) return;
    final previous = _undo.removeLast();
    state = AsyncData(previous.select(null));
  }

  /// Returns null on success, otherwise a message for the user.
  Future<String?> save() async {
    final d = state.value;
    if (d == null || saving) return null;
    if (d.problems.isNotEmpty) return 'Sơ đồ còn ${d.problems.length} lỗi';
    saving = true;
    try {
      final saved = await ref.read(tablesRepositoryProvider).saveLayout(areaId, draftToDto(d));
      _undo.clear();
      state = AsyncData(draftFromDto(saved));
      ref.invalidate(areasProvider);
      return null;
    } catch (e) {
      return ApiError.from(e).userMessage;
    } finally {
      saving = false;
    }
  }
}

final mapEditorProvider = AsyncNotifierProvider.autoDispose.family<MapEditorController, LayoutDraft, String>(MapEditorController.new);
