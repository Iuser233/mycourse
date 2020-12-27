package bookmanage_java_20200522;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbUtil {
	//private String dbUrl="jdbc:mysql://localhost:3306/books?useUnicode=true&amp;characterEncoding=UTF8";//jdbc连接
	private String jdbcName= "com.mysql.cj.jdbc.Driver";//jdbc驱动程序	
	private String dbUrl="jdbc:mysql://localhost:3306/books?serverTimezone=UTC&useSSL=false&characterEncoding=utf8"; 
	private String dbUserName="root";//用户名
	private String dbPassword="";//密码	
	
	
	/*获得连接对象 */
	public Connection getCon() throws Exception{
		Class.forName(jdbcName);//加载驱动
		Connection con=DriverManager.getConnection(dbUrl,dbUserName,dbPassword);//��ȡ���Ӷ���
		return con;		
	}
	
	/*断开连接	 */
	public void closeCon(Connection con) throws Exception {
		if (con!=null){
			con.close();
		}		
	}
	
	/*主函数，连接数据库*/
	public static void main(String[] args) {
		DbUtil dbUtil=new DbUtil();
		try {
			dbUtil.getCon();
			System.out.println("连接成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("连接失败");
		}		
	}	
}
