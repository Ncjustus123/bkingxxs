abstract class BluePrint<T>{
  const BluePrint();
  T fromJSON(dynamic json);
  Map toJSON();
}