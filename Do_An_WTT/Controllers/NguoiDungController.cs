using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Do_An_WTT.Models;

namespace Do_An_WTT.Controllers
{
    public class NguoiDungController : Controller
    {
		qlBanCaCanhDataContext db = new qlBanCaCanhDataContext();
        // GET: NguoiDung
        public ActionResult Index()
        {
            return View();
        }

		// Đăng ký tài khoản
		public ActionResult DangKy()
		{
			return View();
		}
		// POST: Hàm DangKy(Post) nhận dữ liệu từ trang DangKy và thực hiện việc tạo mới dữ liệu 
		[HttpPost]
		public ActionResult DangKy(FormCollection collection, KHACHHANG kh)
		{
			//Gán giá trị người dùng nhập bên tran DangKy cho các biến
			var hoten = collection["HotenKH"];
			var taikhoan = collection["TenDangNhap"];
			var matkhau = collection["MatKhau"];
			var nhaplaimk = collection["NhapLaiMatKhau"];
			var email = collection["Email"];
			var diachi = collection["DiaChi"];
			var dienthoai = collection["DienThoai"];
			var ngaysinh = String.Format("{0:MM/dd/yyyy}", collection["NgaySinh"]);
			if(String.IsNullOrEmpty(hoten))
				ViewData["LoiHT"] = "Không được để trống";
			else if (String.IsNullOrEmpty(taikhoan))
				ViewData["LoiTDN"] = "Không được để trống";
			else if(String.IsNullOrEmpty(matkhau))
				ViewData["LoiMK"] = "Không được để trống";
			else if(String.IsNullOrEmpty(nhaplaimk)) 
				ViewData["LoiNLMK"] = "Không được để trống";	
			else if(matkhau != nhaplaimk)
				ViewData["LoiNLMK"] = "Mật khẩu nhập lại không trùng với mật khẩu ở trên";
			else if(String.IsNullOrEmpty(email))
				ViewData["LoiEmail"] = "Không được để trống";
			else if(String.IsNullOrEmpty(dienthoai))
				ViewData["LoiDT"] = "Không được để trống";
			else if(matkhau != nhaplaimk)
				ViewData["LoiNLMK"] = "Mật khẩu không trùng";
			else
			{
				//Gán giá trị cho các đối tượng tạo mới cho bảng
				kh.HoTen = hoten;
				kh.TaiKhoan = taikhoan;
				kh.MatKhau = matkhau;
				kh.Email = email;
				kh.DiaChiKH = diachi;
				kh.DienThoaiKH = dienthoai;
				kh.NgaySinh = DateTime.Parse(ngaysinh);
				db.KHACHHANGs.InsertOnSubmit(kh);
				db.SubmitChanges();
				return RedirectToAction("DangNhap");
			}
			return this.DangKy();
		}

		// Đăng nhập
		public ActionResult DangNhap(FormCollection collection)
		{
			
			var tendn = collection["TenDangNhap"];
			var matkhau = collection["MatKhau"];
			KHACHHANG kh = db.KHACHHANGs.SingleOrDefault(n => n.TaiKhoan == tendn && n.MatKhau == matkhau);
			if(kh != null) {
				Session["TaiKhoan"] = kh;
				return RedirectToAction("Index", "FishStore");
			}
			return View();
		}

		public ActionResult DangXuat() {
			Session.Abandon();
			return RedirectToAction("Index", "FishStore");
		}
	}
}