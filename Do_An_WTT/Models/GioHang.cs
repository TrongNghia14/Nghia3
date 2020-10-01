using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Do_An_WTT.Models {
	public class GioHang {
		qlBanCaCanhDataContext data = new qlBanCaCanhDataContext();

		public int iMaca { get; set; }

		public string sTenca { get; set; }

		public string sAnhbia { get; set; }

		public double dDongia { get; set; }

		public int iSoluong { get; set; }

		public Double dThanhtien
		{
			get { return iSoluong * dDongia; }
		}

		// Khởi tạo giỏ hàng theo MaCa được truyền vào với SoLuong là 1
		public GioHang(int MaCa)
		{
			iMaca = MaCa;
			CA ca = data.CAs.Single(n => n.MaCa == iMaca);
			sTenca = ca.TenCa;
			sAnhbia = ca.AnhBia;
			dDongia = double.Parse(ca.GiaBan.ToString());
			iSoluong = 1;
		}
	}
}