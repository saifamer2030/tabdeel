class ColorModel {
  int id;
  String name;

  ColorModel(this.id, this.name);

  static List<ColorModel> getCompanies() {
    return <ColorModel>[
      ColorModel(1, 'أبيض'),
      ColorModel(2, 'أسود'),
      ColorModel(3, 'أخضر'),
      ColorModel(4, 'أزرق'),
      ColorModel(5, 'أصفر'),
        ColorModel(1, 'بني'),
      ColorModel(2, 'أحمر'),
      ColorModel(3, 'برتقالي'),
      ColorModel(4, 'لبني'),
      ColorModel(5, 'بنفسجي'),
      ColorModel(5, 'رمادي'),
      ColorModel(5, 'غير ذلك'),
                            
    ];
  }
}