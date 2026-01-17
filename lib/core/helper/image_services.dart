import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

/// Service class for handling image operations with permission management
class ImageService {
  ImageService._();

  static final ImagePicker _picker = ImagePicker();
  static bool _isPicking = false;

  /// Check and request camera permission
  static Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      // User has permanently denied permission, open app settings
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// Check and request storage/photos permission
  static Future<bool> _requestStoragePermission() async {
    // For Android 13+ use photos permission
    if (Platform.isAndroid) {
      final androidInfo = await _getAndroidVersion();
      if (androidInfo >= 33) {
        final status = await Permission.photos.status;
        if (status.isGranted) return true;
        if (status.isDenied) {
          final result = await Permission.photos.request();
          return result.isGranted;
        }
        if (status.isPermanentlyDenied) {
          await openAppSettings();
          return false;
        }
      } else {
        // For older Android versions use storage permission
        final status = await Permission.storage.status;
        if (status.isGranted) return true;
        if (status.isDenied) {
          final result = await Permission.storage.request();
          return result.isGranted;
        }
        if (status.isPermanentlyDenied) {
          await openAppSettings();
          return false;
        }
      }
    } else if (Platform.isIOS) {
      // For iOS use photos permission
      final status = await Permission.photos.status;
      if (status.isGranted || status.isLimited) return true;
      if (status.isDenied) {
        final result = await Permission.photos.request();
        return result.isGranted || result.isLimited;
      }
      if (status.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
    }

    return false;
  }

  /// Get Android SDK version
  static Future<int> _getAndroidVersion() async {
    if (Platform.isAndroid) {
      // You can use device_info_plus package for this
      // For now, return a default value
      return 33; // Assume Android 13+
    }
    return 0;
  }

  /// Pick an image from the camera with permission check
  static Future<XFile?> pickImageFromCamera() async {
    if (_isPicking) return null;

    // Check camera permission first
    final hasPermission = await _requestCameraPermission();
    if (!hasPermission) {
      _logError('Camera permission denied', null);
      return null;
    }

    try {
      _isPicking = true;
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear,
      );
      return image;
    } catch (e) {
      _logError('Error picking image from camera', e);
      return null;
    } finally {
      _isPicking = false;
    }
  }

  /// Pick an image from the gallery with permission check
  static Future<XFile?> pickImageFromGallery() async {
    if (_isPicking) return null;

    // Check storage permission first
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      _logError('Storage permission denied', null);
      return null;
    }

    try {
      _isPicking = true;
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      _logError('Error picking image from gallery', e);
      return null;
    } finally {
      _isPicking = false;
    }
  }

  /// Pick multiple images from the gallery with permission check
  static Future<List<XFile>?> pickMultiImageFromGallery() async {
    if (_isPicking) return null;

    // Check storage permission first
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      _logError('Storage permission denied', null);
      return null;
    }

    try {
      _isPicking = true;
      final List<XFile> images = await _picker.pickMultiImage(imageQuality: 85);
      return images;
    } catch (e) {
      _logError('Error picking multiple images from gallery', e);
      return null;
    } finally {
      _isPicking = false;
    }
  }

  /// Save an image to the app's documents directory
  static Future<String?> saveImageToAppDirectory(XFile image) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = path.extension(image.path);
      final String fileName = 'image_$timestamp$extension';

      final String savePath = path.join(appDir.path, fileName);

      final File savedImage = await File(image.path).copy(savePath);

      return savedImage.path;
    } catch (e) {
      _logError('Error saving image to app directory', e);
      return null;
    }
  }

  /// Save multiple images to the app's documents directory
  static Future<List<String>> saveMultipleImages(List<XFile> images) async {
    final List<String> savedPaths = [];

    for (final XFile image in images) {
      final String? savedPath = await saveImageToAppDirectory(image);
      if (savedPath != null) {
        savedPaths.add(savedPath);
      }
    }

    return savedPaths;
  }

  /// Delete an image from the app's directory
  static Future<bool> deleteImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
        return true;
      }
      return false;
    } catch (e) {
      _logError('Error deleting image', e);
      return false;
    }
  }

  /// Check if the app is currently picking an image
  static bool get isPicking => _isPicking;

  /// Log errors in debug mode
  static void _logError(String message, dynamic error) {
    if (kDebugMode) {
      print('$message${error != null ? ': $error' : ''}');
    }
  }
}
