<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file = "../common/isLogin.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>MemberTable</title>

  <!-- Custom fonts for this template-->
  <link href="../common/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="../common/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../common/css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">
	
	<%@ include file="../common/navbar.jsp" %>

  <div id="wrapper">

	<%@ include file="../common/sidebar.jsp" %>


    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Tables</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Data Table Example</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>멤버등급</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>비밀번호</th>
                    <th>전화번호</th>
                    <th>휴대폰번호</th>
                    <th>이메일</th>
                    <th>주소</th>
                    <th>가입일</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>memberlv</th>
                    <th>name</th>
                    <th>id</th>
                    <th>pass</th>
                    <th>phone</th>
                    <th>cellphone</th>
                    <th>email</th>
                    <th>address</th>
                    <th>regdate</th>
                  </tr>
                </tfoot>
                <tbody>
 				<c:choose>
					<c:when test="${empty lists }">
						<tr>
							<th colspan="9" align="center" height="100">
								등록된 게시물이 없습니다.
							</th>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${lists }" var="row" varStatus="loop">
							<tr>
								<th>${row.memberlv }</th>
								<th>${row.name }</th>
								<th>${row.id }</th>
								<th>${row.pass }</th>
								<th>${row.phone }</th>
								<th>${row.cellphone }</th>
								<th>${row.email }</th>
								<th>${row.address }</th>
								<th>${row.regdate }</th>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>

                </tbody>
              </table>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

        <p class="small text-center text-muted my-5">
          <em>More table examples coming soon...</em>
        </p>

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © Your Website 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="../common/vendor/jquery/jquery.min.js"></script>
  <script src="../common/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../common/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="../common/vendor/datatables/jquery.dataTables.js"></script>
  <script src="../common/vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../common/js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="../common/js/demo/datatables-demo.js"></script>

</body>

</html>
