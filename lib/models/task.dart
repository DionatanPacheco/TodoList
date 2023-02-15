class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;
  int? color;
  int? isComplete;

  Task({
    this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
    this.color,
    this.isComplete,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['starTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    color = json['color'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['starTime'] = startTime;
    data['endTime'] = endTime;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['color'] = color;
    data['isComplete'] = isComplete;

    return data;
  }
}
