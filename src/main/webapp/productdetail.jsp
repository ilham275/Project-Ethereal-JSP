<%-- 
    Document   : productdetail
    Created on : Jul 24, 2023, 5:39:05 PM
    Author     : ilham fajri
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Product Detail</title>
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
        <!-- Product section-->

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
                String id = (String) session.getAttribute("id");
                String query = "SELECT * FROM tbl_product where id_product = '" + id_product + "'";
                pstmt = con.prepareStatement(query);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name_product");
                    String price = rs.getString("harga");
                    String stock = rs.getString("stock");
                    String img = rs.getString("gambar");
                    String desc = rs.getString("description");

                    Double harga = Double.parseDouble(price);

                    DecimalFormat df = (DecimalFormat) DecimalFormat.getCurrencyInstance();
                    DecimalFormatSymbols dfs = new DecimalFormatSymbols();
                    dfs.setCurrencySymbol("");
                    dfs.setMonetaryDecimalSeparator(',');
                    dfs.setGroupingSeparator('.');
                    df.setDecimalFormatSymbols(dfs);
                    String hsl = "Rp. " + df.format(harga);

        %>

        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="images/<%=img%>" alt="..." /></div>
                    <div class="col-md-6">
                        <!--<div class="small mb-1">SKU: BST-498</div>-->
                        <h1 class="display-5 fw-bolder"><%=name%></h1>
                        <div class="fs-5 mb-5">
                            <!--<span class="text-decoration-line-through">$45.00</span>-->
                            <span><%=hsl%></span>
                        </div>
                        <p class="lead"><%=desc%></p>
                        <!--                        <form action="transaction" method="Post">
                                                    <label>Quantity</label><br>
                                                    <input type="text" name="id_user" id="id_user" value="<%=id%>">
                                                    <input type="text" name="id_product" id="id_product" value="<%=id_product%>">
                                                    <div class="form-floating mb-3">
                                                        <input type="number" name="qty" id="qty" class="form-control">
                                                    </div>
                                                    <label>Size</label>
                                                    <div class="form-floating mb-3">
                                                        <select class="form-control select2" style="width: 100%;" name="size" id="size">
                                                            <option disabled="disabled">Size</option>
                                                            <option value="S">S</option>
                                                            <option value="M">M</option>
                                                            <option value="L">L</option>
                                                            <option value="XL">XL</option>
                        
                                                        </select>
                                                    </div>
                        
                        
                        <%
                            if (session.getAttribute("id") == null) {
//                                    response.sendRedirect("login.jsp");

                        %>
                        <div class="d-grid">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                Submit
                            </button>
                        </div>
                        <%                                            } else {

                        %>
                        <div class="d-grid">

                            <button type="button" class="btn btn-primary">Submit</button>
                        </div>
                        <%                                }
                        %>
                        <hr class="my-4">

                    </form>-->

                        <form action="transaction" method="Post">
                            <label>Quantity</label><br>
                            <input type="hidden" name="id_user" id="id_user" value="<%=id%>">
                            <input type="hidden" name="id_product" id="id_product" value="<%=id_product%>">
                            <div class="form-floating mb-3">
                                <input type="number" name="qty" id="qty" class="form-control">
                            </div>
                            <label>Size</label>
                            <div class="form-floating mb-3">
                                <select class="form-control select2" style="width: 100%;" name="size" id="size">
                                    <option disabled="disabled">Size</option>
                                    <option value="S">S</option>
                                    <option value="M">M</option>
                                    <option value="L">L</option>
                                    <option value="XL">XL</option>

                                </select>
                            </div>



                            <div class="d-grid">
                                <%
                                    if (session.getAttribute("id") != null) {
            //                                    response.sendRedirect("login.jsp");

                                %>
                                <button class="btn btn-primary btn-login text-uppercase fw-bold" type="submit">Submit</button>
                                <%  } else {

                                %>
                                <div class="d-grid">

                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                        Submit
                                    </button>
                                </div>
                                <%                                }
                                %>

                            </div>
                            <hr class="my-4">

                        </form>

                    </div>
                </div>
            </div>
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Message</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Complete your data before do your transaction.
                            <br>
                            Your will Redirect To page login!!
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a type="button" href="login.jsp" class="btn btn-primary">Accept</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Related items section-->
        <section class="py-5 bg-light">

            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Related products</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="images/<%=img%>" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    <!-- Product price-->
                                    $40.00 - $80.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Special Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Payment</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    $40.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
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

