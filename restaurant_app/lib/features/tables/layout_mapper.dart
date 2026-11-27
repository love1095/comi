import 'package:comi_api/comi_api.dart' as api;
import 'package:shared_ui/shared_ui.dart';

import 'layout_draft.dart';

TableShape shapeFromApi(api.TableShape s) => switch (s) {
  api.TableShape.RECT => TableShape.rect,
  api.TableShape.ROUND => TableShape.round,
  api.TableShape.SQUARE => TableShape.square,
  api.TableShape.BOOTH => TableShape.booth,
  api.TableShape.BAR_SEAT => TableShape.barSeat,
};

api.LayoutTableDtoShapeEnum shapeToApi(TableShape s) => switch (s) {
  TableShape.rect => api.LayoutTableDtoShapeEnum.RECT,
  TableShape.round => api.LayoutTableDtoShapeEnum.ROUND,
  TableShape.square => api.LayoutTableDtoShapeEnum.SQUARE,
  TableShape.booth => api.LayoutTableDtoShapeEnum.BOOTH,
  TableShape.barSeat => api.LayoutTableDtoShapeEnum.BAR_SEAT,
};

MapElementKind elementFromApi(api.MapElementType t) => switch (t) {
  api.MapElementType.ENTRANCE => MapElementKind.entrance,
  api.MapElementType.WINDOW => MapElementKind.window,
  api.MapElementType.WALL => MapElementKind.wall,
  api.MapElementType.KITCHEN => MapElementKind.kitchen,
  api.MapElementType.BAR => MapElementKind.bar,
  api.MapElementType.STAGE => MapElementKind.stage,
  api.MapElementType.RESTROOM => MapElementKind.restroom,
  api.MapElementType.STAIRS => MapElementKind.stairs,
  api.MapElementType.PLANT => MapElementKind.plant,
  api.MapElementType.TV => MapElementKind.tv,
  api.MapElementType.AIRCON => MapElementKind.aircon,
  api.MapElementType.SMOKING_AREA => MapElementKind.smokingArea,
};

/// `smokingArea` → `SMOKING_AREA`.
api.MapElementDtoTypeEnum elementToApi(MapElementKind k) {
  final wire = k.name.replaceAllMapped(RegExp("[A-Z]"), (m) => "_${m[0]}").toUpperCase();
  return api.MapElementDtoTypeEnum.values.firstWhere((v) => v.value == wire);
}

/// Server layout → editor draft. Tables never placed on the map (created from the table
/// list) get the first free spot; the draft is then marked dirty so the user saves it.
LayoutDraft draftFromDto(api.AreaLayoutDto dto) {
  final cols = dto.gridCols.toInt(), rows = dto.gridRows.toInt();
  final placed = <MapTable>[];
  final unplaced = <MapTable>[];
  for (final t in dto.tables) {
    final table = MapTable(
      id: t.id,
      code: t.code,
      minSeats: t.minSeats.toInt(),
      maxSeats: t.maxSeats.toInt(),
      x: t.posX?.toInt() ?? -1,
      y: t.posY?.toInt() ?? -1,
      width: t.width.toInt(),
      height: t.height.toInt(),
      rotation: t.rotation.toInt(),
      shape: shapeFromApi(t.shape),
      features: t.features,
      joinGroup: t.joinGroup,
      selectable: t.isSelectable,
      active: t.isActive,
    );
    (t.posX == null || t.posY == null ? unplaced : placed).add(table);
  }
  for (final t in unplaced) {
    final spot = findFreeSpot(cols, rows, placed, t.footprint) ?? (x: 0, y: 0);
    placed.add(t.copyWith(x: spot.x, y: spot.y));
  }
  return LayoutDraft(
    areaId: dto.id,
    areaName: dto.name,
    cols: cols,
    rows: rows,
    tables: placed,
    elements: [
      for (final e in dto.elements)
        MapElement(
          kind: elementFromApi(e.type),
          x: e.x.toInt(),
          y: e.y.toInt(),
          width: e.width.toInt(),
          height: e.height.toInt(),
          rotation: e.rotation.toInt(),
          label: e.label,
        ),
    ],
    dirty: unplaced.isNotEmpty,
  );
}

/// Editor draft → `PUT /restaurant/areas/:id/layout`. The server replaces the area:
/// tables left out are deleted (or deactivated if they have bookings).
api.SaveLayoutDto draftToDto(LayoutDraft d) => api.SaveLayoutDto(
  gridCols: d.cols,
  gridRows: d.rows,
  tables: [
    for (final t in d.tables)
      api.LayoutTableDto(
        id: t.id.startsWith(newTablePrefix) || t.id.isEmpty ? null : t.id,
        code: t.code.trim().toUpperCase(),
        minSeats: t.minSeats,
        maxSeats: t.maxSeats,
        shape: shapeToApi(t.shape),
        posX: t.x,
        posY: t.y,
        width: t.width,
        height: t.height,
        rotation: t.rotation,
        features: t.features,
        isSelectable: t.selectable,
        isActive: t.active,
        joinGroup: (t.joinGroup?.trim().isEmpty ?? true) ? null : t.joinGroup!.trim(),
      ),
  ],
  elements: [
    for (final e in d.elements)
      api.MapElementDto(
        type: elementToApi(e.kind),
        label: (e.label?.trim().isEmpty ?? true) ? null : e.label!.trim(),
        x: e.x,
        y: e.y,
        width: e.width,
        height: e.height,
        rotation: e.rotation,
      ),
  ],
);
