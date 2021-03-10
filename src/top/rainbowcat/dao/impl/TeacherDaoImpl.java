package top.rainbowcat.dao.impl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import top.rainbowcat.dao.TeacherDao;
import top.rainbowcat.domain.Admin;
import top.rainbowcat.domain.Teacher;
import top.rainbowcat.domain.Works;
import top.rainbowcat.util.JDBCUtils;

import java.util.ArrayList;
import java.util.List;


public class TeacherDaoImpl implements TeacherDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public Teacher login(int tid, String tpwd) {
        try {
            String sql = "select * from teacher where tid = ? and tpwd = ?";
            Teacher teachers = template.queryForObject(sql, new BeanPropertyRowMapper<Teacher>(Teacher.class), tid, tpwd);
            return teachers;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }


    @Override
    public List<Teacher> findTeacher(String tid, String tname, String tpart, int start, int rows) {
        String sql = "select * from teacher where 1 = 1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (tid != null && tid != ""){
            sb.append(" and tid like ?");
            params.add("%" + Integer.parseInt(tid) + "%");
        }
        if (tname != null){
            sb.append(" and tname like ?");
            params.add("%" + tname + "%");
        }
        if (tpart != null){
            sb.append(" and tpart like ?");
            params.add("%" + tpart + "%");
        }
        sb.append(" limit ?, ?");
        params.add(start);
        params.add(rows);

        if (tid == null && tname == null && tpart == null){
            List<Teacher> teachers = template.query(sb.toString(), new BeanPropertyRowMapper<Teacher>(Teacher.class), params.toArray());
            return teachers;
        }else {
            List<Teacher> teachers = template.query(sb.toString(), new BeanPropertyRowMapper<Teacher>(Teacher.class), params.toArray());
            return teachers;
        }
    }

    @Override
    public int findTeacherTotalCount(String tid, String tname, String tpart) {
        String sql = "select count(*) from teacher where 1=1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (tid != null && tid != ""){
            sb.append(" and tid like ?");
            params.add("%" + Integer.parseInt(tid) + "%");
        }
        if (tname != null){
            sb.append(" and tname like ?");
            params.add("%" + tname + "%");
        }
        if (tpart != null){
            sb.append(" and tpart like ?");
            params.add("%" + tpart + "%");
        }
        if (tid == null && tname == null && tpart == null){
            return template.queryForObject(sql, Integer.class);
        }else {
            return template.queryForObject(sb.toString(), Integer.class, params.toArray());
        }
    }

    @Override
    public Teacher findByTid(String tid) {
        String sql = "select * from teacher where tid = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Teacher>(Teacher.class), tid);
    }

    @Override
    public void delete(Teacher teacher) {
        String sql = "delete from teacher where Tid = ?";
        template.update(sql, teacher.getTid());
    }

    @Override
    public List<Teacher> findByTid(Teacher teacher) {
        String sql = "select * from teacher where tid = ?";
        List<Teacher> teachers = template.query(sql, new BeanPropertyRowMapper<Teacher>(Teacher.class), teacher.getTid());
        return teachers;
    }

    @Override
    public void add(Teacher teacher) {
        String sql = "insert into teacher values(?, ?, ?, ?, ?, ?)";
        template.update(sql, teacher.getTid(), teacher.getTname(), teacher.getTsex(), teacher.getTpms(), teacher.getTpart(), teacher.getTpwd());
    }

    @Override
    public void update(Teacher teacher) {
        String sql = "update teacher set tname = ?, tsex = ?, tpms = ?, tpart = ?, tpwd = ? where tid = ?";
        template.update(sql, teacher.getTname(), teacher.getTsex(), teacher.getTpms(), teacher.getTpart(), teacher.getTpwd(), teacher.getTid());
    }
}
