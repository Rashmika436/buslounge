import 'package:flutter/material.dart';
import '../widgets/photo_tips_card.dart';

class PhotosAndGalleryScreen extends StatefulWidget {
  const PhotosAndGalleryScreen({super.key});

  @override
  State<PhotosAndGalleryScreen> createState() => _PhotosAndGalleryScreenState();
}

class _PhotosAndGalleryScreenState extends State<PhotosAndGalleryScreen> {
  int _imageCount = 0; // Track number of images selected (simulated)

  // Function to simulate picking images
  void _pickImages() {
    setState(() {
      _imageCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image $_imageCount selected (simulated)'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos & Gallery'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/lounge/location-contact'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Show off your lounge with great photos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            // Photo selection area
            Row(
              children: [
                // Add Photos Button (left)
                Expanded(
                  child: GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Add photos', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Selected Photos Placeholder (right)
                Expanded(
                  child: _imageCount == 0
                      ? Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library_outlined, size: 32, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('No photos selected yet', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        )
                      : Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            border: Border.all(color: Colors.green[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, size: 40, color: Colors.green[700]),
                              const SizedBox(height: 8),
                              Text(
                                '$_imageCount photo${_imageCount > 1 ? 's' : ''} selected',
                                style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Photo Tips Card
            const PhotoTipsCard(),
            const SizedBox(height: 32),
            // Create Lounge Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _imageCount > 0
                    ? () {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lounge created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Navigate back to admin home page (registration home)
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/admin/home',
                          (route) => false,
                        );
                      }
                    : null,  // Disable if no photos
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Create Lounge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
