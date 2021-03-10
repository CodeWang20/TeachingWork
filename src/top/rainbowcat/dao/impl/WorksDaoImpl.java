package top.rainbowcat.dao.impl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import top.rainbowcat.dao.WorksDao;
import top.rainbowcat.domain.Works;
import top.rainbowcat.util.JDBCUtils;

import java.util.ArrayList;
import java.util.List;

public class WorksDaoImpl implements WorksDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());


    @Override
    public List<Works> findWorkloadByWid(Works works) {
        String sql = "select * from works where wid = ?";
        List<Works> work = template.query(sql, new BeanPropertyRowMapper<Works>(Works.class), works.getWid());
        return work;
    }


    @Override
    public List<Works> findWorkload(String tid, String cname, String pro, int start, int rows) {
        String sql = "select * from works where 1 = 1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (tid != null && tid != ""){
            sb.append(" and tid like ?");
            params.add("%" + Integer.parseInt(tid) + "%");
        }
        if (cname != null){
            sb.append(" and cname like ?");
            params.add("%" + cname + "%");
        }
        if (pro != null){
            sb.append(" and pro like ?");
            params.add("%" + pro + "%");
        }
        sb.append(" limit ?, ?");
        params.add(start);
        params.add(rows);
        if (tid == null && cname == null && pro == null){
            List<Works> works = template.query(sb.toString(), new BeanPropertyRowMapper<Works>(Works.class), params.toArray());
            return works;
        }else {
            List<Works> works = template.query(sb.toString(), new BeanPropertyRowMapper<Works>(Works.class), params.toArray());
            return works;
        }
    }

    @Override
    public Works findByWid(String wid) {
        String sql = "select * from works where wid = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Works>(Works.class), wid);
    }

    @Override
    public int findWorkloadTotalCount(String tid, String cname, String pro) {
        String sql = "select count(*) from works where 1=1";
        StringBuffer sb = new StringBuffer(sql);
        List<Object> params = new ArrayList<Object>();
        if (tid != null && tid != ""){
            sb.append(" and tid like ?");
            params.add("%" + Integer.parseInt(tid) + "%");
        }
        if (cname != null){
            sb.append(" and cname like ?");
            params.add("%" + cname + "%");
        }
        if (pro != null){
            sb.append(" and pro like ?");
            params.add("%" + pro + "%");
        }
        if (tid == null && cname == null && pro == null){
            return template.queryForObject(sql, Integer.class);
        }else {
            return template.queryForObject(sb.toString(), Integer.class, params.toArray());
        }
    }


    @Override
    public void delete(Works works) {
        String sql = "delete from works where wid = ?";
        template.update(sql, works.getWid());
    }

    @Override
    public void add(Works works) {
        String sql = "insert into works values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        template.update(sql, works.getWid(), works.getTid(), works.getCname(), works.getPro(), works.getHours(), works.getEch(),works.getIh(), works.getWorks(), works.getState());
    }

    @Override
    public void updateByWid(Works works) {
        String sql = "update works set tid = ?, cname = ?, pro = ?, hours = ?, ech = ?, ih = ?, works = ?, state = ? where  wid = ?";
        template.update(sql, works.getTid(), works.getCname(), works.getPro(), works.getHours(), works.getEch(), works.getIh(), works.getWorks(),works.getState(), works.getWid());
    }



}