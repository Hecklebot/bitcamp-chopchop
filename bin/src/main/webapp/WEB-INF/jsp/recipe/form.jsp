<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/recipe/form.css">
<link rel="stylesheet" href="/node_modules/blueimp-file-upload/css/jquery.fileupload.css">
<style>
 img {
  border: none;
 }
 
 img.preview-cooking-image {
  height: 150px;
  object-fit: cover;
 }
 
 #image {
  height: 150px;
  object-fit: cover;
 }
 
 .my-label {
  display: inline-block;
  padding: .5em .75em;
  margin-left: 32px;
  color: #fff;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #b0c364;
  cursor: pointer;
  border: 1px solid #b0c364;
  border-radius: .25em;
  -webkit-transition: background-color 0.2s;
  transition: background-color 0.2s;
 }

</style>
<title>레시피 등록폼</title>
</head>
<body>

<div id="app">
  <div>
    <div class="wrapper">
      <div class="site-main">
          <div class="container">
            <div class="block-gird-item">
              <div>
                  <form name="frmRecipe" action='add' method='post' enctype='multipart/form-data'>
                  <input type="hidden" name="user_id" value="1">
                      <div class="toobar"><strong class="title pull-left">레시피 등록 </strong></div>
                      <div class="block-write">
                          <div class="block-content">
                              <div class="row form-group">
                                  <div class="col-xs-2"><label class="label">작성자</label></div>
<%--                                   <div class="col-xs-10"><input type="text" name="nickname" class="form-control" placeholder="${loginUser.nickname}" readonly></div> --%>
                                  <div class="col-xs-10"><label class="label">&nbsp${member.nickname}</label></div>
                              </div>
                              <div class="row form-group">
                                  <div class="col-xs-2"><label class="label">제목</label></div>
                                  <div class="col-xs-10"><input type="text" name="title" class="form-control" required placeholder="레시피 제목을 입력해주세요" value=""></div>
                              </div>
                              <div class="row form-group">
                                  <div class="col-xs-2"><label class="label">분류</label></div>
                                  <div class="col-xs-10">
                                  <select class="form-control" name="category" required>
                                          <option value="">분류</option>
                                          <option value="1">강아지</option>
                                          <option value="2">고양이</option>
                                          <option value="3">작은동물</option>
                                          <option value="4">기타</option>
                                  </select>
                                  </div>
                              </div>
                              <div class="row form-group">
                                  <div class="col-xs-2"><label class="label">태그</label></div>
                                  <div class="col-xs-10"><input type="text" name="tag" class="form-control" placeholder="1개 이상의 정보는 #로 구분해주세요." value=""></div>
                              </div>
                              <div class="row form-group">
                                  <div class="col-xs-2"><label class="label">기타정보</label></div>
                                  <div class="col-xs-10"><input type="text" name="otherInfo" class="form-control" placeholder="기타정보를 입력해주세요." value="" required></div>
                              </div>
                          </div>
                          <div class="block-title"><span class="title">재료 정보</span></div>
                          <div id="ingredient-block" class="block-content">
                          <!-- 재료 용량 들어가는 Div -->
                          </div>
                          
                          <div id="block_3" class="block-content">
                              <div class="row form-group">
                                  <div class="col-xs-12 text-right"><button class="btn btn-default btn-sm" type="button" onclick="addIngredient()">추가입력</button></div>
                              </div>
                          </div>
                          
                          <div class="step-list"> 
                              <div id="cookingDiv222">
                                  <div class="block-title _gray">
                                  <span class="title">STEP</span></div>
                                  
                                  <div id="cookingDiv" class="block-content">
                                  <!-- 순서 박스 들어갈 Div -->
                                  </div>
                              </div>
                          </div>
                          <!-- 순서추가버튼 -->
                          <div class="block-content">
                              <div class="row form-group">
                                  <div class="col-xs-12"><button class="btn btn-default btn-block" type="button" onclick="addCooking()">+ 순서 추가</button></div>
                              </div>
                          </div>
                          <!-- 순서추가버튼 -->
                          <div class="block-title _gray"><span class="title">요리 완성</span></div>
                          <div class="block-content">
                              <div>
                                  <!-- 썸네일사진추가아아아아아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ -->
                                  <div class="box-photo">
                                          <div class="photo">
                                              <div class="img">
                                              <img id="image"/></div> <!-- 미리보기사진  -->
                                              <div style='display: none;'><input type="file" id='my-thumbnail' name='filePath' class="my-thumbnail" style="width:100px;"/></div>
                                              <label id='my-label' class="my-label" for="my-thumbnail">+ 완성 사진 </label>
                                          </div>
                                          <div class="des"><textarea class="form-control" name="content" placeholder="간단한 설명 입력해주세요"></textarea></div>
                                      </div>
                              </div><br><br>
                              <div class="row form-group">
                                  <div class="col-xs-12 text-center"><button class="btn btn-default" style="height: auto;">등록</button></div>
                              </div>
                          </div>
                      </div>
                  </form>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/node_modules/handlebars/dist/handlebars.min.js"></script>
<script src="/node_modules/jquery/dist/jquery.min.js"></script>

<script id="t1" type="ingredientHtml">
<div class='group-flex my-ingredient'>
<div class='form-group'><label class='label'>재료 </label><input type='text' name='ingredientNames' class='form-control' value=''></div>
<div class='form-group'><label class='label'>용량 </label><input type='text' name='quantity' class='form-control' value=''></div>
<div class='form-group'><button class='btn btn-outline btn-sm' type='button' name='delIngredientBtn' onclick='delIngredient(event)'>삭제</button></div>
</div>
</script>

<script>
"use strict";
  function addIngredient() {
    var html = $('#t1').html();
    $('#ingredient-block').append(html);
  };

  function delIngredient(event) {
    $(event.target.parentNode.parentNode).remove();
  };
</script>
<script id="t2" type="cookingHtml"> 
<div class='row form-group my-cooking'>
  <div class='row form-group'>
    <input type='text' class='form-control' name='processNo' style='padding-left:13px; width:50px; margin-left:15px; font-size:12px;' value='' placeholder='순서' required>
  </div>
  <div class='box-photo'>
    <div class='photo'>
      <div class='img' style="margin-bottom:3px;">
       <img class='preview-cooking-image'>
      </div>
      <span class="fileinput-button my-label" style="margin-left:27px;">
        <i class="glyphicon glyphicon-plus"></i>
        <span>파일 선택</span>
        <input class='my-cooking-image' type='file' name='filePath2' value='' >
      </span>
      <button class='btn btn-outline btn-block btn-sm' style='boarder:none; margin-top:3px;' type='button' name='delCookingBtn' onclick='delCooking(event)'>순서 삭제</button>
    </div>
    <div class='des'><textarea class='form-control' name='cookingContent'></textarea></div>
  </div>
</div>
</script>

<script>
function addCooking() {
  var html = $('#t2').html();
  $('#cookingDiv').append(html);
};

function delCooking(event) {
  $(event.target.parentNode.parentNode.parentNode).remove();
};

function readURL(input) {
  var reader = new FileReader();
  reader.onload = function(e) {
    console.log("----------------------");
    $('#image').attr('src', e.target.result);
  }
  reader.readAsDataURL(input.files[0]);
};

$('.my-thumbnail').change(function() {
  readURL(this);
});

// cooking image 미리보기
function readURL2(input) {
  var reader2 = new FileReader();
  reader2.onload = function(e) {
    $(input.parentNode.parentNode).find('.preview-cooking-image').attr('src', e.target.result);
  }
  reader2.readAsDataURL(input.files[0]);
};

$(document).on('change', '.my-cooking-image', function() {
  readURL2(this);
});
</script>

</body>
</html>