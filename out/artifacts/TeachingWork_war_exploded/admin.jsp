<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="js/rbUtils.js"></script>
<c:if test="${level == 'suAdmin'}">
    <input type="hidden" id="level" value="suAdmin">
</c:if>
<div region="north" border="false" style="width: 100%;height: 110px;background-color:#F4F4F4;">
    <form action="" id="searchAdmin">
        <table class="tableForm" style="width: 500px;height: 110px;">
            <tr>
                <th>管理员编号</th>
                <td><input type="text" name="aid"></td>
            </tr>
            <tr>
                <th>管理员姓名</th>
                <td><input type="text" name="aname"></td>
                <td colspan="2">
                    <a href="javascript:;" class="easyui-linkbutton" onclick="searchAdmin();">查询</a>
                    <a href="javascript:;" class="easyui-linkbutton" onclick="cleanSearchAdmin();">清空</a>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'center,border:false,fit:true"style="display: block">
    <table id="admin_datagrid" style="display: block"></table>
</div>
<script type="text/javascript" charset="UTF-8">
    var admin_datagrid;
    if ($('#level').val() == 'suAdmin'){
        $(function () {
            var editRow = undefined;
            admin_datagrid = $('#admin_datagrid').datagrid({
                url: path + '/userAction?action=selectAdmin',
                title: '管理员列表',
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
                        field: 'aid',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '姓名',
                        field: 'aname',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    },{
                        title: '性别',
                        field: 'asex',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }, {
                        title: '邮箱',
                        field: 'aemail',
                        width: 100,
                        editor:{
                            type: 'validatebox',
                            options:{
                                required:true
                            }
                        }
                    }
                    ,{
                        title: '密码',
                        field: 'apwd',
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
                            admin_datagrid.datagrid('endEdit', editRow);
                        }
                        if (editRow == undefined){
                            admin_datagrid.datagrid('insertRow',{
                                index: 0,
                                row:{
                                }
                            });
                            admin_datagrid.datagrid('beginEdit', 0);
                            editRow = 0;
                        }
                    }
                },{
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function () {
                        var rows = admin_datagrid.datagrid('getSelections');
                        if (rows.length>0){
                            $.messager.confirm('请确认', '您确定要删除当前所有选择的记录吗！', function (b) {
                                if (b){
                                    var ids = [];
                                    for (var i = 0; i < rows.length; i++) {
                                        ids.push(rows[i].aid);
                                    }
                                    $.ajax({
                                        url: 'adminAction?action=del',
                                        data: {ids:ids.join(',')},
                                        dataType: 'json',
                                        success:function (r) {
                                            if(r && r.success){
                                                $.messager.show({
                                                    title:'提示',
                                                    msg: r.msg
                                                });
                                                admin_datagrid.datagrid('load');
                                                admin_datagrid.datagrid('unselectAll');
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
                            var rows = admin_datagrid.datagrid('getSelections');
                            if (rows.length == 1){
                                if (editRow != undefined){
                                    admin_datagrid.datagrid('endEdit', editRow);
                                }
                                if (editRow == undefined){
                                    var index = admin_datagrid.datagrid('getRowIndex', rows[0]);
                                    admin_datagrid.datagrid('beginEdit', index);
                                    editRow = index;
                                    admin_datagrid.datagrid('unselectAll');
                                }
                            }
                        }
                    },
                    {
                        text:'保存',
                        iconCls:'icon-save',
                        handler:function () {
                            admin_datagrid.datagrid('endEdit', editRow);
                            editRow = undefined;
                        }
                    },{
                        text:'取消编辑',
                        iconCls:'icon-redo',
                        handler:function () {
                            admin_datagrid.datagrid('rejectChanges');
                            admin_datagrid.datagrid('unselectAll');
                            admin_datagrid.datagrid('load');
                        }
                    }],
                onAfterEdit:function (rowIndex, rowData, changes) {
                    var inserted = admin_datagrid.datagrid('getChanges', 'inserted');
                    var updated = admin_datagrid.datagrid('getChanges', 'updated');
                    var url = '';
                    if (inserted.length>0){
                        url = 'adminAction?action=add';
                    }
                    if (updated.length>0){
                        url = 'adminAction?action=edit';
                    }
                    $.ajax({
                        url:url,
                        data:rowData,
                        dataType:'json',
                        success:function (r) {
                            if (r && r.success){
                                admin_datagrid.datagrid('acceptChanges');
                                $.messager.show({
                                    msg:r.msg,
                                    title:'保存成功!'
                                });
                            }else {
                                admin_datagrid.datagrid('rejectChanges');
                                $.messager.alert('保存失败!',r.msg,'error');
                            }
                            editRow = undefined;
                            admin_datagrid.datagrid('unselectAll');
                            admin_datagrid.datagrid('load');
                        }
                    })
                },
                onDblClickRow:function (rowIndex, rowData) {
                    if (editRow != undefined){
                        admin_datagrid.datagrid('endEdit', editRow);
                    }
                    if (editRow == undefined){
                        admin_datagrid.datagrid('beginEdit', rowIndex);
                        editRow = rowIndex;
                    }
                }
            });
        });
    };

    searchAdmin = function () {
        admin_datagrid.datagrid('load',{
            aid: $('#searchAdmin').find('[name=aid]').val(),
            aname: $('#searchAdmin').find('[name=aname]').val()
        });
    };

    cleanSearchAdmin = function () {
        admin_datagrid.datagrid('load', {});
        $('#searchAdmin').find('input').val('');
    };
</script>
