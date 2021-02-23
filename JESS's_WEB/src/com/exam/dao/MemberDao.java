package com.exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.exam.vo.MemberVo;

public class MemberDao {
	
	// �̱��� ���� ����
	private static MemberDao instance = new MemberDao();
	
	public static MemberDao getInstance() {
		return instance;
	}
	
	///////////////////////////////////////////////////////////

	private MemberDao() {
	}

	// ȸ������ 1�� insert�ϱ�
	public void addMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql += "INSERT INTO member (id, passwd, name, age, gender, email, reg_date, cname, tel) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getId());
			pstmt.setString(2, memberVo.getPasswd());
			pstmt.setString(3, memberVo.getName());
			pstmt.setInt(4, memberVo.getAge());
			pstmt.setString(5, memberVo.getGender());
			pstmt.setString(6, memberVo.getEmail());
			pstmt.setTimestamp(7, memberVo.getRegDate());
			pstmt.setString(8, memberVo.getCname());
			pstmt.setString(9, memberVo.getTel());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// ���� �߻����ο� ������� ������ �����۾� ������.
			// try��Ͽ��� ���� ��ü�� �����ϴ� �۾��� �ַ� ��
			JdbcUtils.close(con, pstmt);
		}
	} // addMember()
	
	
	// 로그인 확인.
		// check -1  없는 아이디
		// check  0  패스워드 틀림
		// check  1  아이디, 패스워드 모두 일치
		public int userCheck(String id, String passwd) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			
			int check = -1; // 없는 아이디 상태값으로 초기화
			
			try {
				con = JdbcUtils.getConnection();
				// id에 해당하는 passwd 가져오기
				sql = "SELECT passwd FROM member WHERE id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				// rs에 저장
				rs = pstmt.executeQuery();
				// rs에 데이터(행) 있으면
				//             패스워드 비교  맞으면  check = 1  틀리면  check = 0
				// rs에 데이터(행) 없으면   check = -1
				if (rs.next()) {
					if (passwd.equals(rs.getString("passwd"))) {
						check = 1;
					} else {
						check = 0;
					}
				} else {
					check = -1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JdbcUtils.close(con, pstmt, rs);
			}
			return check;
		} // userCheck()
	
	
	
	
	// ��ü ȸ����� ��������
	public List<MemberVo> getAllMembers() {
		List<MemberVo> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT * FROM member ORDER BY id";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberVo memberVo = new MemberVo();
				memberVo.setId(rs.getString("id"));
				memberVo.setPasswd(rs.getString("passwd"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age"));
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setRegDate(rs.getTimestamp("reg_date"));
				
				list.add(memberVo);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getAllMembers()
	
	
	// Ư��id�� �ش��ϴ� ȸ�� 1�� ��������
	public MemberVo getMemberById(String id) {
		MemberVo memberVo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT * FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				memberVo = new MemberVo();
				memberVo.setId(rs.getString("id"));
				memberVo.setPasswd(rs.getString("passwd"));
				memberVo.setName(rs.getString("name"));
				memberVo.setAge(rs.getInt("age"));
				memberVo.setGender(rs.getString("gender"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setRegDate(rs.getTimestamp("reg_date"));
				memberVo.setCname(rs.getString("cname"));
				memberVo.setTel(rs.getString("tel"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return memberVo;
	} // getMemberById()
	
	
	public int getCountById(String id) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT COUNT(*) FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountById()
	
	
	// 특정id에 해당하는 회원 정보 수정하기
	public void UpdateMemberInfo(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql += " UPDATE member ";
			sql += " SET passwd = ?, email = ?, cname = ?, tel = ? ";
			sql += " WHERE id = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getPasswd());
			pstmt.setString(2, memberVo.getEmail());
			pstmt.setString(3, memberVo.getCname());
			pstmt.setString(4, memberVo.getTel());
			pstmt.setString(5, memberVo.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // UpdateMemberInfo
	
//	/**
//     * 회원정보를 수정한다.
//     * @param member 수정할 회원정보를 담고있는 TO
//     * @throws SQLException
//     */
//    public void UpdateMember(MemberVo memberVo) throws SQLException{
//        
//        Connection con = null;
//        PreparedStatement pstmt = null;
// 
//        try {
// 
//            StringBuffer query = new StringBuffer();
//            query.append(" UPDATE member SET ");
//            query.append(" passwd = ?, email = ?, cname = ?, tel = ? ");
//            query.append(" WHERE id = ? ");
// 
//            con = JdbcUtils.getConnection();
//            pstmt = con.prepareStatement(query.toString());
// 
//            // 자동 커밋을 false로 한다.
//            con.setAutoCommit(false);
//            
//            pstmt.setString(1, memberVo.getPasswd());
//			pstmt.setString(2, memberVo.getEmail());
//			pstmt.setString(3, memberVo.getCname());
//			pstmt.setString(4, memberVo.getTel());
//			pstmt.setString(5, memberVo.getId());
// 
//            pstmt.executeUpdate();
//            // 완료시 커밋
//            con.commit(); 
//                        
//            pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// 예외 발생여부에 관계없이 무조건 정리작업 수행함.
//			// try블록에서 만든 객체를 정리하는 작업을 주로 함
//			JdbcUtils.close(con, pstmt);
//		}
////            try{
////                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
////                if ( con != null ){ con.close(); con=null;    }
////            }catch(Exception e){
////                throw new RuntimeException(e.getMessage());
////            }
//    }// end updateMember
     


	
	
//	// 특정id에 해당하는 회원 1명 삭제하기
//	public void deleteById(String id) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			con = JdbcUtils.getConnection();
//			
//			String sql = "";
//			sql += "DELETE FROM member WHERE id = ? ";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, id);
//			
//			pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			JdbcUtils.close(con, pstmt);
//		}
//	}
	
	
	/**
     * 회원정보를 삭제한다.
     * @param id 회원정보 삭제 시 필요한 아이디
     * @param pw 회원정보 삭제 시 필요한 비밀번호
     * @return x : deleteMember() 수행 후 결과값
     */
    @SuppressWarnings("resource")
    public int deleteMember(String id, String passwd) 
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
 
        String dbpw = ""; // DB상의 비밀번호를 담아둘 변수
        int check = -1;
 
        try {
            // 비밀번호 조회
            StringBuffer query1 = new StringBuffer();
            query1.append("SELECT passwd FROM member WHERE id=? " );
 
            // 회원 삭제
            StringBuffer query2 = new StringBuffer();
            query2.append("DELETE FROM member WHERE id=? " );
 
            con = JdbcUtils.getConnection();
 
            // 자동 커밋을 false로 한다.
            con.setAutoCommit(false);
            
            // 1. 아이디에 해당하는 비밀번호를 조회한다.
            pstmt = con.prepareStatement(query1.toString());
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
 
            if (rs.next()) 
            {
                dbpw = rs.getString("passwd");
                if (dbpw.equals(passwd)) // 입력된 비밀번호와 DB비번 비교
                {
                    // 같을경우 회원삭제 진행
                    pstmt = con.prepareStatement(query2.toString());
                    pstmt.setString(1, id);
                    pstmt.executeUpdate();
                    con.commit(); 
                    check = 1; // 삭제 성공
                } else {
                    check = 0; // 비밀번호 비교결과 - 다름
                }
            }
 
            return check;
 
        } catch (Exception sqle) {
            try {
                con.rollback(); // 오류시 롤백
            } catch (SQLException e) {
                e.printStackTrace();
            }
            throw new RuntimeException(sqle.getMessage());
        } finally {
            try{
                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
                if ( con != null ){ con.close(); con=null;    }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
        }
    } // end deleteMember


	
	
	
	
	
	
	
//	public int deleteById(String id, String passwd) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		
//		int check = -1; // 없는 아이디 상태값으로 초기화
//		
//		try {
//			con = JdbcUtils.getConnection();
//			
//			sql += "DELETE FROM member WHERE id = ? AND passwd = ?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, id);
//			pstmt.setString(2, passwd);
//			
//			pstmt.executeUpdate();
//			
//			// rs에 데이터(행) 있으면
//			//             패스워드 비교  맞으면  check = 1  틀리면  check = 0
//			// rs에 데이터(행) 없으면   check = -1
//			if (rs.next()) {
//				if (passwd.equals(rs.getString("passwd"))) {
//					check = 1;
//				} else {
//					check = 0;
//				}
//			} else {
//				check = -1;
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			JdbcUtils.close(con, pstmt);
//		}
//		return check;
//	} // deleteById()
	
	
	
	// ��� ȸ�� �����ϱ�
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql += "DELETE FROM member ";
			pstmt = con.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll()
	
	
//	public static void main(String[] args) {
//		
//		// MemberDao ��ü �غ�
//		MemberDao memberDao = new MemberDao();
//		
//		Random random = new Random();
//		
//		memberDao.deleteAll(); // ��ü����
//		
//		System.out.println("======== insert �׽�Ʈ =========");
//		
//		for (int i=0; i<1000; i++) {
//			MemberVo memberVo = new MemberVo();
//			memberVo.setId("user"+i);
//			memberVo.setPasswd("1234");
//			memberVo.setName("����"+i);
//			
//			// ���̰��� ����  8���̻� ~ 100������
//			int age = random.nextInt(93) + 8; // (0~92)+8 -> (8~100)
//			memberVo.setAge(age);
//			
//			boolean isMale = random.nextBoolean(); // ���� true ���� false
//			if (isMale) {
//				memberVo.setGender("��");
//			} else {
//				memberVo.setGender("��");
//			}
//			
//			memberVo.setEmail("user" + i + "@user.com");
//			memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
//			memberVo.setCname("�λ��");
//			memberVo.setTel("010-1234-5678");
//			
//			memberDao.addMember(memberVo);
//			System.out.println("insert ����!");
//		}
//		
//		List<MemberVo> list = memberDao.getAllMembers();
//		for (MemberVo memberVo : list) {
//			System.out.println(memberVo);
//		}
//		
//		System.out.println("======== getMemberById �׽�Ʈ =========");
//		
//		String testId = "user0";
//		
//		MemberVo memberVo = memberDao.getMemberById(testId);
//		System.out.println(memberVo);
//		
//		System.out.println("======== update �׽�Ʈ =========");
//		
//		memberVo.setName("�̼���"); // ������ �̸��� ����
//		memberDao.update(memberVo);
//		
//		MemberVo getMemberVo = memberDao.getMemberById(testId);
//		System.out.println(getMemberVo);
//		
//		System.out.println("======== deleteById �׽�Ʈ =========");
//		
//		memberDao.deleteById(testId, testId);
//		
//		MemberVo getMemberVo2 = memberDao.getMemberById(testId);
//		System.out.println(getMemberVo2);
//		
//	} // main
	
}






