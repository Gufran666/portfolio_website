class TestimonialModel {
  final String id;
  final String clientName;
  final String feedback;
  final String? clientImageUrl; 
  final String? role; 
  TestimonialModel({
    required this.id,
    required this.clientName,
    required this.feedback,
    this.clientImageUrl,
    this.role,
  });
}