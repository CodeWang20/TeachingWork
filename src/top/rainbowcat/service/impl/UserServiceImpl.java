package top.rainbowcat.service.impl;

import top.rainbowcat.dao.AdminDao;
import top.rainbowcat.dao.WorksDao;
import top.rainbowcat.dao.impl.AdminDaoImpl;
import top.rainbowcat.dao.TeacherDao;
import top.rainbowcat.dao.impl.TeacherDaoImpl;
import top.rainbowcat.dao.impl.WorksDaoImpl;
import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Teacher;
import top.rainbowcat.domain.Works;
import top.rainbowcat.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {
    private AdminDao adminDao = new AdminDaoImpl();
    private TeacherDao teacherDao = new TeacherDaoImpl();
    private WorksDao worksDao = new WorksDaoImpl();


    @Override
    public Admin login(Admin admin) {
        return adminDao.login(admin.getAid(), admin.getApwd());
    }

    @Override
    public Teacher login(Teacher teacher) {
        return teacherDao.login(teacher.getTid(), teacher.getTpwd());
    }


    @Override
    public int findAdminTotalCount(String aid, String aname) {
        return adminDao.findAdminTotalCount(aid, aname);
    }

    @Override
    public int findTeacherTotalCount(String tid, String tname, String tpart) {
        return teacherDao.findTeacherTotalCount(tid, tname, tpart);
    }


    @Override
    public int findWorkloadTotalCount(String tid, String cname, String pro) {
        return worksDao.findWorkloadTotalCount(tid, cname, pro);
    }


    @Override
    public List<Admin> findAllAdmin(String aid, String aname,int start, int rows) {
        return adminDao.findAdmin(aid, aname, start, rows);
    }


    @Override
    public List<Teacher> findTeacher(String tid, String tname, String tpart, int start, int rows) {
        return teacherDao.findTeacher(tid, tname, tpart, start, rows);
    }



    @Override
    public List<Works> findWorkload(String tid, String cname, String pro, int start, int rows) {
        return worksDao.findWorkload(tid, cname, pro, start, rows);
    }

    @Override
    public Works findWorkloadByWid(String wid) {
        return worksDao.findByWid(wid);
    }
    @Override
    public List<Works> findWorkloadByWid(Works works) {
        return worksDao.findWorkloadByWid(works);
    }




    @Override
    public void addWorkload(Works works) {
        worksDao.add(works);
    }
    @Override
    public void updateWorkloadByWid(Works works) {
        worksDao.updateByWid(works);
    }

    @Override
    public void addAdmin(Admin admin) {
        adminDao.add(admin);
    }

    @Override
    public void updateAdmin(Admin admin) {
        adminDao.update(admin);
    }

    @Override
    public Teacher findAdminByTid(String tid) {
        return teacherDao.findByTid(tid);
    }

    @Override
    public List<Teacher> findTeacherByTid(Teacher teacher) {
        return teacherDao.findByTid(teacher);
    }

    @Override
    public void addTeacher(Teacher teacher) {
        teacherDao.add(teacher);
    }

    @Override
    public void updateTeacher(Teacher teacher) {
        teacherDao.update(teacher);
    }


    @Override
    public Admin findAdminByAid(String aid) {
        return adminDao.findByAid(aid);
    }

    @Override
    public List<Admin> findAdminByAid(Admin admin) {
        return adminDao.findByAid(admin);
    }


}
