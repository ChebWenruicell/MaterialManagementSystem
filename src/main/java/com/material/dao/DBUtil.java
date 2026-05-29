
package com.material.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBUtil {
    private static Properties prop = new Properties();

    // 静态代码块：类加载时执行，加载配置文件
    static {
        try (InputStream is = DBUtil.class.getResourceAsStream("db.properties")) {
            prop.load(is);
            Class.forName(prop.getProperty("driver"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    } // ✅ 补上这个闭合的大括号！

    // 获取数据库连接的静态方法
    public static Connection getConn() {
        try {
            return DriverManager.getConnection(
                prop.getProperty("url"),
                prop.getProperty("username"),
                prop.getProperty("password")
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}