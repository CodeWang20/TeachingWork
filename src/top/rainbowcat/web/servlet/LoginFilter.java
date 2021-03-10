package top.rainbowcat.web.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "loginFilter", urlPatterns = { "*.jsp" })
public class LoginFilter implements Filter {
 
	@Override
	public void destroy() {
	}
 
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(true);
		resp.setContentType("text/html;");
		resp.setCharacterEncoding("utf-8");
		PrintWriter out = resp.getWriter();
		String request_uri = req.getRequestURI();
		String ctxPath = req.getContextPath();
		String uri = request_uri.substring(ctxPath.length());
		if (uri.contains("index.jsp") || uri.contains("center.jsp") || uri.contains(req.getContextPath()+"/checkCodeServlet")) {
			chain.doFilter(request, response);
		} else {
			if (session.getAttribute("user") != null) {
				chain.doFilter(request, response);
			} else {
				out.println("您没有登录，请先登录！3秒后回到登录页面。");
				resp.setHeader("refresh", "3;url=" + ctxPath + "/index.jsp");
				return;
			}
		}
	}
 
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}
 
}

