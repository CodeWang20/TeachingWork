<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="js/rbUtils.js"></script>
<c:if test="${level == 'admin' || level == 'suAdmin'}">
    <input type="hidden" id="level" value="admin">
</c:if>
<div region="north" border="false" style="width: 100%;height: 110px;background-color:#F4F4F4;">
    <form action="" id="searchTeacher">
        <table class="tableForm" style="width: 500px;height: 110px;">
            <tr>
                <th>教师编号</th>
                <td><input type="text" name="tid"></td>
                <th>教师姓名</th>
                <td><input type="text" name="tname"></td>
            </tr>
            <tr>
                <th>所在院系</th>
                <td><input type="text" name="tpart"></td>
                <td colspan="2">
                    <a href="javascript:;" class="easyui-linkbutton" onclick="searchTeacher();">查询</a>
                    <a href="javascript:;" class="easyui-linkbutton" onclick="cleanSearchTeacher();">清空</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'center,border:false,fit:true"style="display: block">
    <table id="teacher_datagrid" style="display: block"></table>
</div>
<script type="text/javascript" charset="UTF-8">
    var teacher_datagrid;
    if ($('#level').val() == 'admin' || $('#level').val() == 'suAdmin'){
        $(function () {
            var editRow = undefined;
            teacher_datagrid = $('#teacher_datagrid').datagrid({
                url: path + '/userAction?action=selectTeacher',
                title: '教师列表',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                fitColumns: true,
                nowrap: false,
                border: true ,
                idField: 'aid',
                columns: [[
                    {
                        title: '编号',
                        field: 'tid',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '姓名',
                        field: 'tname',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '性别',
                        field: 'tsex',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }, {
                        title: '权限',
                        field: 'tpms',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '院系',
                        field: 'tpart',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '密码',
                        field: 'tpwd',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }
                ]],
                toolbar:[{
                    text:'增加',
                    iconCls:'icon-add',
                    handler:function () {
                        if (editRow != undefined){
                            teacher_datagrid.datagrid('endEdit', editRow);
                        }
                        if (editRow == undefined){
                            teacher_datagrid.datagrid('insertRow',{
                                index: 0,
                                row:{
                                }
                            });
                            teacher_datagrid.datagrid('beginEdit', 0);
                            editRow = 0;
                        }
                    }
                },{
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function () {
                        var rows = teacher_datagrid.datagrid('getSelections');
                        if (rows.length>0){
                            $.messager.confirm('请确认', '您确定要删除当前所有选择的记录吗！', function (b) {
                                if (b){
                                    var ids = [];
                                    for (var i = 0; i < rows.length; i++) {
                                        ids.push(rows[i].tid);
                                    }
                                    $.ajax({
                                        url: 'teacherAction?action=del',
                                        data: {ids:ids.join(',')},
                                        dataType: 'json',
                                        success:function (r) {
                                            if(r && r.success){
                                                $.messager.show({
                                                    title:'提示',
                                                    msg: r.msg
                                                });
                                                teacher_datagrid.datagrid('load');
                                                teacher_datagrid.datagrid('unselectAll');
                                            }else {
                                                $.messager.alert('删除失败!',r.msg,'error');
                                            }
                                        }
                                    });
                                }
                            });
                        }else {
                            $.messager.alert('提示','请选择要删除的记录！', 'error');
                        }
                    }
                },
                    {
                        text:'修改',
                        iconCls:'icon-edit',
                        handler:function () {
                            var rows = teacher_datagrid.datagrid('getSelections');
                            if (rows.length == 1){
                                if (editRow != undefined){
                                    teacher_datagrid.datagrid('endEdit', editRow);
                                }
                                if (editRow == undefined){
                                    var index = teacher_datagrid.datagrid('getRowIndex', rows[0]);
                                    teacher_datagrid.datagrid('beginEdit', index);
                                    editRow = index;
                                    teacher_datagrid.datagrid('unselectAll');
                                }
                            }
                        }
                    },
                    {
                        text:'保存',
                        iconCls:'icon-save',
                        handler:function () {
                            teacher_datagrid.datagrid('endEdit', editRow);
                            editRow = undefined;
                        }
                    },{
                        text:'取消编辑',
                        iconCls:'icon-redo',
                        handler:function () {
                            teacher_datagrid.datagrid('rejectChanges');
                            teacher_datagrid.datagrid('unselectAll');
                            teacher_datagrid.datagrid('load');
                        }
                    }],
                onAfterEdit:function (rowIndex, rowData, changes) {
                    var inserted = teacher_datagrid.datagrid('getChanges', 'inserted');
                    var updated = teacher_datagrid.datagrid('getChanges', 'updated');
                    var url = '';
                    if (inserted.length>0){
                        url = 'teacherAction?action=add';
                    }
                    if (updated.length>0){
                        url = 'teacherAction?action=edit';
                    }
                    $.ajax({
                        url:url,
                        data:rowData,
                        dataType:'json',
                        success:function (r) {
                            if (r && r.success){
                                teacher_datagrid.datagrid('acceptChanges');
                                $.messager.show({
                                    msg:r.msg,
                                    title:'保存成功!'
                                });
                            }else {
                                teacher_datagrid.datagrid('rejectChanges');
                                $.messager.alert('保存失败!',r.msg,'error');
                            }
                            editRow = undefined;
                            teacher_datagrid.datagrid('unselectAll');
                            teacher_datagrid.datagrid('load');
                        }
                    })
                },
                onDblClickRow:function (rowIndex, rowData) {
                    if (editRow != undefined){
                        teacher_datagrid.datagrid('endEdit', editRow);
                    }
                    if (editRow == undefined){
                        teacher_datagrid.datagrid('beginEdit', rowIndex);
                        editRow = rowIndex;
                    }
                }
            });
        });
    };

    searchTeacher = function () {
        teacher_datagrid.datagrid('load',{
            tid: $('#searchTeacher').find('[name=tid]').val(),
            tname: $('#searchTeacher').find('[name=tname]').val(),
            tpart: $('#searchTeacher').find('[name=tpart]').val()
        });
    };

    cleanSearchTeacher = function () {
        teacher_datagrid.datagrid('load', {});
        $('#searchTeacher').find('input').val('');
    };


</script>
