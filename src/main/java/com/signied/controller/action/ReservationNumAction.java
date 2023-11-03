package com.signied.controller.action;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.signied.dao.ReservationDAO;
import com.signied.dao.SigniedSearchDAO;
import com.signied.dto.ReservationVO;
import com.signied.dto.RoomVO;

public class ReservationNumAction implements Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
        String url = null;

        String email = request.getParameter("email");
        String name = request.getParameter("name");


        ReservationDAO rDao = ReservationDAO.getInstance();
        ReservationVO vo = rDao.selectOneByEmail(email);
        
        // 방 정보 가져오기
        SigniedSearchDAO sDao = SigniedSearchDAO.getInstance();

        
        if (vo != null && vo.getReserveEmail().equals(email)) {
           if(vo != null && vo.getReserveName().equals(name)) {
        	   RoomVO Rvo = sDao.selectOneByRoom(vo.getRoomNum());
        	   String checkIn = vo.getCheckIn().substring(0,10);
               String checkOut = vo.getCheckOut().substring(0,10);
               LocalDate startDate = LocalDate.parse(checkIn);
               LocalDate endDate = LocalDate.parse(checkOut);
               long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
               int total = (int)(daysBetween*Rvo.getRoomPrice());
               request.setAttribute("reservation", vo);
               request.setAttribute("checkIn", checkIn);
               request.setAttribute("checkOut", checkOut);
               request.setAttribute("room", Rvo);
               request.setAttribute("total", total);
               request.setAttribute("bak", daysBetween);
               url = "ReservationConfirm.jsp";              
           }else {
              url = "ReservationInquiry.jsp";
              request.setAttribute("name", "예약자 이름이 일치하지 않습니다.");
           }

        } else {
           url = "ReservationInquiry.jsp";
           request.setAttribute("message", "예약자 이메일이 존재하지 않습니다.");
        }

        request.getRequestDispatcher(url).forward(request, response);
    }
}