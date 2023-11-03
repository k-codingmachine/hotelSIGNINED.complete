package com.signied.controller.action;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.signied.dao.ReservationDAO;

public class ReservationDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
		int num = Integer.parseInt(request.getParameter("num"));
		
		ReservationDAO rDao = ReservationDAO.getInstance();
		int result = rDao.deleteReservation(num);
		
		if(result == 1) {
			request.setAttribute("result", result);
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
	}
}


