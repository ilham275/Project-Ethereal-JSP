<%-- 
    Document   : index
    Created on : Jul 24, 2023, 5:32:56 PM
    Author     : ilham fajri
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Ethereal</title>
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
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Ethereal</h1>
                    <p class="lead fw-normal text-white-50 mb-0">Mens and women</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
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
                                            String id_user = request.getParameter("id");

//                                    response.sendRedirect("login.jsp");

                                            Class.forName(driver);
                                            con = DriverManager.getConnection(url, username, password);

                                            String query = "SELECT TOP 8 * FROM tbl_product";
                                            pstmt = con.prepareStatement(query);
                                            rs = pstmt.executeQuery();

                                            while (rs.next()) {
                                                String id = rs.getString("id_product");
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
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="images/<%=img%>" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"><%=name%></h5>
                                    <!-- Product price-->
                                    <%=hsl%>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="productdetail.jsp?id_product=<%=id%>">View options</a></div>
                            </div>
                        </div>
                    </div>
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
