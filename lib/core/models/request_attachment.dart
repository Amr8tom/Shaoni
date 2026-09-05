/// A single attachment, normalized from any service's details JSON.
///
/// Prefers a `url` (the new backend shape used by `leaves_attachment_ids` /
/// `supportedAttachments`); falls back to a raw `base64` string (legacy) so
/// nothing breaks while the backend migrates services from base64 to URLs.
class RequestAttachment {
  final int? id;
  final String name;
  final String url;
  final String mimetype;
  final String base64;

  const RequestAttachment({
    this.id,
    this.name = '',
    this.url = '',
    this.mimetype = '',
    this.base64 = '',
  });

  bool get hasUrl => url.trim().isNotEmpty;
  bool get hasBase64 => base64.trim().isNotEmpty;

  bool get isImage {
    if (mimetype.toLowerCase().startsWith('image/')) return true;
    final n = name.toLowerCase();
    return n.endsWith('.jpg') ||
        n.endsWith('.jpeg') ||
        n.endsWith('.png') ||
        n.endsWith('.gif') ||
        n.endsWith('.webp');
  }

  /// Attachment-list keys, in priority order, seen across the services'
  /// details responses.
  static const List<String> _listKeys = [
    'leaves_attachment_ids',
    'supportedAttachments',
    'attachments',
    'request_attachment_ids',
  ];

  /// Legacy single base64-string keys.
  static const List<String> _stringKeys = [
    'leavesAttachment',
    'attachment',
    'attachmentBase64',
  ];

  /// Scans a service's sub-object JSON for whichever attachment key is present.
  static List<RequestAttachment> fromServiceMap(Map<String, dynamic> json) {
    for (final k in _listKeys) {
      final v = json[k];
      if (v is List && v.isNotEmpty) return listFrom(v);
    }
    for (final k in _stringKeys) {
      final v = json[k];
      if (v is String && v.trim().isNotEmpty) {
        return [RequestAttachment(base64: v)];
      }
    }
    return const [];
  }

  /// Normalizes a raw attachment value into a clean list. Handles every shape
  /// seen across services:
  ///   - a single base64 string
  ///   - a list of base64 strings (legacy car / study)
  ///   - a list of url-objects `{id, name, url, mimetype}` (exit / leave)
  ///   - a list of grouped objects `{name, files: [{ attachmentBase64 | url }]}`
  ///     (study current)
  static List<RequestAttachment> listFrom(dynamic value) {
    if (value is String) {
      return value.trim().isEmpty
          ? const []
          : [RequestAttachment(base64: value)];
    }
    if (value is! List) return const [];

    final out = <RequestAttachment>[];
    for (final e in value) {
      if (e is String) {
        if (e.trim().isNotEmpty) out.add(RequestAttachment(base64: e));
        continue;
      }
      if (e is! Map) continue;
      final m = e.cast<String, dynamic>();

      final files = m['files'];
      if (files is List && files.isNotEmpty) {
        final groupName = (m['name'] ?? '').toString();
        for (final f in files) {
          if (f is Map) {
            out.add(_fromMap(f.cast<String, dynamic>(), fallbackName: groupName));
          }
        }
        continue;
      }
      out.add(_fromMap(m));
    }
    return out;
  }

  static RequestAttachment _fromMap(Map<String, dynamic> m,
      {String fallbackName = ''}) {
    final url = (m['url'] ?? '').toString();
    final base64 =
        (m['attachmentBase64'] ?? m['attachment'] ?? '').toString();
    final name = (m['name'] ?? '').toString();
    return RequestAttachment(
      id: m['id'] as int?,
      name: name.isNotEmpty ? name : fallbackName,
      url: url,
      mimetype: (m['mimetype'] ?? '').toString(),
      // Prefer the url; keep base64 only when there is no url.
      base64: url.isEmpty ? base64 : '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'mimetype': mimetype,
        'attachmentBase64': base64,
      };
}
