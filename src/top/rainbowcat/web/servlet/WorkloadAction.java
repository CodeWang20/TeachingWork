package top.rainbowcat.web.servlet;

import org.apache.commons.beanutils.BeanUtils;
import top.rainbowcat.dao.WorksDao;
import top.rainbowcat.dao.impl.WorksDaoImpl;
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

@WebServlet("/workloadAction")
public class WorkloadAction extends HttpServlet {
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
        Works works = new Works();

        if (action.equals("del")){
            String ids = request.getParameter("ids");
            for (String wid: ids.split(",")){
                Works u = service.findWorkloadByWid(wid);
                if (u != null){
                    WorksDaoImpl worksDao = new WorksDaoImpl();
                    worksDao.delete(u);
                    j.setSuccess(true);
                    j.setMsg("删除成功！");
                }else {
                    j.setSuccess(false);
                    j.setMsg("删除失败！");
                }
            }
        }else if (action.equals("add")){
            try {
                BeanUtils.copyProperties(works, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            //总工作量计算规则
//            works.setWorks(works.getHours() + works.getEch()*2 + works.getIh()*3);
            works.setState(0);
            List<Works> w = service.findWorkloadByWid(works);
            if (w.size()==0) {
                service.addWorkload(works);
                j.setSuccess(true);
                j.setMsg("工作量记录增加成功！");
            }else {
                j.setSuccess(false);
                j.setMsg("工作量记录增加失败！");
            }
        }else if (action.equals("edit")){
            try {
                BeanUtils.copyProperties(works, map);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
            works.setWorks(works.getHours() + works.getEch()*2 + works.getIh()*3);
            works.setState(1);
            service.updateWorkloadByWid(works);
            j.setSuccess(true);
            j.setMsg("工作量记录修改成功！");
        }

        jsonUtils.listToJson(j, out);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
