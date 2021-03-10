package top.rainbowcat.web.servlet;


import org.apache.commons.beanutils.BeanUtils;
import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Json;
import top.rainbowcat.domain.Teacher;
import top.rainbowcat.service.impl.UserServiceImpl;
import top.rainbowcat.util.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet("/user.do")
public class UserdoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        JsonUtils jsonUtils = new JsonUtils();
        Json j = new Json();

        String action = request.getParameter("action");
        Map<String, String[]> map = request.getParameterMap();
        String level = request.getParameter("level");

        if (action.equals("login")){
            String verifycode = request.getParameter("verifycode");
            String checkCode_session = (String) session.getAttribute("checkCode_session");
            session.removeAttribute("checkCode_session");
            if (!checkCode_session.equalsIgnoreCase(verifycode)){
                j.setSuccess(false);
                j.setMsg("验证码错误！");
                request.setAttribute("msg", "验证码错误！");
                jsonUtils.listToJson(j, out);
            }

            UserServiceImpl service = new UserServiceImpl();
            if (level.equals("admin")) {
                Admin admin = new Admin();
                admin.setAid(Integer.parseInt(request.getParameter("username")));
                admin.setApwd(request.getParameter("password"));
                try {
                    BeanUtils.populate(admin, map);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                }
                Admin loginUser = service.login(admin);
                if (loginUser != null){
                    j.setSuccess(true);
                    j.setMsg("登陆成功！");
                    jsonUtils.listToJson(j, out);
                    if (loginUser.getAuthority() == 1){
                        session.setAttribute("level", "suAdmin");
                    }
                    if (loginUser.getAuthority() == 0) {
                        session.setAttribute("level", "admin");
                    }
                    session.setAttribute("user", loginUser);
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
                }else {
                    j.setSuccess(false);
                    j.setMsg("用户名或密码错误！");
                    jsonUtils.listToJson(j, out);
                    request.setAttribute("msg", "用户名或密码错误！");
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                }
            }else if (level.equals("teacher")) {
                Teacher teacher = new Teacher();
                teacher.setTid(Integer.parseInt(request.getParameter("username")));
                teacher.setTpwd(request.getParameter("password"));
                try {
                    BeanUtils.populate(teacher, map);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                }
                Teacher loginUser = service.login(teacher);
                if (loginUser != null){
                    j.setSuccess(true);
                    j.setMsg("登陆成功！");
                    j.setLevel("teacher");
                    jsonUtils.listToJson(j, out);
                    session.setAttribute("level", "teacher");
                    session.setAttribute("user", loginUser);
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
                }else {
                    j.setSuccess(false);
                    j.setMsg("用户名或密码错误！");
                    jsonUtils.listToJson(j, out);
                }
            }
        }
        if (action.equals("logout")){
            session.removeAttribute("user");
            session.removeAttribute("level");
            response.sendRedirect(request.getContextPath()+"/index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
