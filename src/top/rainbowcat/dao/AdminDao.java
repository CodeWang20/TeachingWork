package top.rainbowcat.dao;


import top.rainbowcat.domain.Admin;

import java.util.List;

public interface AdminDao {
    Admin login(Integer aid, String apwd);

    List<Admin> findAdmin(String aid, String aname, int start, int rows);

    int findAdminTotalCount(String aid, String aname);

    Admin findByAid(String aid);

    void delete(Admin a);

    List<Admin> findByAid(Admin admin);

    void add(Admin admin);

    void update(Admin admin);

}
