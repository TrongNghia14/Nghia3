using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Do_An_WTT.Models;

namespace Do_An_WTT.Controllers
{
    public class GioHangController : Controller
    {
		// Tạo đối tượng data chứa dữ liệu từ models qlBanCaCanh đã tạo
		qlBanCaCanhDataContext data = new qlBanCaCanhDataContext();
		// Lấy giỏ hàng
		public List<GioHang> Laygiohang()
		{
			List<GioHang> listGiohang = Session["GioHang"] as List<GioHang>;
			if(listGiohang == null)
			{
				// Nếu giỏ hàng chưa tồn tại thì khởi tạo listGiohang
				listGiohang = new List<GioHang>();
				Session["GioHang"] = listGiohang;
			}
			return listGiohang;
		}

		// Thêm hàng vào giỏ
		public ActionResult ThemGioHang(int iMaca, string strURL)
		{
			// Lấy ra Session giỏ hàng 
			List<GioHang> listGiohang = Laygiohang();
			//Kiểm tra cá này tồn tại trong giỏ hàng hay chưa?
			GioHang sp = listGiohang.Find(n => n.iMaca == iMaca);
			if(sp == null)
			{
				sp = new GioHang(iMaca);
				listGiohang.Add(sp);
				return Redirect(strURL);
			} 
			else
			{
				sp.iSoluong++;
				return Redirect(strURL);
			}
		}

		// Phương thức tính tổng số lượng
		private int Tongsoluong()
		{
			int iTongsoluong = 0;
			List<GioHang> listGiohang = Session["GioHang"] as List<GioHang>;
			if(listGiohang != null)
				iTongsoluong = listGiohang.Sum(n => n.iSoluong);
			return iTongsoluong;
		}

		// Phương thức tính tổng tiền
		private double Tongtien()
		{
			double dTongtien = 0;
			List<GioHang> listGiohang = Session["GioHang"] as List<GioHang>;
			if(listGiohang != null)
				dTongtien = listGiohang.Sum(n => n.dThanhtien);
			return dTongtien;
		}

		// Xây dựng trang giỏ hàng
		public ActionResult GioHang()
		{
			List<GioHang> listGiohang = Laygiohang();
			if(listGiohang.Count == 0)
				return RedirectToAction("Index", "FishStore");
			ViewBag.Tongsoluong = Tongsoluong();
			ViewBag.Tongtien = Tongtien();
			return View(listGiohang);
		}

		//Tạo Partial view 
		public ActionResult GioHangPartial()
		{
			ViewBag.Tongsoluong = Tongsoluong();
			ViewBag.Tongtien = Tongtien();
			
			return PartialView();
		}

		// Xóa từng sản phẩm trong giỏ hàng
		[HttpGet]
		public ActionResult Xoatungsanpham(int iMasp)
		{
			// Lấy giỏ hàng từ Session
			List<GioHang> listGiohang = Laygiohang();
			// Kiểm tra cá đã có trong Session ["GioHang"]
			GioHang sp = listGiohang.SingleOrDefault(n => n.iMaca == iMasp);
			// Nếu tồn tại thì cho sửa số lượng
			if(sp != null)
			{
				listGiohang.RemoveAll(n => n.iMaca == iMasp);
				return RedirectToAction("GioHang");
			}
			if(listGiohang.Count == 0)
				return RedirectToAction("Index", "FishStore");
			return RedirectToAction("GioHang");
		}

		// Xóa tất cả sản phẩm trong giỏ hàng
		[HttpGet]
		public ActionResult Xoatatcasanpham()
		{
			List<GioHang> listGiohang = Laygiohang();
			listGiohang.Clear();
			return RedirectToAction("Index", "FishStore");
		}

		// Cập nhật giỏ hàng
		public ActionResult Capnhatgiohang(int iMasp, FormCollection f)
		{
			CA ca = data.CAs.SingleOrDefault(n => n.MaCa == iMasp);
			if(ca == null)
			{
				Response.StatusCode = 404;
				return null;
			}
			// Lấy giỏ hàng từ Session
			List<GioHang> listGiohang = Laygiohang();
			// Kiểm tra cá đã có trong Session ["GioHang"]
			GioHang sp = listGiohang.SingleOrDefault(n => n.iMaca == iMasp);
			// Nếu tồn tại thì cho sửa số lượng
			if(sp != null)
				sp.iSoluong = int.Parse(f["txtSoluong"].ToString());
			return RedirectToAction("GioHang");
		}

		// Tạo đặt hàng
		// Hiển thị view DatHang để cập nhật các thông tin cho đơn hàng
		[HttpGet]
		public ActionResult DatHang()
		{
			// Kiểm tra đăng nhập
			if(Session["TaiKhoan"] == null || Session["TaiKhoan"].ToString() == "")
				return RedirectToAction("DangNhap", "NguoiDung");
			if(Session["GioHang"] == null)
				return RedirectToAction("Index", "FishStore");

			// Lấy giỏ hàng từ Session
			List<GioHang> listGiohang = Laygiohang();
			ViewBag.Tongsoluong = Tongsoluong();
			ViewBag.Tongtien = Tongtien();

			return View(listGiohang);
		}

		//
		public ActionResult DatHang(FormCollection f)
		{
			// Thêm đơn hàng 
			DONDATHANG ddh = new DONDATHANG();
			KHACHHANG kh = (KHACHHANG)Session["TaiKhoan"];
			List<GioHang> gh = Laygiohang();
			ddh.MaKH = kh.MaKH;
			ddh.Ngaydat = DateTime.Now;
			var ngaygiao = String.Format("{0:MM/dd/yyyy}", f["NgayGiao"]);
			ddh.Ngaygiao = DateTime.Parse(ngaygiao);
			ddh.Tinhtranggiaohang = false;
			ddh.Dathanhtoan = false;
			data.DONDATHANGs.InsertOnSubmit(ddh);
			data.SubmitChanges();
			// Thêm chi tiết đơn hàng
			foreach(var item in gh) {
				CHITIETDATHANG ctdh = new CHITIETDATHANG();
				ctdh.MaDonHang = ddh.MaDonHang;
				ctdh.MaCa = item.iMaca;
				ctdh.SoLuong = item.iSoluong;
				ctdh.DonGia = (decimal)item.dDongia;
				data.CHITIETDATHANGs.InsertOnSubmit(ctdh);
			}
			data.SubmitChanges();
			Session["GioHang"] = null;
			return RedirectToAction("Xacnhandonhang", "GioHang");
		}

		// View xác nhận đơn hàng
		public ActionResult Xacnhandonhang()
		{
			return View();
		}


	}
}