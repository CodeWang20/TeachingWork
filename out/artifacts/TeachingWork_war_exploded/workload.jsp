<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="js/rbUtils.js"></script>
<c:if test="${level == 'teacher'}">
    <input type="hidden" id="tid" name="tid" value="${user.tid}">
    <input type="hidden" id="level" value="teacher">
</c:if>
<c:if test="${level == 'admin' || level == 'suAdmin'}">
    <input type="hidden" id="level" value="admin">
</c:if>
<div region="north" border="false" style="width: 100%;height: 110px;background-color:#F4F4F4;">
    <form action="" id="searchWorks">
        <table class="tableForm" style="width: 500px;height: 110px;">
            <tr>
                <c:if test="${level == 'admin' || level == 'suAdmin'}">
                <th>教师编号</th>
                <td><input type="text" name="tid"></td>
                </c:if>
                <th>课程名称</th>
                <td><input type="text" name="cname"></td>
            </tr>
            <tr>
                <th>课程性质</th>
                <td><input type="text" name="pro"></td>
                <td colspan="2">
                    <a href="javascript:;" class="easyui-linkbutton" onclick="searchWorkload();">查询</a>
                    <a href="javascript:;" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'center,border:false" fit="true" style="display: block">
    <table id="workload_datagrid" style="display: block"></table>
</div>
<script type="text/javascript" charset="UTF-8">
    console.info($('#level').val());
    if ($('#level').val() == null){
        location.href = path + "/index.jsp"
    }

    var workload_datagrid;
    if ($('#level').val() == 'teacher'){
        $(function () {
            var tid = $('#tid').val();
            var editRow = undefined;
            workload_datagrid = $('#workload_datagrid').datagrid({
                url: path + '/userAction?action=selectWorkload&tid='+tid,
                title: '工作量列表',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                // fit: true,
                fitColumns: true,
                nowrap: false,
                border: true ,
                idField: 'wid',
                columns: [[
                    {title: '教师编号',
                        field: 'tid',
                        width: 100,
                        checkbox:true
                    }, {
                        title: '工作量编号',
                        field: 'wid',
                        width: 100
                    },{
                        title: '课程名称',
                        field: 'cname',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }, {
                        title: '课程性质',
                        field: 'pro',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '上课学时',
                        field: 'hours',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '实验课时',
                        field: 'ech',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '监考课时',
                        field: 'ih',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '工作量',
                        field: 'works',
                        width: 100
                    }
                ]],
                toorbar:'',
                toolbar:[{
                    text:'增加',
                    iconCls:'icon-add',
                    handler:function () {
                        if (editRow != undefined){
                            workload_datagrid.datagrid('endEdit', editRow);
                        }
                        if (editRow == undefined){
                            workload_datagrid.datagrid('insertRow',{
                                index: 0,
                                row:{
                                    tid:tid
                                }
                            });
                            workload_datagrid.datagrid('beginEdit', 0);
                            editRow = 0;
                        }
                    }
                },{
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function () {
                        var rows = workload_datagrid.datagrid('getSelections');
                        if (rows.length>0){
                            $.messager.confirm('请确认', '您确定要删除当前所有选择的记录吗！', function (b) {
                                if (b){
                                    var ids = [];
                                    for (var i = 0; i < rows.length; i++) {
                                        ids.push(rows[i].wid);
                                    }
                                    $.ajax({
                                        url: 'workloadAction?action=del',
                                        data: {ids:ids.join(',')},
                                        dataType: 'json',
                                        success:function (r) {
                                            if(r && r.success){
                                                $.messager.show({
                                                    title:'提示',
                                                    msg: r.msg
                                                });
                                                workload_datagrid.datagrid('load');
                                                workload_datagrid.datagrid('unselectAll');
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
                }, {
                        text:'保存',
                        iconCls:'icon-save',
                        handler:function () {
                            workload_datagrid.datagrid('endEdit', editRow);
                            editRow = undefined;
                        }
                    },{
                        text:'取消编辑',
                        iconCls:'icon-redo',
                        handler:function () {
                            workload_datagrid.datagrid('rejectChanges');
                            workload_datagrid.datagrid('unselectAll');
                            workload_datagrid.datagrid('load');
                        }
                    }],
                onAfterEdit:function (rowIndex, rowData, changes) {
                    var inserted = workload_datagrid.datagrid('getChanges', 'inserted');
                    var updated = workload_datagrid.datagrid('getChanges', 'updated');
                    var url = '';
                    if (inserted.length>0){
                        url = 'workloadAction?action=add';
                    }
                    if (updated.length>0){
                        url = 'workloadAction?action=edit';
                    }
                    $.ajax({
                        url:url,
                        data:rowData,
                        dataType:'json',
                        success:function (r) {
                            if (r && r.success){
                                workload_datagrid.datagrid('acceptChanges');
                                $.messager.show({
                                    msg:r.msg,
                                    title:'保存成功!'
                                });
                            }else {
                                workload_datagrid.datagrid('rejectChanges');
                                $.messager.alert('保存失败!',r.msg,'error');
                            }
                            editRow = undefined;
                            workload_datagrid.datagrid('unselectAll');
                            workload_datagrid.datagrid('load');
                        }
                    })
                }
            });
        });
    }
    if ($('#level').val() == 'admin' || $('#level').val() == 'suAdmin'){
        $(function () {
            var editRow = undefined;
            workload_datagrid = $('#workload_datagrid').datagrid({
                url: path + '/userAction?action=selectWorkload',
                title: '工作量列表',
                pagination: true,
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                // pageSize: 15,
                // pageList: [15, 30, 45, 60],
                fitColumns: true,
                nowrap: false,
                border: true ,
                idField: 'wid',
                columns: [[
                    {
                        title: '工作量编号',
                        field: 'wid',
                        width: 100,
                        checkbox:true
                    },{
                        title: '教师编号',
                        field: 'tid',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '课程名称',
                        field: 'cname',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }, {
                        title: '课程性质',
                        field: 'pro',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '上课学时',
                        field: 'hours',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '实验课时',
                        field: 'ech',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '监考课时',
                        field: 'ih',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '工作量',
                        field: 'works',
                        width: 100
                    }
                ]],
                toolbar:[{
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function () {
                        var rows = workload_datagrid.datagrid('getSelections');
                        if (rows.length>0){
                            $.messager.confirm('请确认', '您确定要删除当前所有选择的记录吗！', function (b) {
                                if (b){
                                    var ids = [];
                                    for (var i = 0; i < rows.length; i++) {
                                        ids.push(rows[i].wid);
                                    }
                                    $.ajax({
                                        url: 'workloadAction?action=del',
                                        data: {ids:ids.join(',')},
                                        dataType: 'json',
                                        success:function (r) {
                                            if(r && r.success){
                                                $.messager.show({
                                                    title:'提示',
                                                    msg: r.msg
                                                });
                                                workload_datagrid.datagrid('load');
                                                workload_datagrid.datagrid('unselectAll');
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
                            var rows = workload_datagrid.datagrid('getSelections');
                            if (rows.length == 1){
                                if (editRow != undefined){
                                    workload_datagrid.datagrid('endEdit', editRow);
                                }
                                if (editRow == undefined){
                                    var index = workload_datagrid.datagrid('getRowIndex', rows[0]);
                                    workload_datagrid.datagrid('beginEdit', index);
                                    editRow = index;
                                    workload_datagrid.datagrid('unselectAll');
                                }
                            }
                        }
                    },
                    {
                        text:'保存',
                        iconCls:'icon-save',
                        handler:function () {
                            workload_datagrid.datagrid('endEdit', editRow);
                            editRow = undefined;
                        }
                    },{
                        text:'取消编辑',
                        iconCls:'icon-redo',
                        handler:function () {
                            workload_datagrid.datagrid('rejectChanges');
                            workload_datagrid.datagrid('unselectAll');
                            workload_datagrid.datagrid('load');
                        }
                    }],
                onAfterEdit:function (rowIndex, rowData, changes) {
                    var inserted = workload_datagrid.datagrid('getChanges', 'inserted');
                    var updated = workload_datagrid.datagrid('getChanges', 'updated');
                    var url = '';
                    if (inserted.length>0){
                        url = 'workloadAction?action=add';
                    }
                    if (updated.length>0){
                        url = 'workloadAction?action=edit';
                    }
                    $.ajax({
                        url:url,
                        data:rowData,
                        dataType:'json',
                        success:function (r) {
                            if (r && r.success){
                                workload_datagrid.datagrid('acceptChanges');
                                $.messager.show({
                                    msg:r.msg,
                                    title:'保存成功!'
                                });
                            }else {
                                workload_datagrid.datagrid('rejectChanges');
                                $.messager.alert('保存失败!',r.msg,'error');
                            }
                            editRow = undefined;
                            workload_datagrid.datagrid('unselectAll');
                            workload_datagrid.datagrid('load');
                        }
                    })
                },
                onDblClickRow:function (rowIndex, rowData) {
                    if (editRow != undefined){
                        workload_datagrid.datagrid('endEdit', editRow);
                    }
                    if (editRow == undefined){
                        workload_datagrid.datagrid('beginEdit', rowIndex);
                        editRow = rowIndex;
                    }
                }
            });
        });
    };

    searchWorkload = function () {
        workload_datagrid.datagrid('load',{
            tid: $('#searchWorks').find('[name=tid]').val(),
            cname: $('#searchWorks').find('[name=cname]').val(),
            pro: $('#searchWorks').find('[name=pro]').val()
        });
    };

    cleanSearch = function () {
        workload_datagrid.datagrid('load', {});
        $('#searchWorks').find('input').val('');
    };

</script>
