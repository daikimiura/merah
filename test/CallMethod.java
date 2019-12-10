class CallMethod
{
  public static void main(String[] args){
    sub(1, "hogehoge");
  }
  public static void sub(int a, String b){
    System.out.println("sub() is called");
    System.out.println(a);
    System.out.println(b);
  }
}
