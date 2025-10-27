## 0.0.1

### Added
- Initial release of `multi_i18n`.
- Support for isolated translation contexts (one per package/feature) built on top of `flutter_i18n`.
- Integration with standard `flutter_i18n` loaders: `FileTranslationLoader`, `NetworkTranslationLoader`, `NamespaceFileTranslationLoader`, etc.
- Convenience helpers:
    - `translate()` via `MultiI18nDelegate` for simple translations.
    - `plural()` helper for pluralized translations.
