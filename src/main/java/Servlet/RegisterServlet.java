/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ilham fajri
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String url = "jdbc:sqlserver://localhost\\hm\\SQLEXPRESS:1433;databaseName=ethereal;encrypt=true;trustServerCertificate=true;";
    String username = "admin";
    String password = "admin";
    Statement st;
    ResultSet rs;
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname = request.getParameter("username");
        String upass = request.getParameter("password");
        String role = null;
        if(request.getParameter("role") != null){
             role = request.getParameter("role");
        }
        else{
            role = "user";
        }
       
        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = null;
        Connection con = null;
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, username, password);
            PreparedStatement pst = con.prepareStatement("insert into tbl_user(username,password, role) values(?,?,?)");
            pst.setString(1, uname);
            pst.setString(2, upass);
            pst.setString(3, role);

            rs = pst.executeQuery();
           
            if (rs.next()) {
                
                request.setAttribute("status", "succes");
                dispatcher = request.getRequestDispatcher("login.jsp");
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("register.jsp");
            }
            dispatcher.forward(request, response);
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        } 
                    response.sendRedirect("login.jsp");

    }

}
