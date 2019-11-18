<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
  <title>장바구니</title>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
  integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
  crossorigin="anonymous"></script>
  <link rel='stylesheet' href='/css/common/bootstrap.min.css'>
  
<!--   <link rel='stylesheet' href='/node_modules/bootstrap/dist/css/bootstrap.min.css'> -->
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

  <style>
  
  #productBody {
      width: 1100px;
      padding-top: 10px;
      padding-bottom: 10px;
      margin: auto auto;
    }

.input-number {
    float: none;
    width: 50px;
    border: 1px solid #DBE5E7;
    border-radius: 2px;
    margin-bottom: 0px;
    padding: 5px;
}

  </style>

</head>

<body onload="check_all()">

    <jsp:include page="../header.jsp"/>

  <div id='productBody'>

    <div style="margin-bottom: 5px;">
    <button type='button' class="btn btn-secondary btn-sm" onclick='check_all();'>모두 선택</button>
    <button type='button' class="btn btn-secondary btn-sm" onclick='uncheck_all();'>모두 해제</button>
  </div>

    <table class='table table-hover'>
      <tr style="text-align: center;">
        <th style="width: 80px">선택</th>
        <th style="width: 130px">상품사진</th>
        <th>상품/옵션정보</th>
        <th style="width: 80px">수량</th>
        <th>상품금액</th>
        <th style="width: 80px">옵션가</th>
        <th>총액</th>
        <th style="width: 100px">배송비</th>
        <th style="width: 50px">주문</th>
    
      </tr>
      <c:forEach items="${carts}" var="cart">
        <tr style="text-align: center;">
          <td>
            <form method="post" action="cheoption">
              <input class="myChkbox" type="checkbox" name="chkbox" value="${cart.cartNo}">
            </form>
          </td>
          <td>
            <c:forEach items="${cart.files}" var="file" end="0">
              <img src='/upload/product/${file.filePath}' style="width: 100px; height: 100px; object-fit: cover">
            </c:forEach>
          </td>
          <td style="text-align: left">
            <c:forEach items="${cart.products}" var="product">
              ${product.title}<br>
            </c:forEach>
              <hr>
                <c:forEach items="${cart.options}" var="productOption">
                  ${productOption.title} ( +<fmt:formatNumber value="${productOption.price}" pattern="#,###"/>원 )<br>
                </c:forEach>
            </td>
          <td>
            <form action="update" method="POST">
            <div class="input-group input-number-group">
              <input class="input-number" name="quantity" type="number" style="text-align:center; width: 80px; margin-bottom: 5px;" value="${cart.quantity}" min="0" max="1000">
              <input type="hidden" name="cartNo" value="${cart.cartNo}">
              <button class="btn btn-secondary btn-sm" style="width:80px">변경</button>
            </div>
            </form>
          </td>
          <c:forEach items="${cart.products}" var="product">
              <c:forEach items="${cart.options}" var="productOption">
            <td>
              <span style="text-decoration:line-through"><fmt:formatNumber value="${product.price * cart.quantity}" pattern="#,###"/>원<br></span>
              <fmt:formatNumber value="${product.price * ((100-product.discount)/100) * cart.quantity}" pattern="#,###"/>원
            </td>
          </c:forEach>
          </c:forEach>
          <td>
            <c:forEach items="${cart.options}" var="option">
              <fmt:formatNumber value="${option.price * cart.quantity}" pattern="#,###"/>원
            </c:forEach>
          </td>
            <c:forEach items="${cart.products}" var="product">
            <c:forEach items="${cart.options}" var="productOption">
            <td>
<%--                     <a style="text-decoration:line-through"><fmt:formatNumber value="${(product.price + productOption.price) * cart.quantity}" pattern="#,###"/>원</a><br> --%>
                    <a style="color:red"><fmt:formatNumber value="${((product.price * (100 - product.discount) / 100) + productOption.price) * cart.quantity}" pattern="#,###"/>원</a><br>
                    <input type="hidden" name="chkprice" value="${(product.price + productOption.price) * (100 - product.discount) / 100 * cart.quantity}">
                  </td>
              </c:forEach>
              </c:forEach>

              <td>
                <!-- <span class="tempShip" id="tempShipCheckPrice">[기본배송]<br>조건</span> -->
                <span data-toggle="tooltip" data-placement="top" title="주문금액이 50,000원 미만시 배송비 2,500원이 청구됩니다.">[기본배송]<br>조건</span>
              </td>

          <td>
            <button type="button" class="btn btn-secondary btn-sm" style="margin-bottom: 5px;">주문</button><br>
            <button type="button" class="btn btn-danger btn-sm" onclick="location.href='delete?no=${cart.cartNo}' ">삭제</button>
          </td>
        </tr>
      </c:forEach>
    </table>

    <hr class="my-4" style="margin-top: 0px;">
    
    <div style="text-align: right;">
        <a1>상품금액 </a1><a id="sumCheckPrice">0</a>
        <a1>원 + 배송비 </a1><a id="shipCheckPrice">0</a>
        <a1>원 = 합계금액 </a1><a id="totalCheckPrice" style="color: red">0</a>
        <a1>원</a1>
      </div>
      

    <hr class="my-4">

<div style="text-align: right">
<button type="button" class="btn bueno-btn" onclick='check_Del();'>선택삭제</button>
<button type="button" id="selectOrderBtn" class="btn bueno-btn" onclick="check_Order()">선택구매</button>
<button type="button" id="allOrderBtn" class="btn bueno-btn" onclick="all_Order()">전체구매</button>
</div>

</div>

  <jsp:include page="../footer.jsp"/>

  <script>
      var myCheckBoxes = document.getElementsByClassName('myChkbox');
      
      for (var i = 0; i < myCheckBoxes.length; i++) {
        myCheckBoxes[i].addEventListener('change', function () {
          reprice()
        });
      }
    </script>
    
    <script>
      myCheckBoxes = document.getElementsByClassName('myChkbox');
      function check_all() {
        for (i = 0; i < myCheckBoxes.length; i++) {
          myCheckBoxes[i].checked = true;
          reprice()
        }
      }
      function uncheck_all() {
        for (i = 0; i < myCheckBoxes.length; i++) {
          myCheckBoxes[i].checked = false;
          reprice()
        }
      }
    </script>
    
    <script>
      function reprice() {
        // 중복코드 제거용
        var myCheckPrice = document.getElementsByName('chkprice');
        var myCheckQuantity = document.getElementsByName('quantity');
        var checkPrice = 0;
        for (j = 0; j < myCheckBoxes.length; j++) {
          if (myCheckBoxes[j].checked) {
            checkPrice += parseInt(myCheckPrice[j].value);
          }
        }
        sumCheckPrice.innerHTML = Number(checkPrice).toLocaleString('en'); // 상품합계
        shipCheckPrice.innerHTML = Number(checkPrice >= 50000 || checkPrice == 0 ? 0 : 2500).toLocaleString('en'); // 배송비
        totalCheckPrice.innerHTML = Number(checkPrice + parseInt(checkPrice >= 50000 || checkPrice == 0 ? 0 : 2500)).toLocaleString('en'); // 합계
      }
    </script>

  <script>
  // 상품 전체구매
    function all_Order() {
      var allOrderBtn = $('.myChkbox');
        for (i = 0; i < allOrderBtn.length; i++) {
          myCheckBoxes[i].checked = true;
        }
      check_Order();
    }
  </script> 
  
  
  
  
<script>
  // 선택 상품삭제
    function check_Del() {
      var chkbox = "";
      $("input[name='chkbox']:checked").each(function () {
        chkbox = chkbox + $(this).val() + ",";
      });
      chkbox = chkbox.substring(0, chkbox.lastIndexOf(",")); //맨끝 콤마 지우기
  
      if (chkbox == '') {
        alert("삭제할 상품을 선택하세요.");
        return false;
      }
      console.log("### chkbox => {}" + chkbox);
  
      if (confirm("삭제 하시겠습니까?")) {
  
        location.href = "chkdelete?chkbox=" + chkbox;
      }
    }
  </script>

<script>
  // 선택 상품구매
    function check_Order() {
      var chkbox = "";
      $("input[name='chkbox']:checked").each(function () {
        chkbox = chkbox + $(this).val() + ",";
      });
      chkbox = chkbox.substring(0, chkbox.lastIndexOf(",")); //맨끝 콤마 지우기
  
      if (chkbox == '') {
        alert("구매할 상품을 선택하세요.");
        return false;
      }
      console.log("### chkbox => {}" + chkbox);
  
      if (confirm("구매 하시겠습니까?")) {
  
        // 상품구매 href?
        location.href = "chkoption?chkbox=" + chkbox;
      }
    }
  </script>

  <script>
    // 선택 상품금액
    function check_Price(){
      var myCheckBoxes = document.getElementsByClassName('myChkbox');
      for (var i = 0; i < myCheckBoxes.length; i++){
        if (myCheckBoxes[i].checked) {
          alert(parseInt(myCheckBoxes[i].value)); //

        }
      }
    }
  </script>

  <script>
    if($('#chkbox').checked) {
      $('#chkbox').val('true');
    } else {
      $('#chkbox').val()
    }
  </script>

  <script>
  
  </script>








</body>

</html>