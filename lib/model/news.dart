class News{
  final String title, description, date;
  final int create_by, update_by;

  News({
    this.title,
    this.description,
    this.date,
    this.create_by,
    this.update_by
  });

  factory News.fromJson(Map<String, dynamic> json){
    return new News(
        title: json['title'],
        description: json['description'],
        date : json['date'],
        create_by: json['create_by'],
        update_by: json['update_by'],
    );
  }
}