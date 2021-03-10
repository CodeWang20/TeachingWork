package top.rainbowcat.web.servlet;


import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

@WebServlet("/checkCodeServlet")
public class CheckCodeServlet extends HttpServlet {
    public static final int WIDTH = 90;
    public static final int HEIGHT = 30;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        OutputStream out = response.getOutputStream();

        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();

        // 1.填充颜色
        g.setColor(Color.GRAY);
        g.fillRect(0, 0, WIDTH, HEIGHT);

        // 2.画边框
        g.setColor(Color.BLUE);
        g.drawRect(1, 1, WIDTH-2, HEIGHT-2);
        // 3.画干扰线
        g.setColor(Color.GREEN);
        for (int i = 0; i < 6; i++) {
            int x1 = new Random().nextInt(WIDTH);
            int y1 = new Random().nextInt(HEIGHT);
            int x2 = new Random().nextInt(WIDTH);
            int y2 = new Random().nextInt(HEIGHT);

            g.drawLine(x1,y1,x2,y2);
        }
        // 4.产生随机数
        g.setColor(Color.RED);
        g.setFont(new Font("Times New Roman", Font.BOLD, 18));
        String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        int x = 10;

        //用于记录生成的验证码字符
        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < 4; i++) {
            String s = base.charAt(new Random().nextInt(base.length()-1))+"";

            //记录验证码字符
            sb.append(s);

            g.drawString(s, x, 18);
            x += 20;
        }

        // 将验证码字符存入session中
        String checkCode_session = sb.toString();
        request.getSession().setAttribute("checkCode_session", checkCode_session);

        // 5.发送图形到浏览器
        response.setContentType("image/jpeg");
        ImageIO.write(image, "jpg", out);

    }
}
