# flutter_community

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

生成DartModel
flutter packages pub run json_model


先后执行
flutter packages pub run build_runner clean 和
 flutter packages pub run build_runner build --delete-conflicting-outputs

当文件中添加了内容，会自动添加到
flutter packages pub run build_runner watch
