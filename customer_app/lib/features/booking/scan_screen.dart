import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Scans the table / entrance QR (§9.1) and pops with its text. A typed link works too
/// (camera denied, broken camera, or a QR that will not read).
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, this.camera = true});

  /// False in tests (no camera plugin).
  final bool camera;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final _manual = TextEditingController();
  var _done = false;

  @override
  void dispose() {
    _manual.dispose();
    super.dispose();
  }

  void _finish(String value) {
    if (_done || value.trim().isEmpty) return;
    _done = true;
    Navigator.pop(context, value.trim());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Quét mã QR trên bàn')),
    body: Column(
      children: [
        Expanded(
          child: widget.camera
              ? MobileScanner(
                  onDetect: (capture) {
                    final raw = capture.barcodes.map((b) => b.rawValue).whereType<String>().firstOrNull;
                    if (raw != null) _finish(raw);
                  },
                  errorBuilder: (context, error) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Không mở được camera — nhập mã bên dưới', textAlign: TextAlign.center),
                    ),
                  ),
                )
              : const Center(child: Icon(Icons.qr_code_scanner, size: 96)),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Mã QR dán trên bàn hoặc ở cửa quán. Không quét được? Nhờ nhân viên bấm "Khách đã đến".'),
              const SizedBox(height: 8),
              TextField(
                controller: _manual,
                decoration: InputDecoration(
                  labelText: 'Hoặc dán đường link trong mã',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: 'Dùng link này',
                    onPressed: () => _finish(_manual.text),
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
                onSubmitted: _finish,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
