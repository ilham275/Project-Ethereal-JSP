/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminServlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ilham fajri
 */
@WebServlet("/admin_edit_product")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditProductServlet extends HttpServlet {

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
        String id_product = request.getParameter("id_product");
        String uname = request.getParameter("name");
        String jenis = request.getParameter("price");
        Part imagePart = request.getPart("img");
        String Sprice = request.getParameter("stock");
        RequestDispatcher dispatcher = null;
        InputStream imageStream = imagePart.getInputStream();
        String imageDb = imagePart.getSubmittedFileName();
        Connection con = null;
        PreparedStatement pstmt = null;
        
//        //Testing Data Masuk
//        PrintWriter out = response.getWriter();
//        out.print(uname);
//        out.print(jenis);
//        out.print(imagePart);
//        out.print(Sprice);
//        
//    }

        String uploadDir = getServletContext().getRealPath("images");
        String fileName = imagePart.getSubmittedFileName();
        String destinationPath = uploadDir + File.separator + fileName;

        Path destination = new File(destinationPath).toPath();

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, username, password);

            // Membuat prepared statement
            PreparedStatement pst = con.prepareStatement("update tbl_product set name_product = ?, harga = ?, gambar = ?, stock = ? where id_product = ?");

            // Mengatur nilai parameter pada prepared statement
            pst.setString(1, uname);
            pst.setString(2, jenis);
            pst.setString(3, imageDb);
            pst.setString(4, Sprice);
            pst.setString(5, id_product);
            pst.executeUpdate();
             Files.copy(imageStream, destination);
            System.out.println("File berhasil disalin ke direktori tujuan.");

        } catch (Exception e) {
            System.out.println("Gagal menyalin file: " + e.getMessage());

        }
        
        
        System.out.println("File gambar: " + destinationPath);
        dispatcher = request.getRequestDispatcher("adminallproduct.jsp");
        dispatcher.forward(request, response);
    }
}
