package bookmanage_java_20200522;
import java.util.Scanner;   
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class booksearch {
	private DbUtil dbUtil=new DbUtil();
	public static void main(String[] args) {
		// TODO Auto-generated method stub

        Scanner sc = new Scanner(System.in); 
        System.out.println("请输入要查找的书名："); 
        String bname = sc.nextLine();      //取得用户输入的字符串
     //  System.out.println("请输入你的年龄："); 
     //  int age = sc.nextInt(); 
     //  System.out.println("请输入你的工资："); 
    //   float salary = sc.nextFloat(); 
    //   System.out.println("你的信息如下："); 
    //   System.out.println("姓名："+name+"\n"+"年龄："+age+"\n"+"工资："+salary); 
   		booksearch b=new booksearch();
        b.ser_book(bname);
   }
	public void ser_book(String bn)
	{	
	  Connection con=null;
	  PreparedStatement pstmt = null;
      ResultSet rs = null;
	  try {
		con=dbUtil.getCon();
		String sql="select bookno,bookname from book  ";
		sql=sql + "where bookname like concat('%','" + bn +"','%');";
		
		// 获取执行sql语句对象
        pstmt=con.prepareStatement(sql);      
        // 执行查询操作
        rs=pstmt.executeQuery();
        //处理结果集

    	if (rs.next()) {
    	System.out.println("查询结果："); 	
		System.out.println("bookno          bookname ");	
		rs.previous();
		}
		else{
			System.out.println("查不到数据"); 
		};
        
        
        while (rs.next()) {         	
            System.out.println(rs.getString(1).trim()+"       "+rs.getString(2).trim());
                          }
            }
		 catch(Exception e)
		    {
			e.printStackTrace();
		     }
		   finally
		   {
			try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

/*
		       Statement stmt = con.createStatement();		
		       String sql = "insert into book(bookno,bookname) values ('"+bookNo +"','"+bookName +"');";  
		       stmt.executeUpdate(sql);
 */
