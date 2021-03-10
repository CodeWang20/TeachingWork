package top.rainbowcat.web.servlet;

import top.rainbowcat.domain.*;
import top.rainbowcat.service.impl.UserServiceImpl;
import top.rainbowcat.util.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@WebServlet("/userAction")
public class UserActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonUtils jsonUtils = new JsonUtils();
        String action = request.getParameter("action");
        UserServiceImpl service = new UserServiceImpl();
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        PageBean pb = new PageBean();
        pb.setPage(page);
        pb.setRows(rows);
        int start = (page - 1) * rows;
        HashMap m = new HashMap();
        int total;
        if (action.equals("selectAdmin")){
            String aid = request.getParameter("aid");
            String aname = request.getParameter("aname");
            total = service.findAdminTotalCount(aid, aname);
            pb.setTotalCount(total);
            m.put("total", total);
            String level = request.getParameter("level");
            List<Admin> admins = service.findAllAdmin(aid, aname, start, rows);
            m.put("rows", admins);
        }else if (action.equals("selectTeacher")){
            String tid = request.getParameter("tid");
            String tname = request.getParameter("tname");
            String tpart = request.getParameter("tpart");
            total = service.findTeacherTotalCount(tid, tname, tpart);
            pb.setTotalCount(total);
            m.put("total", total);
            List<Teacher> teachers = service.findTeacher(tid, tname, tpart, start, rows);
            m.put("rows", teachers);
        }if (action.equals("selectWorkload")){
            String tid = request.getParameter("tid");
            String cname = request.getParameter("cname");
            String pro = request.getParameter("pro");
            total = service.findWorkloadTotalCount(tid, cname, pro);
            pb.setTotalCount(total);
            m.put("total", total);
            List<Works> works = service.findWorkload(tid, cname, pro, start, rows);
            m.put("rows", works);
        }
        jsonUtils.listToJson(m, out);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
