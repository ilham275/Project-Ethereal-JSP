/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ilham fajri
 */
@WebServlet("/admin_delete_product")
public class DeleteProductServlet extends HttpServlet {

    String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String url = "jdbc:sqlserver://localhost\\hm\\SQLEXPRESS:1433;databaseName=ethereal;encrypt=true;trustServerCertificate=true;";
    String username = "admin";
    String password = "admin";
    Statement st;
    ResultSet rs;
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("id_product");

//        PrintWriter out = response.getWriter();
//        out.print(name);
//        out.print(pass);
//        out.print(productId);
        // Kode untuk memperbarui data produk di database berdasarkan ID
        try {

            Class.forName(driver);
            Connection con = DriverManager.getConnection(url, username, password);

            String query = "delete from tbl_product WHERE id_product = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, productId);
            pstmt.executeUpdate();

            pstmt.close();
            con.close();

            // Redirect ke halaman daftar produk setelah pembaruan berhasil
            response.sendRedirect("adminallproduct.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Mengirimkan pesan kesalahan ke halaman yang sesuai
            request.setAttribute("error", "An error occurred while updating the product.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }
}
