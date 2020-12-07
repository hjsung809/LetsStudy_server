package study;

import java.io.IOException;
import java.util.ArrayList;

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

/**
 * Servlet Filter implementation class StudyGroupListAddFilter
 */
//@WebFilter("/StudyGroupListAddFilter")
public class StudyGroupListAddFilter implements Filter {

    /**
     * Default constructor. 
     */
    public StudyGroupListAddFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		if(request instanceof HttpServletRequest) {
			HttpSession session =((HttpServletRequest)request).getSession();
			
			ArrayList<study.StudyGroup> studyGroupList = (ArrayList<study.StudyGroup>) session.getAttribute("studyGroupList");
			String study_group_id_string = request.getParameter("study_group_id");
			study.StudyGroup studyGroup = null;
			
			if (studyGroupList != null && study_group_id_string != null) {
				int study_group_id = Integer.parseInt(study_group_id_string);
				
				for (study.StudyGroup tmp : studyGroupList) {
					if (tmp.getStudy_group_id() == study_group_id) {
						studyGroup = tmp;
						session.setAttribute("studyGroup", studyGroup);
						break;
					}
				}
				
				if (studyGroup == null) {
					System.out.println("스터디 그룹을 찾을 수 없습니다.");
					((HttpServletResponse)response).sendRedirect("study_list.jsp");	
					return;
				}
			} else {
				System.out.println("스터디 그룹리스트가 비었거나,그룹 아이다가 비었습니다." + studyGroupList + "," + study_group_id_string);
				((HttpServletResponse)response).sendRedirect("study_list.jsp");	
				return;
			}
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
