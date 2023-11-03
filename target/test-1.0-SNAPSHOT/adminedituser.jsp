<%@page import="java.sql.SQLException"%>
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
                        Update Data User
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

                                String query = "SELECT * FROM tbl_user where id = '" + id_product + "'";
                                pstmt = con.prepareStatement(query);
                                rs = pstmt.executeQuery();

                                if (rs.next()) {
                                    String name = rs.getString("username");
                                    String pass = rs.getString("password");


                        %>
                        <form action="edit_user" method="Post">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Username</label>
                                    <input type="text"  class="form-control" name="username" id="username" value="<%=name%>">
                                    <input type="hidden"  class="form-control" name="id_user" id="id_user" value="<%=id_product%>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Password</label>
                                    <input type="text" class="form-control" name="password" id="password" value="<%=pass%>">
                                </div>

                                <div class="form-group">
                                    <label>Role</label>
                                    <select class="form-control select2" style="width: 100%;" name="role" id="role">
                                        <option value="user">User</option>
                                        <option value="admin">Admin</option>
                                        <option disabled="disabled">Kasir (disabled)</option>

                                    </select>
                                </div>
                            </div>
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
