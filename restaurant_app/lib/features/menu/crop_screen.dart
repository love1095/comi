import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:material_ui/material_ui.dart';

/// 4:3 crop for dish photos (§16.2). Pops with the cropped bytes, or null.
class CropScreen extends StatefulWidget {
  const CropScreen({super.key, required this.image, this.aspectRatio = 4 / 3});
  final Uint8List image;
  final double aspectRatio;

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _controller = CropController();
  var _busy = false;

  void _onCropped(CropResult result) {
    switch (result) {
      case CropSuccess(:final croppedImage):
        Navigator.pop(context, croppedImage);
      case CropFailure():
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Không cắt được ảnh, thử ảnh khác')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Cắt ảnh 4:3'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FilledButton(
            onPressed: _busy
                ? null
                : () {
                    setState(() => _busy = true);
                    _controller.crop();
                  },
            child: Text(_busy ? 'Đang cắt…' : 'Dùng ảnh'),
          ),
        ),
      ],
    ),
    body: Column(
      children: [
        const Padding(padding: EdgeInsets.all(12), child: Text('Kéo khung để chọn phần đẹp nhất của món. Ảnh rõ, đủ sáng, món ở giữa.')),
        Expanded(
          child: Crop(
            image: widget.image,
            controller: _controller,
            aspectRatio: widget.aspectRatio,
            interactive: true,
            baseColor: Colors.black,
            onCropped: _onCropped,
          ),
        ),
      ],
    ),
  );
}
