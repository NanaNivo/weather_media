abstract class Mapper<From, To> {

  To map(From object);

  From? unmap(To object) {
    return null;
  }

  List<To> mapList(List<From> objects) {
    List<To> temp = [];
    for (From item in objects) {
      temp.add(map(item));
    }
    return temp;
  }

  List<From> unmapList(List<To> objects) {
    List<From> temp = [];
    for (To item in objects) {
      if(unmap(item)!=null)
      {
      temp.add(unmap(item)!);
      }
    }
    return temp;
  }
}