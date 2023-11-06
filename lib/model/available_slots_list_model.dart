class AvailableSlotsListModel {
  int? result;
  String? msg;
  List<DataSlots>? dataSlots;

  AvailableSlotsListModel({this.result, this.msg, this.dataSlots});

  AvailableSlotsListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      dataSlots = <DataSlots>[];
      json['data'].forEach((v) {
        dataSlots!.add(DataSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['msg'] = msg;
    if (dataSlots != null) {
      data['data'] = dataSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSlots {
  int? slotId;
  String? slotName;
  String? slotTime;
  bool? isAvail;

  DataSlots({this.slotId, this.slotName, this.slotTime, this.isAvail});

  DataSlots.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    slotName = json['slot_name'];
    slotTime = json['slot_time'];
    isAvail = json['is_avail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot_id'] = slotId;
    data['slot_name'] = slotName;
    data['slot_time'] = slotTime;
    data['is_avail'] = isAvail;
    return data;
  }
}
