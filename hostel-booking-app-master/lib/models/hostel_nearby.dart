class HostelNearby {
  String imageUrl;
  String title;
  String description;
  double price;
  double rating;

  HostelNearby(
      {this.description, this.imageUrl, this.price, this.rating, this.title});
}

final List<HostelNearby> hostels = [
  HostelNearby(
    imageUrl: 'assets/images/AdomBi.jpg',
    title: 'Adom Bi Hostel',
    description: 'Kumasi, Ayeduase',
    price: 4500.00,
    rating: 4.5,
  ),
  HostelNearby(
    imageUrl: 'assets/images/HappyFamily.jpg',
    title: 'Happy Family',
    description: 'Kumasi, Ayeduase',
    price: 2800.00,
    rating: 3.9,
  ),
  HostelNearby(
    imageUrl: 'assets/images/P3.jpg',
    title: 'P3 Hostel',
    description: 'Kumasi, Ayeduase',
    price: 2700.00,
    rating: 3.5,
  ),
  HostelNearby(
    imageUrl: 'assets/images/Frontline.jpg',
    title: 'Frontline Hostel',
    description: 'Kumasi, Ayeduase',
    price: 3400.00,
    rating: 4.0,
  )
];
