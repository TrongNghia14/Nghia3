using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Do_An_WTT.Models;

namespace Do_An_WTT.Controllers
{
    public class AdminController : Controller
    {
		qlBanCaCanhDataContext db = new qlBanCaCanhDataContext();
		// GET: Admin
		public ActionResult Index()
        {
            return View();
        }

		[HttpGet]
		public ActionResult Login() {
			return View();
		}

		[HttpPost]
		public ActionResult Login(FormCollection collection) {
			var tendn = collection["username"];
			var matkhau = collection["password"];

			ADMIN ad = db.ADMINs.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
			if(ad != null) {
				Session["Taikhoanadmin"] = ad;
				return RedirectToAction("Index", "Admin");
			}
			return View();
		}
	}
}