<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>펫 보기</title>
<link rel='stylesheet'
	href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'
	integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T'
	crossorigin='anonymous'>
<script src="/node_modules/jquery/dist/jquery.min.js"></script>
<style type="text/css">
	.pet-info { 
	  margin: 0 auto; 
	  width: 1100px !important; 
	 } 
	.pInfo {
	  border-bottom: 2px solid #404040;
	  padding-bottom: 5px;
	}
</style>
</head>
<body>

	<div id='content' class="container pet-info px-0">
	 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 pInfo">
		<h3>My Pet Information</h3>
	 </div>
		<button type="button" class="btn btn-primary"
			style="background-color: #b0c364; border-color: #b0c364;"
			onclick="location.href='/app/pet/form?no=${member.memberNo}'">펫 등록</button>
		<form action='/app/pet/updateForm' method='post'>
			<c:forEach items="${pets}" var="pet">
				<div class="card mb-3" style="max-width: 540px; margin: 10px 0;"
					id="row_div_${pet.petNo}">
					<div class="row">
						<div class="col-md-4">
							<img src="/upload/pet/${pet.filePath}" class="card-img" alt="...">
						</div>
						<div class="col-md-8">
							<div class="card-body" style="margin-left:10px;">
								<h5 class="card-title age">
									<b>${pet.name}</b> (${pet.age}세,
									<c:if test="${pet.gender eq 0}">수컷</c:if>
									<c:if test="${pet.gender eq 1}">암컷</c:if>
									)
								</h5>
								<p class="card-text">
									<div>품종 : ${pet.breed}</div>
                  <div>등록번호 : ${pet.registerNo}</div>
									<div>등록일 : ${pet.createdDate}</div>
								</p>
								<p class="card-text">
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-primary my-btn"
										onclick="window.location.href = '/app/pet/updateForm?no=' + ${pet.petNo}"
										style="background-color: #b0c364; border-color: #b0c364;">수정</button>

									<button type="button" id="${pet.petNo}"
										class="btn btn-primary deletePet"
										style="background-color: #b0c364; border-color: #b0c364;">동물삭제</button>
								</p>

							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</form>
	</div>

	<script>
		$(document).on('click', '.deletePet', function() {

			var allData = {"no" : $(this).attr("id")};
			$("#row_div_" + $(this).attr("id")).remove();
			// $("#row_div_"+allData.no).remove();
			$.ajax({
				url : "/app/json/pet/delete",
				type : "GET",
				dataType : "json",
				data : allData,
				success : function(result) {
				}
			});
		});
	</script>
</body>
</html>
