<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${level == null}">
    <div id="nav_tabs" class="easyui-tabs" fit="true" border="false">
</c:if>
<c:if test="${level == 'teacher'}">
<div id="teacher_nav_tabs" class="easyui-tabs" fit="true" border="false">
</c:if>
<c:if test="${level == 'admin'}">
    <div id="admin_nav_tabs" class="easyui-tabs" fit="true" border="false">
</c:if>
<c:if test="${level == 'suAdmin'}">
    <div id="suAdmin_nav_tabs" class="easyui-tabs" fit="true" border="false">
</c:if>
    <div class="easyui-layout" title="起始页" fit="true" border="false">
        <c:if test="${level == null}">
            <div class="prompt" region="center" fit="true" border="false">
                欢迎使用教师教学工作量管理系统！<br><span style="color: red">请点击右上角进行登录！</span>
            </div>
        </c:if>
        <c:if test="${level == 'teacher'}">
            <div class="prompt" region="center" fit="true"  border="false" style="display: block" >
                欢迎使用教师教学工作量管理系统！<br><span>您的身份为<strong style="color: red">教师</strong>！</span>
            </div>

        </c:if>
        <c:if test="${level == 'admin'}">
            <div class="prompt" region="center" fit="true"  border="false" style="display: block" >
                欢迎使用教师教学工作量管理系统！<br><span>您的身份为<strong style="color: red">管理员</strong>！</span>
            </div>
        </c:if>
        <c:if test="${level == 'suAdmin'}">
            <div class="prompt" region="center" fit="true"  border="false" style="display: block">
                欢迎使用教师教学工作量管理系统！<br><span>您的身份为<strong style="color: red">超级管理员</strong>！</span>
            </div>
        </c:if>
    </div>
</div>
<script type="text/javascript" src="js/index.js"></script>

