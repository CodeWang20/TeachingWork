//ns 可以是一个字符串，也可是指定的对象
//如果是第一次定义，必需是一个用.分隔的字符串，这个函数会创建对应的空间
function rb(ns,op){
    switch(typeof ns){
        case 'object':
            if(ns===null)throw new Error('param error');
            jQuery.extend(ns,op);
            break;
        case 'string':
            var nss = ns.split(".");
            var part = window;
            for(i in nss){
                var name = nss[i];
                if(! part[name] ) part[name]= new Object();
                part  =  part[name];
            }
            jQuery.extend(part,op);
            break;

        default:
            throw new Error('param error');
            break;
    }
}
// var rb = $.extend({},rb);/*定义全局对象*/

rb.serializeObject = function (form) {/*将form表单元素的值序列化为对象*/
    var o = {};
    $.each(form.serializeArray(), function (index) {
        if (o[this['name']]){
            o[this['name']] = o[this['name']] + this['value'];
        }else {
            o[this['name']] = this['value']
        }
    });
    return o;
}

$.extend($.fn.datagrid.methods,{
    addEditor:function (jq, param) {
        if (param instanceof Array){
            $.each(param, function (index, item) {
                var e = $(jq).datagrid('getColumnOption', item.field);
                e.editor = item.editor;
            });
        }else {
            var e = $(jq).datagrid('getColumnOption', item.field);
            e.editor = {};
        }
    },
    removeEditor:function (jq, param) {
        if (param instanceof Array){
            $.each(param, function (index, item) {
                var e = $(jq).datagrid('getColumnOption', item.field);
                e.editor = {};
            });
        }else {
            var e = $(jq).datagrid('getColumnOption', item.field);
            e.editor = {};
        }
    }
});