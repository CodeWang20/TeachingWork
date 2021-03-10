var path = $('#path').val();
var loginDialog;
$(function () {
    //登陆界面
    loginDialog = $('#loginDialog').dialog({
        iconCls: 'icon-lock',
        buttons: [{
            text: "登陆",
            handler: function () {
              console.info($('#loginForm').serialize());
              $.ajax({
                url: path + "/user.do?action=login",
                data : $('#loginForm').serialize(),
                dataType: 'json',
                success: function (data) {
                  if (data && data.success){
                    loginDialog.dialog('close');
                    $.messager.show({
                      title :'提示！',
                      msg : data.msg
                    });
                    location.reload();
                  }else {
                    $.messager.alert("提示！", data.msg);
                  }
                }
              });
            }
          }]

    });


    var teacher_data=[{
        "id":1,
        "text":"首页",
        state: "open",
        "children":[{
            id:"2",
            "text":"管理条目",
            "state":"open",
            "attributes":{
                "pid":"1"
            },
            "children":[{
                id: "3",
                "text":"总工作量(年)",
                "state":"open",
                "attributes":{
                    "url":"/workload",
                    "pid":"2"
                },
            }]
        }]
    }]

    $('#teacher_nav_tree').tree({
        data: teacher_data,
        lines:true,
        onClick:function (node) {
            if (node.attributes.url) {
                if ($('#teacher_nav_tabs').tabs('exists', node.text)) {
                    $('#teacher_nav_tabs').tabs('select', node.text);
                } else {
                    $('#teacher_nav_tabs').tabs('add', {
                        title: node.text,
                        closable: true,
                        href: path + node.attributes.url + '.jsp'
                    });
                }
            }
        }
    });

    var admin_data=[{
        "id":1,
        "text":"首页",
        state: "open",
        "children":[{
            id:"2",
            "text":"用户管理",
            "state":"open",
            "attributes":{
                "pid":"1"
            },
            "children":[{
                id: "3",
                "text":"教师信息",
                "state":"open",
                "attributes":{
                    "url":"/teacher",
                    "pid":"2"
                }
            }]
        },{
            id:"5",
            "text":"工作量管理",
            "state":"open",
            "attributes":{
                "pid":"1"
            },
            "children":[{
                id: "6",
                "text":"工作量列表",
                "state":"open",
                "attributes":{
                    "url":"/workload",
                    "pid":"5"
                },
            }]
        }]
    }]


    $('#admin_nav_tree').tree({
        data: admin_data,
        lines:true,
        onClick:function (node) {
            if (node.attributes.url) {
                if ($('#admin_nav_tabs').tabs('exists', node.text)) {
                    $('#admin_nav_tabs').tabs('select', node.text);
                } else {
                    $('#admin_nav_tabs').tabs('add', {
                        title: node.text,
                        closable: true,
                        href: path + node.attributes.url + '.jsp'
                    });
                }
            }
        }
    });


    var suAdmin_data=[{
        "id":1,
        "text":"首页",
        state: "open",
        "children":[{
            id:"2",
            "text":"用户管理",
            "state":"open",
            "attributes":{
                "pid":"1"
            },
            "children":[{
                id: "3",
                "text":"教师信息",
                "state":"open",
                "attributes":{
                    "url":"/teacher",
                    "pid":"2"
                }
            },{
                id: "4",
                "text":"管理员信息",
                "state":"open",
                "attributes":{
                    "url":"/admin",
                    "pid":"2"
                },
            }]
        },{
            id:"5",
            "text":"工作量管理",
            "state":"open",
            "attributes":{
                "pid":"1"
            },
            "children":[{
                id: "6",
                "text":"工作量列表",
                "state":"open",
                "attributes":{
                    "url":"/workload",
                    "pid":"5"
                },
            }]
        }]
    }]

    $('#suAdmin_nav_tree').tree({
        data: suAdmin_data,
        lines:true,
        onClick:function (node) {
            if (node.attributes.url) {
                if ($('#suAdmin_nav_tabs').tabs('exists', node.text)) {
                    $('#suAdmin_nav_tabs').tabs('select', node.text);
                } else {
                    $('#suAdmin_nav_tabs').tabs('add', {
                        title: node.text,
                        closable: true,
                        href: path + node.attributes.url + '.jsp'
                    });
                }
            }
        }
    });


});