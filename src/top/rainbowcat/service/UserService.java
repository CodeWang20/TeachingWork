package top.rainbowcat.service;

import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Teacher;
import top.rainbowcat.domain.Works;

import java.util.List;

public interface UserService {
    Admin login(Admin admin);
    Teacher login(Teacher teacher);


    int findAdminTotalCount(String aid, String aname);
    int findTeacherTotalCount(String tid, String tname, String tpart);
    int findWorkloadTotalCount(String tid, String cname, String pro);

    List<Admin> findAllAdmin(String aid, String aname, int page, int rows);
    List<Teacher> findTeacher(String tid, String tname, String tpart, int start, int rows);


    List<Works> findWorkload(String id, String cname, String pro, int start, int rows);
    Works findWorkloadByWid(String wid);
    List<Works> findWorkloadByWid(Works works);

    Admin findAdminByAid(String aid);
    List<Admin> findAdminByAid(Admin admin);

    void addWorkload(Works works);
    void updateWorkloadByWid(Works works);


    void addAdmin(Admin admin);

    void updateAdmin(Admin admin);

    Teacher findAdminByTid(String tid);

    List<Teacher> findTeacherByTid(Teacher teacher);

    void addTeacher(Teacher teacher);

    void updateTeacher(Teacher teacher);

}
