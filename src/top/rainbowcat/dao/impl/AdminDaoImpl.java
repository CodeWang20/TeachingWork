package top.rainbowcat.dao.impl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import top.rainbowcat.dao.AdminDao;
import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Teacher;
import top.rainbowcat.util.JDBCUtils;

import java.util.ArrayList;
import java.util.List;

public class AdminDaoImpl implements AdminDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());


    @Override
    public Admin login(Integer aid, String apwd) {
        try {

            String sql = "select * from admin where aid = ? and apwd = ?";
            Admin admin = template.queryForObject(sql, new BeanPropertyRowMapper<Admin>(Admin.class), aid, apwd);
            return admin;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }


    @Override
    public List<Admin> findAdmin(String aid, String aname, int start, int rows) {
        String sql = "select * from admin where 1 = 1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (aid != null && aid != ""){
            sb.append(" and aid like ?");
            params.add("%" + Integer.parseInt(aid) + "%");
        }
        if (aname != null){
            sb.append(" and aname like ?");
            params.add("%" + aname + "%");
        }
        sb.append(" limit ?, ?");
        params.add(start);
        params.add(rows);
        if (aid == null && aname == null){
            List<Admin> admins = template.query(sb.toString(), new BeanPropertyRowMapper<Admin>(Admin.class), params.toArray());
            return admins;
        }else {
            List<Admin> admins = template.query(sb.toString(), new BeanPropertyRowMapper<Admin>(Admin.class), params.toArray());
            return admins;
        }
    }

    @Override
    public int findAdminTotalCount(String aid, String aname) {
        String sql = "select count(*) from admin where 1=1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (aid != null && aid != ""){
            sb.append(" and aid like ?");
            params.add("%" + Integer.parseInt(aid) + "%");
        }
        if (aname != null){
            sb.append(" and aname like ?");
            params.add("%" + aname + "%");
        }
        if (aid == null && aname == null){
            return template.queryForObject(sql, Integer.class);
        }else {
            return template.queryForObject(sb.toString(), Integer.class, params.toArray());
        }
    }

    @Override
    public Admin findByAid(String aid) {
        String sql = "select * from admin where aid = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Admin>(Admin.class), aid);
    }

    @Override
    public void delete(Admin admin) {
        String sql = "delete from admin where aid = ?";
        template.update(sql, admin.getAid());
    }

    @Override
    public List<Admin> findByAid(Admin admin) {
        String sql = "select * from admin where aid = ?";
        List<Admin> admins = template.query(sql, new BeanPropertyRowMapper<Admin>(Admin.class), admin.getAid());
        return admins;
    }

    @Override
    public void add(Admin admin) {
        String sql = "insert into admin values(?, ?, ?, ?, ?, ?)";
        template.update(sql, admin.getAid(), admin.getAname(), admin.getAsex(), admin.getAemail(), admin.getApwd(), admin.getAuthority());
    }

    @Override
    public void update(Admin admin) {
        String sql = "update admin set aname = ?, asex = ?, aemail = ?, apwd = ?, authority = ? where aid = ?";
        template.update(sql, admin.getAname(), admin.getAsex(), admin.getAemail(), admin.getApwd(),admin.getAuthority(), admin.getAid());
    }


}
