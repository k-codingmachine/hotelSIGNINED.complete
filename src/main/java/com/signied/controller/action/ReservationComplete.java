package com.signied.controller.action;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.signied.dao.ReservationDAO;
import com.signied.dto.ReservationVO;

public class ReservationComplete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
		ReservationVO vo = new ReservationVO();

		vo.setReserveEmail(request.getParameter("email"));
		vo.setReservePwd(request.getParameter("pwd"));
		vo.setReserveName(request.getParameter("name"));
		vo.setReservePhone(request.getParameter("phone"));
		vo.setCheckIn(request.getParameter("originCheckIn"));
		vo.setCheckOut(request.getParameter("originCheckOut"));
		vo.setGuestNum(Integer.parseInt(request.getParameter("adult")));
		vo.setBreakfast(Integer.parseInt(request.getParameter("child")));
		vo.setRoomNum(Integer.parseInt(request.getParameter("roomNum")));

		ReservationDAO rDao = ReservationDAO.getInstance();
		int result = rDao.insertReservation(vo);
		System.out.println("vo :" + vo);

		if (result == 1) {
			request.setAttribute("result", 2);
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
		
	}
}
