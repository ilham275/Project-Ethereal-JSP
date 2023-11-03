<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <%@include file="/WEB-INF/views/common/include/meta.jsp"%>
        <title>Admin</title>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <!-- .wrapper -->
        <div class="wrapper">

            <%@include file="/WEB-INF/views/common/include/header.jsp"%>
            <%@include file="/WEB-INF/views/common/include/aside.jsp"%>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Add Data Product
                        <!--<small>Update, Delete</small>-->
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                        <li class="active">Here</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <!-- Your Page Content Here -->
                    <div class="box box-primary">
                        <div class="box-header with-border">
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->

                        <%
                            Connection con = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            try {
                                String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                                String url = "jdbc:sqlserver://localhost\\hm\\SQLEXPRESS:1433;databaseName=ethereal;encrypt=true;trustServerCertificate=true;";
                                String username = "admin";
                                String password = "admin";
                                Statement st;

                                Class.forName(driver);
                                con = DriverManager.getConnection(url, username, password);
                                String id_product = request.getParameter("id_product");

                                String query = "SELECT * FROM tbl_product where id_product = '" + id_product + "'";
                                pstmt = con.prepareStatement(query);
                                rs = pstmt.executeQuery();

                                if (rs.next()) {
                                    String name = rs.getString("name_product");
                                    String price = rs.getString("harga");
                                    String stock = rs.getString("stock");
                                    String img = rs.getString("gambar");

                                    Double harga = Double.parseDouble(price);

                                    DecimalFormat df = (DecimalFormat) DecimalFormat.getCurrencyInstance();
                                    DecimalFormatSymbols dfs = new DecimalFormatSymbols();
                                    dfs.setCurrencySymbol("");
                                    dfs.setMonetaryDecimalSeparator(',');
                                    dfs.setGroupingSeparator('.');
                                    df.setDecimalFormatSymbols(dfs);
                                    String hsl = "Rp. " + df.format(harga);

                        %>
                        <form action="admin_edit_product" method="Post" enctype="multipart/form-data">
                            <div class="box-body">

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Name Product</label>
                                    <input type="text"  class="form-control" name="name" id="name" value="<%=name%>">
                                    <input type="hidden"  class="form-control" name="id_product" id="id_product" value="<%=id_product%>">

                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Price Product</label>
                                    <input type="number" class="form-control" name="price" id="price" value="<%=price%>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Stock Product</label>
                                    <input type="number" class="form-control" name="stock" id="stock" value="<%=stock%>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputFile">Image</label>
                                    <input type="file" id="exampleInputFile" name="img" id="img" value="<%=img%>">

                                </div>
                            </div>
                            <!-- /.box-body -->

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>

                        <%                          }
                            } catch (ClassNotFoundException | SQLException e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (pstmt != null) {
                                        pstmt.close();
                                    }
                                    if (con != null) {
                                        con.close();
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </div>
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

            <%@include file="/WEB-INF/views/common/include/footer.jsp"%>
            <%@include file="/WEB-INF/views/common/include/control-sidebar.jsp"%>

        </div>
        <!-- /.wrapper -->

        <%@include file="/WEB-INF/views/common/include/script.jsp"%>

    </body>
</html>
