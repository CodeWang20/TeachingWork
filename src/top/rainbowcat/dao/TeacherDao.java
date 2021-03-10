package top.rainbowcat.dao;

import top.rainbowcat.domain.Teacher;

import java.util.List;

public interface TeacherDao {
    Teacher login(int tid, String tpwd);

    List<Teacher> findTeacher(String tid, String tname, String tpart, int start, int rows);

    int findTeacherTotalCount(String tid, String tname, String tpart);

    Teacher findByTid(String tid);

    void delete(Teacher teacher);

    List<Teacher> findByTid(Teacher teacher);

    void add(Teacher teacher);

    void update(Teacher teacher);
}
