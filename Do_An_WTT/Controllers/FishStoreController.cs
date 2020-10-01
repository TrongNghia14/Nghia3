using Do_An_WTT.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using PagedList;
using PagedList.Mvc;


namespace Do_An_WTT.Controllers
{
    public class FishStoreController : Controller
    {
		qlBanCaCanhDataContext data = new qlBanCaCanhDataContext();

		private List<CA> Laycamoi(int count) {
			return data.CAs.OrderByDescending(a => a.MaCa).Take(count).ToList();
		}
       
		// Trang hiện sản phẩm
		public ActionResult SanPham(int ? page) {
			// Tạo biên quy định số sản phẩm trên mỗi trang
			int pageSize = 3;
			// Tạo biên số trang
			int pageNum = (page ?? 1);

			var camoi = Laycamoi(9);
			return View(camoi.ToPagedList(pageNum, pageSize));
		}
		// Các loại cá
		public ActionResult LoaiCa() {
			var loaica = from tl in data.PHANLOAIs select tl;
			return PartialView(loaica);
		}
		// Các nhà cung cấp
		public ActionResult Nhacungcap() {
			var ncc = from t in data.NHACUNGCAPs select t;
			return PartialView(ncc);
		}
		//Lấy các loại cá theo từng phân loại (thường, hiếm, siêu hiếm, cực hiếm)
		public ActionResult Catheoloai(int id) {
			var ca = from s in data.CAs where s.MaLoai == id select s;
			return View(ca);
		}
		//thông tin nhà cung cấp
		public ActionResult Nhacungcaptheoloai(int id) {
			var ncc = from t in data.NHACUNGCAPs where t.MaNCC == id select t;
			return View(ncc);
		}
		// Chi tiết cá
		public ActionResult Chitietca(int id) {
			var ca = from c in data.CAs where c.MaCa == id select c;
			return View(ca.Single());
		}


		// GET: FishStore
		public ActionResult Index() {
			return View();
		}

		// Trang About
		public ActionResult About() {
			return View();
		}

		// Trang gallery
		public ActionResult Gallery() {
			return View();
		}

		// Trang Icon
		public ActionResult Icon() {
			return View();
		}

		// Trang Typo
		public ActionResult Typo() {
			return View();
		}

		// Trang Contact
		public ActionResult Contact() {
			return View();
		}

		// Trang single
		public ActionResult Single() {
			return View();
		}

	}
}