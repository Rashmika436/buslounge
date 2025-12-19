import 'package:flutter/material.dart';

/// PhotoTipsCard - Widget to display helpful tips for taking lounge photos
/// 
/// This widget provides visual guidance to help lounge owners take better photos
/// of their facilities. It displays a list of photography tips in a card format.
class PhotoTipsCard extends StatelessWidget {
  const PhotoTipsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: Colors.blue, size: 22),
              SizedBox(width: 8),
              Text(
                'Photo Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTip('📷', 'Take photos in good lighting'),
          _buildTip('🏢', 'Show the entrance and main areas'),
          _buildTip('✨', 'Keep the space clean and tidy'),
          _buildTip('📐', 'Use landscape orientation'),
          _buildTip('🎯', 'Highlight key facilities and amenities'),
        ],
      ),
    );
  }

  Widget _buildTip(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
