package top.rainbowcat.web.servlet;

import org.apache.commons.beanutils.BeanUtils;
import top.rainbowcat.dao.impl.AdminDaoImpl;
import top.rainbowcat.dao.impl.WorksDaoImpl;
import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Json;
import top.rainbowcat.domain.Works;
import top.rainbowcat.service.impl.UserServiceImpl;
import top.rainbowcat.util.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

@WebServlet("/adminAction")
public class AdminActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        JsonUtils jsonUtils = new JsonUtils();
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        UserServiceImpl service = new UserServiceImpl();
        Json j = new Json();
        Map<String, String[]> map = request.getParameterMap();
        Admin admin = new Admin();

        if (action.equals("del")){
            String ids = request.getParameter("ids");
            for (String aid: ids.split(",")){
                Admin a = service.findAdminByAid(aid);
                if (a != null){
                    AdminDaoImpl adminDao = new AdminDaoImpl();
                    adminDao.delete(a);
                    j.setSuccess(true);
                    j.setMsg("用户删除成功！");
                }else {
                    j.setSuccess(false);
                    j.setMsg("用户删除失败！");
                }
            }
        }else if (action.equals("add")){
            try {
                BeanUtils.copyProperties(admin, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            List<Admin> a = service.findAdminByAid(admin);
            if (a.size()==0) {
                admin.setAuthority(0);
                service.addAdmin(admin);
                j.setSuccess(true);
                j.setMsg("用户"+admin.getAname()+"增加成功！");
            }else {
                j.setSuccess(false);
                j.setMsg("用户"+admin.getAname()+"已经存在！");
            }
        }else if (action.equals("edit")){
            try {
                BeanUtils.copyProperties(admin, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            service.updateAdmin(admin);
            j.setSuccess(true);
            j.setMsg("用户"+admin.getAname()+"修改成功！");
        }

        jsonUtils.listToJson(j, out);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
