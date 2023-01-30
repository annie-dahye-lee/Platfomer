class FGameObject extends FBox {

  final int L = -1;
  final int R = 1;

  FGameObject(float x, float y) {
    super(x, y);
  }

  //FGameObject(int w, int h) {
  //  super(w, h);
  //}

  void act() {
  }

  boolean isTouching(String s) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact c = contacts.get(i);
      if (c.contains(s)) return true;
    }
    return false;
  }
  
  boolean objIsTouching(String s) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      if (this.getContacts().contains(s)) return true;
    }
    return false;
  }
}
