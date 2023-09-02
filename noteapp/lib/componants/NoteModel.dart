class NoteModel {
  int? notesId;
  String? notesTitle;
  String? notesContent;
  int? notesUser;
  String? imagename;

  NoteModel({
    this.notesId,
    this.notesTitle,
    this.notesContent,
    this.notesUser, 
    this.imagename
    });

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notesId'];
    notesTitle = json['notesTitle'];
    notesContent = json['notesContent'];
    notesUser = json['notesUser'];
    imagename = json['imagename'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['notesId'] = this.notesId;
  //   data['notesTitle'] = this.notesTitle;
  //   data['notesContent'] = this.notesContent;
  //   data['notesUser'] = this.notesUser;
  //   return data;
  // }
}