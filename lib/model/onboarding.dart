class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImageAssetPath(String getImagePath){
    imagePath = getImagePath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imagePath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }
}

List<SliderModel>  getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //slider 0
  sliderModel.setImageAssetPath("assets/images/splashLogo.png");
  sliderModel.setTitle("Tree");
  sliderModel.setDesc("The numbers of trees an individual has planted is recorded in their account and digital badges are unlocked at different volume breaks. They have the ability to share this on social media to spread the message..");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //slider 1
  sliderModel.setImageAssetPath("assets/images/splashLogo.png");
  sliderModel.setTitle("Tree");
  sliderModel.setDesc("The numbers of trees an individual has planted is recorded in their account and digital badges are unlocked at different volume breaks. They have the ability to share this on social media to spread the message..");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //slider 2
  sliderModel.setImageAssetPath("assets/images/splashLogo.png");
  sliderModel.setTitle("Tree");
  sliderModel.setDesc("The numbers of trees an individual has planted is recorded in their account and digital badges are unlocked at different volume breaks. They have the ability to share this on social media to spread the message..");
  slides.add(sliderModel);

  //sliderModel = new SliderModel();
  
  return slides;
}
