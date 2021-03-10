package top.rainbowcat.web.servlet;

import org.apache.commons.beanutils.BeanUtils;
import top.rainbowcat.dao.impl.TeacherDaoImpl;
import top.rainbowcat.domain.Json;
import top.rainbowcat.domain.Teacher;
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

@WebServlet("/teacherAction")
public class TeacherActionServlet extends HttpServlet {
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
        Teacher teacher = new Teacher();

        if (action.equals("del")){
            String ids = request.getParameter("ids");
            for (String tid: ids.split(",")){
                Teacher t = service.findAdminByTid(tid);
                if (t != null){
                    TeacherDaoImpl teacherDao = new TeacherDaoImpl();
                    teacherDao.delete(t);
                    j.setSuccess(true);
                    j.setMsg("用户删除成功！");
                }else {
                    j.setSuccess(false);
                    j.setMsg("用户删除失败！");
                }
            }
        }else if (action.equals("add")){
            try {
                BeanUtils.copyProperties(teacher, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            List<Teacher> a = service.findTeacherByTid(teacher);
            if (a.size()==0) {
                service.addTeacher(teacher);
                j.setSuccess(true);
                j.setMsg("用户"+teacher.getTname()+"增加成功！");
            }else {
                j.setSuccess(false);
                j.setMsg("用户"+teacher.getTname()+"已经存在！");
            }
        }else if (action.equals("edit")){
            try {
                BeanUtils.copyProperties(teacher, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            service.updateTeacher(teacher);
            j.setSuccess(true);
            j.setMsg("用户"+teacher.getTname()+"修改成功！");
        }

        jsonUtils.listToJson(j, out);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
