<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
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
                        Data Product
                        <small>Update, Delete</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                        <li class="active">Here</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <!-- Your Page Content Here -->

                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Data Table With Full Features</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name Product</th>
                                        <th>Size</th>
                                        <th>Name User</th>
                                        <th>Qty</th>
                                        <th>total</th>
                                    </tr>
                                </thead>
                                <tbody>
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

                                            String query = "select * from tbl_transaksi tr join tbl_product tp on tr.id_product = tp.id_product join tbl_user tu on tr.id_user = tu.id";
                                            pstmt = con.prepareStatement(query);
                                            rs = pstmt.executeQuery();

                                            while (rs.next()) {
                                                String id = rs.getString("id_transaksi");
                                                String name_pr = rs.getString("name_product");
                                                String size = rs.getString("ukuran");
                                                String userna = rs.getString("username");
                                                String role = rs.getString("qty");
                                                String total = rs.getString("total");

                                                Double harga = Double.parseDouble(total);

                                                DecimalFormat df = (DecimalFormat) DecimalFormat.getCurrencyInstance();
                                                DecimalFormatSymbols dfs = new DecimalFormatSymbols();
                                                dfs.setCurrencySymbol("");
                                                dfs.setMonetaryDecimalSeparator(',');
                                                dfs.setGroupingSeparator('.');
                                                df.setDecimalFormatSymbols(dfs);
                                                String hsl = "Rp. " + df.format(harga);


                                    %>
                                    <tr>
                                        <td><%=id%></td>
                                        <td><%=name_pr%></td>
                                        <td><%=size%></td>
                                        <td><%=userna%></td>
                                        <td><%=role%></td>
                                        <td><%=hsl%></td>
                                    </tr>

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


                                </tbody>
                                <!--                <tfoot>
                                                <tr>
                                                  <th>Rendering engine</th>
                                                  <th>Browser</th>
                                                  <th>Platform(s)</th>
                                                  <th>Engine version</th>
                                                  <th>CSS grade</th>
                                                </tr>
                                                </tfoot>-->
                            </table>
                        </div>
                        <!-- /.box-body -->
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