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
                        <form action="admin_add_product" method="Post" enctype="multipart/form-data">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Name Product</label>
                                    <input type="text"  class="form-control" name="name" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Price Product</label>
                                    <input type="number" class="form-control" name="price" id="price">
                                </div>
                                   <div class="form-group">
                                    <label for="exampleInputEmail1">Stock Product</label>
                                    <input type="number" class="form-control" name="stock" id="stock">
                                </div> 
                                   <div class="form-group">
                                    <label for="exampleInputEmail1">Description</label>
                                    <textarea class="form-control" id="desc" name="desc" rows="3"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputFile">Image</label>
                                    <input type="file" id="exampleInputFile" name="img" id="img">

                                </div>
                            </div>
                            <!-- /.box-body -->

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
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
