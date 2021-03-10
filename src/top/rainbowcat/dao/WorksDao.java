package top.rainbowcat.dao;

import top.rainbowcat.domain.Works;

import java.util.List;

public interface WorksDao {
    List<Works> findWorkloadByWid(Works works);
    List<Works> findWorkload(String tid, String cname, String pro, int start, int rows);
    Works findByWid(String  wid);
    int findWorkloadTotalCount(String tid, String cname, String pro);
    void delete(Works works);
    void add(Works works);
    void updateByWid(Works works);

}
