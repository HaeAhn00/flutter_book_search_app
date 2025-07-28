//  {
//       "title": "Harry! (Gedichte)",
//       "link": "https://search.shopping.naver.com/book/catalog/32524001879",
//       "image": "https://shopping-phinf.pstatic.net/main_3252400/32524001879.20250612073005.jpg",
//       "author": "",
//       "discount": "22410",
//       "publisher": "Books on Demand",
//       "pubdate": "20210519",
//       "isbn": "9783753499949",
//       "description": "Liebe zieht sich wie ein roter Faden \ndurch unser Leben: \nLebens- und Liebesgedichte"
//     }

class Book {
  String title;
  String link;
  String image;
  String author;
  String discount;
  String publisher;
  String pubdate;
  String isbn;
  String description;

  Book({
    required this.title,
    required this.link,
    required this.image,
    required this.author,
    required this.discount,
    required this.publisher,
    required this.pubdate,
    required this.isbn,
    required this.description,
  });

  // 1. fromJson 네임드 생성자 만들기
  Book.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          link: map['link'],
          image: map['image'],
          author: map['author'],
          discount: map['discount'],
          publisher: map['publisher'],
          pubdate: map['pubdate'],
          isbn: map['isbn'],
          description: map['description'],
        );

  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'image': image,
      'author': author,
      'discount': discount,
      'publisher': publisher,
      'pubdate': pubdate,
      'isbn': isbn,
      'description': description,
    };
  }
}
