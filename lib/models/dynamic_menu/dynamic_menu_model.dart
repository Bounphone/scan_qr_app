import 'dart:convert';

DynamicMenuModel? dynamicMenuModelFromJson(String str) =>
    DynamicMenuModel.fromJson(json.decode(str));

String dynamicMenuModelToJson(DynamicMenuModel? data) =>
    json.encode(data!.toJson());

class DynamicMenuModel {
  DynamicMenuModel({
    this.response,
    this.menu,
  });

  Response? response;
  List<Menu?>? menu;

  factory DynamicMenuModel.fromJson(Map<String, dynamic> json) =>
      DynamicMenuModel(
        response: Response.fromJson(json["response"]),
        menu: json["menu"] == null
            ? []
            : List<Menu?>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x!.toJson())),
      };
}

class Menu {
  Menu({
    this.version,
    this.groups,
    this.buttonPayment,
    this.forceUpdate,
    this.updateLink,
    this.forceReLogin,
  });

  String? version;
  List<Group?>? groups;
  bool? buttonPayment;
  dynamic forceUpdate;
  UpdateLink? updateLink;
  ForceReLogin? forceReLogin;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        version: json["version"],
        groups: json["groups"] == null
            ? []
            : List<Group?>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        buttonPayment: json["buttonPayment"],
        forceUpdate: json["forceUpdate"],
        updateLink: UpdateLink.fromJson(json["updateLink"]),
        forceReLogin: ForceReLogin.fromJson(json["forceReLogin"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x!.toJson())),
        "buttonPayment": buttonPayment,
        "forceUpdate": forceUpdate,
        "updateLink": updateLink!.toJson(),
        "forceReLogin": forceReLogin!.toJson(),
      };
}

class ForceReLogin {
  ForceReLogin({
    this.needReLogin,
    this.signature,
  });

  bool? needReLogin;
  String? signature;

  factory ForceReLogin.fromJson(Map<String, dynamic> json) => ForceReLogin(
        needReLogin: json["needReLogin"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "needReLogin": needReLogin,
        "signature": signature,
      };
}

class Group {
  Group({
    this.panels,
    this.groupId,
  });

  List<Panel?>? panels;
  dynamic groupId;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        panels: json["panels"] == null
            ? []
            : List<Panel?>.from(json["panels"]!.map((x) => Panel.fromJson(x))),
        groupId: json["groupID"],
      );

  Map<String, dynamic> toJson() => {
        "panels": panels == null
            ? []
            : List<dynamic>.from(panels!.map((x) => x!.toJson())),
        "groupID": groupId,
      };
}

class Panel {
  Panel({
    this.title,
    this.background,
    this.type,
    this.items,
    this.priority,
  });

  String? title;
  String? background;
  dynamic type;
  List<Item?>? items;
  dynamic priority;

  factory Panel.fromJson(Map<String, dynamic> json) => Panel(
        title: json["title"],
        background: json["background"],
        type: json["type"],
        items: json["items"] == null
            ? []
            : List<Item?>.from(json["items"]!.map((x) => Item.fromJson(x))),
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "background": background,
        "type": type,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x!.toJson())),
        "priority": priority,
      };
}

class Item {
  Item({
    this.title,
    this.label,
    this.subTitle,
    this.detail,
    this.subDetail,
    this.icon,
    this.background,
    this.behaviorType,
    this.isHasBehavior,
  });

  String? title;
  String? label;
  String? subTitle;
  String? detail;
  String? subDetail;
  String? icon;
  String? background;
  BehaviorType? behaviorType;
  bool? isHasBehavior;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        label: json["label"],
        subTitle: json["subTitle"],
        detail: json["detail"],
        subDetail: json["subDetail"],
        icon: json["icon"],
        background: json["background"],
        behaviorType: BehaviorType.fromJson(json["behaviorType"]),
        isHasBehavior: json["isHasBehavior"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "label": label,
        "subTitle": subTitle,
        "detail": detail,
        "subDetail": subDetail,
        "icon": icon,
        "background": background,
        "behaviorType": behaviorType!.toJson(),
        "isHasBehavior": isHasBehavior,
      };
}

class BehaviorType {
  BehaviorType({
    this.navigationType,
    this.url,
    this.fields,
    this.streaming,
  });

  dynamic navigationType;
  String? url;
  List<Field?>? fields;
  Streaming? streaming;

  factory BehaviorType.fromJson(Map<String, dynamic> json) => BehaviorType(
        navigationType: json["navigationType"],
        url: json["url"],
        fields: json["fields"] == null
            ? []
            : List<Field?>.from(json["fields"]!.map((x) => Field.fromJson(x))),
        streaming: Streaming.fromJson(json["streaming"]),
      );

  Map<String, dynamic> toJson() => {
        "navigationType": navigationType,
        "url": url,
        "fields": fields == null
            ? []
            : List<dynamic>.from(fields!.map((x) => x!.toJson())),
        "streaming": streaming!.toJson(),
      };
}

class Field {
  Field({
    this.controllerId,
    this.widgetType,
    this.text,
    this.maxLength,
    this.textAlignment,
    this.alignment,
    this.padding,
    this.background,
    this.textColor,
    this.size,
    this.space,
    this.icon,
  });

  String? controllerId;
  dynamic widgetType;
  String? text;
  String? maxLength;
  String? textAlignment;
  String? alignment;
  Padding? padding;
  String? background;
  String? textColor;
  Size? size;
  Padding? space;
  String? icon;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        controllerId: json["controllerID"],
        widgetType: json["widgetType"],
        text: json["text"],
        maxLength: json["maxLength"],
        textAlignment: json["textAlignment"],
        alignment: json["alignment"],
        padding: Padding.fromJson(json["padding"]),
        background: json["background"],
        textColor: json["textColor"],
        size: Size.fromJson(json["size"]),
        space: Padding.fromJson(json["space"]),
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "controllerID": controllerId,
        "widgetType": widgetType,
        "text": text,
        "maxLength": maxLength,
        "textAlignment": textAlignment,
        "alignment": alignment,
        "padding": padding!.toJson(),
        "background": background,
        "textColor": textColor,
        "size": size!.toJson(),
        "space": space!.toJson(),
        "icon": icon,
      };
}

class Padding {
  Padding({
    this.vertical,
    this.horizontal,
  });

  dynamic vertical;
  dynamic horizontal;

  factory Padding.fromJson(Map<String, dynamic> json) => Padding(
        vertical: json["vertical"],
        horizontal: json["horizontal"],
      );

  Map<String, dynamic> toJson() => {
        "vertical": vertical,
        "horizontal": horizontal,
      };
}

class Size {
  Size({
    this.width,
    this.height,
  });

  dynamic width;
  dynamic height;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

class Streaming {
  Streaming({
    this.mainApi,
    this.chanelApIs,
    this.commentLink,
  });

  Api? mainApi;
  List<Api?>? chanelApIs;
  CommentLink? commentLink;

  factory Streaming.fromJson(Map<String, dynamic> json) => Streaming(
        mainApi: Api.fromJson(json["mainAPI"]),
        chanelApIs: json["chanelAPIs"] == null
            ? []
            : List<Api?>.from(json["chanelAPIs"]!.map((x) => Api.fromJson(x))),
        commentLink: CommentLink.fromJson(json["commentLink"]),
      );

  Map<String, dynamic> toJson() => {
        "mainAPI": mainApi!.toJson(),
        "chanelAPIs": chanelApIs == null
            ? []
            : List<dynamic>.from(chanelApIs!.map((x) => x!.toJson())),
        "commentLink": commentLink!.toJson(),
      };
}

class Api {
  Api({
    this.uid,
    this.urls,
    this.title,
    this.description,
    this.startLiveTime,
    this.author,
    this.tags,
  });

  String? uid;
  List<Url?>? urls;
  String? title;
  String? description;
  String? startLiveTime;
  String? author;
  List<String?>? tags;

  factory Api.fromJson(Map<String, dynamic> json) => Api(
        uid: json["uid"],
        urls: json["urls"] == null
            ? []
            : List<Url?>.from(json["urls"]!.map((x) => Url.fromJson(x))),
        title: json["title"],
        description: json["description"],
        startLiveTime: json["startLiveTime"],
        author: json["author"],
        tags: json["tags"] == null
            ? []
            : List<String?>.from(json["tags"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "urls": urls == null
            ? []
            : List<dynamic>.from(urls!.map((x) => x!.toJson())),
        "title": title,
        "description": description,
        "startLiveTime": startLiveTime,
        "author": author,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
      };
}

class Url {
  Url({
    this.url,
    this.resolution,
  });

  String? url;
  dynamic resolution;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        url: json["url"],
        resolution: json["resolution"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "resolution": resolution,
      };
}

class CommentLink {
  CommentLink({
    this.getComment,
    this.postComment,
  });

  String? getComment;
  String? postComment;

  factory CommentLink.fromJson(Map<String, dynamic> json) => CommentLink(
        getComment: json["getComment"],
        postComment: json["postComment"],
      );

  Map<String, dynamic> toJson() => {
        "getComment": getComment,
        "postComment": postComment,
      };
}

class UpdateLink {
  UpdateLink({
    this.iOs,
    this.android,
    this.huawei,
    this.other,
  });

  String? iOs;
  String? android;
  String? huawei;
  String? other;

  factory UpdateLink.fromJson(Map<String, dynamic> json) => UpdateLink(
        iOs: json["iOS"],
        android: json["android"],
        huawei: json["huawei"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "iOS": iOs,
        "android": android,
        "huawei": huawei,
        "other": other,
      };
}

class Response {
  Response({
    this.code,
    this.message,
    this.success,
    this.detail,
  });

  String? code;
  String? message;
  bool? success;
  String? detail;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
        "detail": detail,
      };
}
