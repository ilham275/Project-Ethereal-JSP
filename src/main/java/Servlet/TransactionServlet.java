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

/**
 *
 * @author ilham fajri
 */
@WebServlet("/transaction")
public class TransactionServlet extends HttpServlet {

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
        String id_user = request.getParameter("id_user");
        String id_product = request.getParameter("id_product");
        String size = request.getParameter("size");
        String Sqty = request.getParameter("qty");
        Integer qty = Integer.parseInt(Sqty);

        String role = null;
        if (request.getParameter("role") != null) {
            role = request.getParameter("role");
        } else {
            role = "user";
        }

        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = null;
        Connection con = null;
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, username, password);
            PreparedStatement pst = con.prepareStatement("select * from tbl_product where id_product = ?");
            pst.setString(1, id_product);

            rs = pst.executeQuery();

            if (rs.next()) {
                String id = rs.getString("id_product");
                String Sharga = rs.getString("harga");
                String Sstock_old = rs.getString("stock");
                Integer harga = Integer.parseInt(Sharga);
                Integer stock_old = Integer.parseInt(Sstock_old);
                Integer Stotal = qty * harga;
                Integer Sstock_new = stock_old - qty;
                String total = Integer.toString(Stotal);
                String stock_new = Integer.toString(Sstock_new);

                pst = con.prepareStatement("update tbl_product set stock = ? where id_product = ?");
                pst.setString(1, stock_new);
                pst.setString(2, id);
                pst.executeUpdate();
                String sql = "insert into tbl_transaksi (id_user, id_product, ukuran, qty, total) values ('" + id_user + "', '" + id_product + "','" + size + "'," + Sqty + ",'" + total + "')";
                st = con.createStatement();
                st.execute(sql);

//                pst = con.prepareStatement("insert into tbl_transaksi(id_user, id_product, ukuran, qty, total) values(?,?,?,?,?)");
//                pst.setString(1, id_user);
//                pst.setString(2, id_product);
//                pst.setString(3, size);
//                pst.setString(4, Sqty);
//                pst.setString(5, total);
            } else {
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");

    }

}
