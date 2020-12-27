package bookmanage_java_20200522;
import java.awt.Transparency;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bookmanage_java_20200522.DbUtil;

public class booklist {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 booklist b=new booklist();
		 b.ser_book();
	}
	private DbUtil dbUtil=new DbUtil();
	public void ser_book()
	{	
	  Connection con=null;
	  PreparedStatement pstmt = null;
      ResultSet rs = null;
	  try {
		con=dbUtil.getCon();
		String sql="select bookno,bookname from book";
		// 获取执行sql语句对象
        pstmt=con.prepareStatement(sql);      
        // 执行查询操作
        rs=pstmt.executeQuery();
        //处理结果集
        while (rs.next()) {         	
            System.out.println("bookno："+rs.getString(1)+"     bookname："+rs.getString(2));
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
