package com.signied.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringJoiner;
import java.util.stream.Collectors;

import com.signied.dto.RoomVO;
import com.signied.util.DBManager;

public class SigniedSearchDAO {

	private SigniedSearchDAO() {
	}

	private static SigniedSearchDAO instance = new SigniedSearchDAO();

	public static SigniedSearchDAO getInstance() {
		return instance;
	}
	
	public RoomVO selectOneByRoom(int roomNum) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		RoomVO vo = null;
		String sql = "select * from room where roomnum = ?";

		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, roomNum);

			rs = ps.executeQuery();

			if (rs.next()) {
				vo = new RoomVO();
				vo.setRoomNum(rs.getInt("roomNum"));
				vo.setRoomName(rs.getString("roomname"));
				vo.setRoomType(rs.getString("ROOMTYPE"));
				vo.setViewType(rs.getString("viewType"));
				vo.setInventory(rs.getInt("inventory"));
				vo.setRoomCapacity(rs.getInt("roomCapacity"));
				vo.setRoomPrice(rs.getInt("roomPrice"));
				vo.setImg(rs.getString("img"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, ps, rs);
		}
		return vo;
	}

	public List<RoomVO> searchRoom(String checkIn, String checkOut, int totalAmount) throws SQLException {

		List<RoomVO> list = new ArrayList<RoomVO>();
		// 주어진 체크인/체크아웃 날짜에 사용 가능하며 주어진 인원 수를 수용할 수 있는 방들의 정보를 가격 오름차순으로 가져옴.
		String sql =  "WITH date_range AS (\n"
	            + "    SELECT TO_DATE(?, 'YYYY-MM-DD') + LEVEL - 1 as the_date\n"
	            + "    FROM dual\n"
	            + "    CONNECT BY LEVEL <= TO_DATE(?, 'YYYY-MM-DD') - TO_DATE(?, 'YYYY-MM-DD')\n"
	            + "),\n"
	            + "\n"
	            + "reservation_counts AS (\n"
	            + "    SELECT res.roomNum, COUNT(DISTINCT d.the_date) AS reserved_days\n"
	            + "    FROM reservation res\n"
	            + "    JOIN date_range d ON res.checkIn <= d.the_date AND res.checkOut > d.the_date\n"
	            + "    GROUP BY res.roomNum\n"
	            + ")\n"
	            + "\n"
	            + "SELECT r.roomNum, r.roomName, r.roomType, r.viewType, r.roomCapacity, r.roomPrice, r.inventory, r.img\n"
	            + "FROM room r\n"
	            + "LEFT JOIN reservation_counts rc ON r.roomNum = rc.roomNum\n"
	            + "WHERE r.roomCapacity >= ? \n"
	            + "AND COALESCE(rc.reserved_days, 0) < r.inventory\n"
	            + "ORDER BY r.roomPrice ASC";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		RoomVO vo = null;

		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, checkIn);
			ps.setString(2, checkOut);
			ps.setString(3, checkIn);
			ps.setInt(4, totalAmount);

			rs = ps.executeQuery();

			while (rs.next()) {
				vo = new RoomVO();
				vo.setRoomNum(rs.getInt("roomNum"));
				vo.setRoomName(rs.getString("roomname"));
				vo.setRoomType(rs.getString("ROOMTYPE"));
				vo.setViewType(rs.getString("viewType"));
				vo.setInventory(rs.getInt("inventory"));
				vo.setRoomCapacity(rs.getInt("roomCapacity"));
				vo.setRoomPrice(rs.getInt("roomPrice"));
				vo.setImg(rs.getString("img"));

				list.add(vo);
				// System.out.println("검색한 room list : " + vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, ps, rs);
		}
		return list;
	}

	public List<RoomVO> detailSearchRoom(String sort, List<String> viewTypes, List<String> roomTypes,
			List<RoomVO> roomLists)
			throws SQLException {
		List<RoomVO> roomList = new ArrayList<RoomVO>();

		// roomNum 리스트 가져오기
		List<Integer> roomNums = roomLists.stream().map(RoomVO::getRoomNum).collect(Collectors.toList());

		List<String> conditions = new ArrayList<>();

		// roomNums를 조건에 추가
		StringJoiner roomNumCondition = new StringJoiner(", ", "roomNum IN (", ")");
		for (Integer roomNum : roomNums) {
			roomNumCondition.add(roomNum.toString());
		}
		conditions.add(roomNumCondition.toString());

		if (viewTypes != null && !viewTypes.isEmpty()) {
			StringJoiner viewCondition = new StringJoiner("', '", "viewType IN ('", "')");
			for (String viewType : viewTypes) {
				viewCondition.add(viewType);
			}
			conditions.add(viewCondition.toString());
		}

		if (roomTypes != null && !roomTypes.isEmpty()) {
			StringJoiner roomTypeCondition = new StringJoiner("', '", "roomType IN ('", "')");
			for (String roomType : roomTypes) {
				roomTypeCondition.add(roomType);
			}
			conditions.add(roomTypeCondition.toString());
		}

		String orderBy;
		if ("asc".equalsIgnoreCase(sort)) {
			orderBy = "ORDER BY roomPrice ASC";
		} else if ("desc".equalsIgnoreCase(sort)) {
			orderBy = "ORDER BY roomPrice DESC";
		} else {
			throw new IllegalArgumentException("Invalid sort type: " + sort);
		}

		String sql = "SELECT * FROM room";
		if (!conditions.isEmpty()) {
			sql += " WHERE " + String.join(" AND ", conditions);
		}
		sql += " " + orderBy;

		try (Connection conn = DBManager.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				RoomVO vo = new RoomVO();
				vo.setRoomNum(rs.getInt("roomNum"));
				vo.setRoomName(rs.getString("roomName"));
				vo.setRoomType(rs.getString("roomType"));
				vo.setViewType(rs.getString("viewType"));
				vo.setRoomCapacity(rs.getInt("roomCapacity"));
				vo.setRoomPrice(rs.getInt("roomPrice"));
				vo.setInventory(rs.getInt("inventory"));
				vo.setImg(rs.getString("img"));

				roomList.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roomList;
	}
}
