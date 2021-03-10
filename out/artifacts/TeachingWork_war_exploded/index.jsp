<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.7.0/themes/default/easyui.css" type="text/css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.7.0/themes/icon.css" type="text/css"/>
  <link rel="stylesheet" href="style/style.css">
  <input type="hidden" id="path" value="${pageContext.request.contextPath}">
  <title>教师教学工作量管理系统</title>

  <script type="text/javascript">
      function refreshCode() {
        var vcode = document.getElementById("vcode");
        vcode.src = "${pageContext.request.contextPath}/checkCodeServlet?time=" + new Date().getTime();
      }
  </script>
</head>
<body class="easyui-layout" fit="true">
<%--顶部页头--%>
<div data-options="region:'north',split:false,collapsible:false,border:false"  style="height:80px;">
  <div class="header">
    <div class="header-title">
      <span>教师教学工作量 <small>管理系统</small></span>
    </div>
    <div class="userInfo">
      <c:if test="${level == null}">
        <a class="login-btn" href="javascript:void(0)" onclick="$('#loginDialog').dialog({closed: false,})">登陆</a>
      </c:if>
      <c:if test="${level == 'admin' || level == 'suAdmin'}">
        <span class="inf-det">${user.aname}</span>
        <a class="inf-btn" href="${pageContext.request.contextPath}/user.do?action=logout">注销</a>
      </c:if>
      <c:if test="${level == 'teacher'}">
        <span class="inf-det">${user.tname}</span>
        <a class="inf-btn" href="${pageContext.request.contextPath}/user.do?action=logout">注销</a>
      </c:if>
    </div>
  </div>
</div>
<%--  左侧导航  --%>
<div data-options="region:'west',title:'功能导航',split:false,collapsible:false" style="height:100%;width: 150px">
  <c:if test="${level == 'teacher'}">
    <ul id="teacher_nav_tree"></ul>
  </c:if>
  <c:if test="${level == 'admin'}">
    <ul id="admin_nav_tree"></ul>
  </c:if>
  <c:if test="${level == 'suAdmin'}">
    <ul id="suAdmin_nav_tree"></ul>
  </c:if>

</div>
<%--  中部布局  --%>
<div id="centerPage" data-options="region:'center',href:'center.jsp'" style="overflow:hidden;"></div>
<%--  右侧布局  --%>
<div data-options="region:'east',title:'在线列表',split:false,border:false" style="height:100%;width: 200px">
  <div class="easyui-calendar" style="width:200px;height:200px;"></div>
</div>
<%--登陆--%>
<div id="loginDialog" class="easyui-dialog" title="用户登录" closable=true modal=true closed=true style="width: 350px; height: 350px; display: none">
  <div class="filed">
    <form id="loginForm" action="${pageContext.request.contextPath}/user.do?action=login" method="post">
      <div>
        <label class="filed-label" for="username">用户名</label>
        <input class="easyui-textbox filed-input" type="text" id="username" name="username" required>
      </div>
      <div>
        <label class="filed-label" for="password">密码</label>
        <input class="easyui-passwordbox filed-input" id="password" name="password" iconWidth="28" required>
      </div>
      <div>
        <label class="filed-label" for="verifycode">验证码</label>
        <input type="text" name="verifycode" class="easyui-textbox filed-input" id="verifycode" style="width: 70px"/>
        <a href="javascript:refreshCode()"><img src="${pageContext.request.contextPath}/checkCodeServlet"id="vcode"/></a>
      </div>
      <div id="radio">
        <label class="radio-label"><input type="radio" name="level" value="teacher" checked>教师</label>
        <label class="radio-label"><input type="radio" name="level" value="admin">管理员</label>
      </div>
    </form>
  </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.7.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/rbUtils.js"></script>
<script type="text/javascript" src="js/index.js"></script>
</body>
</html>
