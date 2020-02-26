import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:logging/logging.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

part 'phone.g.dart';

final _logger = Logger('component.phone');

@JsonSerializable()
class MyPhone extends StatelessWidget {
  /// 号码
  @JsonKey(defaultValue: '', name: 'num')
  final String phoneNumber;

  /// 名字
  @JsonKey(defaultValue: '', name: 'fName')
  final String givenName;

  /// 姓氏
  @JsonKey(defaultValue: '', name: 'lName')
  final String familyName;

  /// 工作电话
  @JsonKey(defaultValue: '', name: 'workNum')
  final String workNumber;

  /// 公司电话
  @JsonKey(defaultValue: '', name: 'hostNum')
  final String hostNumer;

  /// 住宅电话
  @JsonKey(defaultValue: '', name: 'homeNum')
  final String homeNumber;

  /// 公司
  @JsonKey(defaultValue: '', name: 'org')
  final String company;

  /// 备注
  @JsonKey(defaultValue: '', name: 'remark')
  final String note;

  /// 昵称
  @JsonKey(defaultValue: '', name: 'nickName')
  final String displayName;

  /// 省份
  @JsonKey(defaultValue: '', name: 'province')
  final String region;

  /// 城市
  @JsonKey(defaultValue: '')
  final String city;

  /// 城市
  @JsonKey(defaultValue: '')
  final String street;

  /// 城市
  @JsonKey(defaultValue: '', name: 'postCode')
  final String postcode;

  /// 城市
  @JsonKey(defaultValue: '', name: 'title')
  final String jobTitle;

  /// 电子邮件
  @JsonKey(defaultValue: '', name: 'email')
  final String email;

  MyPhone(
    this.phoneNumber,
    this.givenName, {
    this.familyName = '',
    this.displayName = '',
    this.homeNumber = '',
    this.hostNumer = '',
    this.workNumber = '',
    this.company = '',
    this.note = '',
    this.region = '',
    this.city = '',
    this.street = '',
    this.postcode = '',
    this.jobTitle = '',
    this.email = '',
  });
  factory MyPhone.fromJson(Map<String, dynamic> json) =>
      _$MyPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$MyPhoneToJson(this);

  /// 电话列表
  List<Item> get phones {
    final phoneList = [Item(label: '电话', value: phoneNumber)];

    if (homeNumber.isNotEmpty) {
      phoneList.add(Item(label: '家庭电话', value: homeNumber));
    }

    if (workNumber.isNotEmpty) {
      phoneList.add(Item(label: '工作电话', value: workNumber));
    }

    if (hostNumer.isNotEmpty) {
      phoneList.add(Item(label: '公司电话', value: hostNumer));
    }

    return phoneList;
  }

  Contact get contact => Contact(
        givenName: givenName,
        familyName: familyName,
        displayName: displayName,
        company: company,
        phones: phones,
        note: note,
        postalAddresses: [
          PostalAddress(
            region: region,
            city: city,
            street: street,
            postcode: postcode,
          )
        ],
        jobTitle: jobTitle,
        emails: [Item(value: email)],
      );

  /// 拨打电话
  void _makePhoneCall() {
    final url = 'tel:$phoneNumber';

    launcher.canLaunch(url).then((canLaunch) {
      if (canLaunch) {
        launcher.launch(url);
      } else {
        _logger.warning('Phone: can not make phone call');
      }
    });
  }

  /// 添加联系人
  void _addContact() {
    // TODO: 添加前询问
    Contacts.addContact(contact).then((contact) {
      // TODO: 添加成功提示
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.phone),
            ),
            Expanded(
              child: Text(
                phoneNumber.toString(),
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            IconButton(
              icon: Icon(Icons.call),
              onPressed: _makePhoneCall,
            ),
            IconButton(
              icon: Icon(Icons.contact_phone),
              onPressed: _addContact,
            ),
          ],
        ),
      );
}
