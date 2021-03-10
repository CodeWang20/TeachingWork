package top.rainbowcat.domain;

public class Teacher {
    private Integer tid;
    private String tname;
    private String tsex;
    private Integer tpms;
    private Integer tpart;
    private String tpwd;

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getTsex() {
        return tsex;
    }

    public void setTsex(String tsex) {
        this.tsex = tsex;
    }

    public Integer getTpms() {
        return tpms;
    }

    public void setTpms(Integer tpms) {
        this.tpms = tpms;
    }

    public Integer getTpart() {
        return tpart;
    }

    public void setTpart(Integer tpart) {
        this.tpart = tpart;
    }

    public String getTpwd() {
        return tpwd;
    }

    public void setTpwd(String tpwd) {
        this.tpwd = tpwd;
    }
}
