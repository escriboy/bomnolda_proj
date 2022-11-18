package bom.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/user/*")
public class userController extends HttpServlet {
	UserDAO userDAO;
	UserVO userVO;

	@Override
	public void init() throws ServletException {
		userDAO = new UserDAO();
		userVO = new UserVO();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage=null;
		String ctx=request.getContextPath();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter pw;
		String action=request.getPathInfo();
		System.out.println("요청매핑이름:"+action);
		if(action.equals("/login.do")) {  //로그인
			String id=request.getParameter("id");
			String pwd=request.getParameter("pwd");
			userVO.setId(id);
			userVO.setPwd(pwd);
			Boolean result=userDAO.memExists(userVO);
			if(result) {  //회원정보 존재
					String name = userDAO.getUserName(userVO);
					System.out.println("회원정보가 존재합니다." + id + pwd);
					HttpSession session=request.getSession();
					session.setAttribute("isLogin", true);
					session.setAttribute("log_id", id);
					session.setAttribute("name", name);
					pw=response.getWriter();
					pw.print("<script>"
							+ "alert('로그인 되었습니다.');"
							+ "location.href='" + request.getContextPath() + "/index.jsp';"
							+ "</script>");
				}
			else {  //회원정보 없음
				System.out.println("회원정보가 존재하지 않습니다." + id + pwd);
				request.setAttribute("msg", "login_failed");
				pw=response.getWriter();
				pw.print("<script>"
						+ "alert('회원정보가 존재하지 않습니다.');"
						+ "location.href='" + request.getContextPath() + "/index.jsp';"
						+ "</script>");
				return;
			}

		} else if(action.equals("/logout.do")) {  //로그아웃
			HttpSession session=request.getSession(false);
//			session.removeAttribute("isLogin");
//			session.removeAttribute("log_id");
			session.invalidate();
			pw=response.getWriter();
			pw.print("<script>"
					+ "alert('로그아웃 되었습니다.');"
					+ "location.href='" + request.getContextPath() + "/index.jsp';"
					+ "</script>");
			return;
		} else if(action.equals("/join.do")) {  //가입
			String id = request.getParameter("id");
			boolean overlappedID=userDAO.overlappedID(id);
			pw=response.getWriter();
			if(!overlappedID) {  //중복 가입 여부 확인
				String pwd=request.getParameter("pwd");
				String name=request.getParameter("name");
				userVO.setId(id);
				userVO.setPwd(pwd);
				userVO.setName(name);
				userDAO.join(userVO);
				pw.print("<script>"
						+ "alert('회원가입 되었습니다.');"
						+ "location.href='" + request.getContextPath() + "/index.jsp';"
						+ "</script>");
				return;
			}else {
				pw.print("<script>"
						+ "alert('이미 가입되어 있는 아이디입니다.');"
						+ "location.href='" + request.getContextPath() + "/index.jsp';"
						+ "</script>");
				return;
			}
		}
//		System.out.println("페이지: " + nextPage);
		RequestDispatcher dispatcher=request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}
}
