final String tableSecAccount = "SecAccount";

final String columnId = "id";
final String columnUsername = "username";
final String columnTag = "tag";
final String columnPassword = "password";
final String columnCreatedDate = "created_date";
final String columnUpdatedDate = "updated_date";
final String columnAlternate1 = "alternate1";
final String columnAlternate2 = "alternate2";
final String columnAlternate3 = "alternate3";
final String columnAlternate4 = "alternate4";
/// Account model of database
class SecAccount {
  /// ID
  int id;

  /// username
  String username;

  /// tag for differentiate users
  String tag;

  /// password
  String password;

  /// create date
  DateTime createdDate;

  /// create date
  DateTime updatedDate;

  /// Alternate field
  String alternate1;

  /// Alternate field
  String alternate2;

  /// Alternate field
  String alternate3;

  /// Alternate field
  String alternate4;

  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      columnUsername: username,
      columnTag: tag,
      columnPassword: password,
      columnCreatedDate: createdDate.millisecondsSinceEpoch,
      columnUpdatedDate: updatedDate.millisecondsSinceEpoch,
      columnAlternate1: alternate1,
      columnAlternate2: alternate2,
      columnAlternate3: alternate3,
      columnAlternate4: alternate4,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

   SecAccount({this.id,this.password});
  SecAccount.fromMap(dynamic obj) {
    this.id = obj[columnId];
    this.username = obj[columnUsername];
    this.tag = obj[columnTag];
    this.password = obj[columnPassword];
    this.createdDate = DateTime.fromMillisecondsSinceEpoch(obj[columnCreatedDate],isUtc: true);
    this.updatedDate = DateTime.fromMillisecondsSinceEpoch(obj[columnUpdatedDate],isUtc: true);
    this.alternate1 = obj[columnAlternate1];
    this.alternate2 = obj[columnAlternate2];
    this.alternate3 = obj[columnAlternate3];
    this.alternate4 = obj[columnAlternate4];
  }
}
