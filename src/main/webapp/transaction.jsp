
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%-- 
    Document   : productdetail
    Created on : Jul 24, 2023, 5:39:05 PM
    Author     : ilham fajri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Transaction</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="navbaruser.jsp"/>
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">History Transaction</h2>
                <div class="row gx-12 gx-lg-12 row-cols-12 row-cols-md-12 row-cols-xl-12 justify-content-center">
                    <div class="box-body">
                        <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name Product</th>
                                    <th>Total Price</th>
                                    <th>Quantity</th>
                                    <th>Image</th>
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
                                        String id_user = (String) session.getAttribute("id");
                                        String query = "SELECT * FROM tbl_transaksi tr join tbl_product tp on tr.id_product = tp.id_product where id_user ='" + id_user + "'";
                                        pstmt = con.prepareStatement(query);
                                        rs = pstmt.executeQuery();

                                        while (rs.next()) {
                                            String id = rs.getString("id_product");
                                            String name = rs.getString("name_product");
                                            String price = rs.getString("total");
                                            String stock = rs.getString("qty");
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

                                <tr>
                                    <td><%=id%></td>
                                    <td><%=name%></td>
                                    <td><%=hsl%></td>
                                    <td><%=stock%></td>
                                    <td>
                            <center>
                                <img src="images/<%=img%>" width="200" height="120"/>
                                <br>
                                <%=img%>
                            </center>
                            </td>
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
            </div>


        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>

