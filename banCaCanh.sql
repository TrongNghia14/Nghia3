-- Xoa CSDL QLBanCaCanh neu co ton tai
USE master
DROP DATABASE QLBanCaCanh
-- Tao CSDL QLBanCaCanh
CREATE DATABASE QLBanCaCanh
GO
USE QLBanCaCanh
GO
CREATE TABLE KHACHHANG
(
	MaKH				   INT IDENTITY(1,1),
	HoTen			NVARCHAR(50)	NOT NULL,
	TaiKhoan	VARCHAR(50)  UNIQUE NOT NULL,
	MatKhau			 VARCHAR(50)	NOT NULL,
	Email			     VARCHAR(100) UNIQUE,
	DiaChiKH		           NVARCHAR(200),
	DienThoaiKH		             VARCHAR(50),
	NgaySinh						DATETIME
	CONSTRAINT PK_Khachhang	PRIMARY KEY (MaKH)
)
GO
CREATE TABLE PHANLOAI
(
	MaLoai			   INT IDENTITY(1,1),
	TenLoai		NVARCHAR(50)	NOT NULL,
	CONSTRAINT PK_Phanloai PRIMARY KEY (MaLoai)
)
GO
CREATE TABLE NHACUNGCAP
(
	MaNCC				   INT IDENTITY(1,1),
	TenNCC			NVARCHAR(100)	NOT NULL,
	DienThoai					 VARCHAR(50),
	DiaChi					   NVARCHAR(200),
	Email					   NVARCHAR(200),
	CONSTRAINT PK_Nhacungcap PRIMARY KEY (MaNCC)
)
GO
CREATE TABLE CA
(
	MaCa						                 INT,
	TenCa					NVARCHAR(100)	NOT NULL,
	GiaBan			 Decimal(18,0) CHECK (Giaban>=0),
	SoLuongTon									 INT,
	NgayCapNhap								DATETIME,
	AnhBia								 VARCHAR(50),
	MoTa							   NVarchar(Max),
	MaNCC								INT NOT NULL,
	MaLoai								INT NOT NULL,
	CONSTRAINT PK_Ca PRIMARY KEY (MaCa),
	CONSTRAINT FK_Ca_PhanLoai Foreign Key(MaLoai) REFERENCES PHANLOAI(MaLoai),
	CONSTRAINT FK_Ca_NhaCungCap Foreign Key(MaNCC) REFERENCES NHACUNGCAP(MaNCC)
)
GO
CREATE TABLE DONDATHANG
(
	MaDonHang				INT IDENTITY(1,1),
	Dathanhtoan							  BIT,
	Tinhtranggiaohang					  BIT,
	Ngaydat							 DATETIME,
	Ngaygiao						 DATETIME,
	MaKH						 INT NOT NULL,
	CONSTRAINT PK_Dondathang PRIMARY KEY (MaDonHang),
	CONSTRAINT FK_Dondathang_Khachhang FOREIGN KEY 
					(MaKH) REFERENCES Khachhang(MaKH),
)
GO
CREATE TABLE CHITIETDATHANG
(
	MaDonHang	INT,
	MaCa		INT,
	SoLuong		INT Check(SoLuong>0),
	DonGia		DECIMAL(18,0) Check(DonGia>=0),
	CONSTRAINT PK_CTDathang PRIMARY KEY (MaDonHang, MaCa),
	CONSTRAINT FK_CTDathang_Donhang FOREIGN KEY (MaDonHang) 
							REFERENCES DONDATHANG(MaDonHang),
	CONSTRAINT FK_CTDathang_Ca FOREIGN KEY (MaCa) REFERENCES CA(MaCa)
)

-- Nhập dữ liệu bảng phân loại
INSERT INTO PHANLOAI(TenLoai) VALUES (N'Thường')
INSERT INTO PHANLOAI(TenLoai) VALUES (N'Hiếm')
INSERT INTO PHANLOAI(TenLoai) VALUES (N'Cực hiếm')
INSERT INTO PHANLOAI(TenLoai) VALUES (N'Siêu hiếm')

-- Nhập dữ liệu bảng nhà cung cấp
INSERT INTO NHACUNGCAP(TenNCC, DienThoai, DiaChi, Email) VALUES 
	(N'Chi nhánh Hồ Chí Minh', 0909304093, N'Quận 1, TP. Hồ Chí Minh', 'chinhanhhochiminh@gmail.com')
INSERT INTO NHACUNGCAP(TenNCC, DienThoai, DiaChi, Email) VALUES 
	(N'Chi nhánh Hà Nội', 0909304093, N'Quận Đống Đa, TP. Hà Nội', 'chinhanhhanoi@gmail.com')
INSERT INTO NHACUNGCAP(TenNCC, DienThoai, DiaChi, Email) VALUES 
	(N'Chi nhánh Nhật Bản', 0452246343, N'Tokyo, Japan', 'chinhanhnhatban@gmail.com')
INSERT INTO NHACUNGCAP(TenNCC, DienThoai, DiaChi, Email) VALUES 
	(N'Chi nhánh Trung Quốc', 0151226343, N'Bắc Kinh, Trung Quốc', 'chinhanhtrungquoc@gmail.com')
INSERT INTO NHACUNGCAP(TenNCC, DienThoai, DiaChi, Email) VALUES 
	(N'Chi nhánh Mỹ', 0312909123, N'New York, America', 'chinhanhmy@gmail.com')

-- Nhập dữ liệu bảng cá
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(1, N'Cá đuối nước ngọt Polka Dot', 13000, 200, '2020-04-12', N'Loài cá đuối nước ngọt sinh trưởng phát triển ở các con sông thuộc khu vực châu Mỹ. Do môi 
	trường sống cùng nguồn thức ăn khác nhau tạo nên sự đa dạng cho loài cá này. Tên gọi chung là cá sam cảnh, sam motoro, sam kim cương đen (kim cương đen), 
	sam hoa mai, cá sam thiên hà. Cá sam-cá đuối nước ngọt được xếp hạng thuộc top 3 loài cá cảnh đẹp và đắt giá nhất tại thị trường cá cảnh Việt Nam. Những 
	hoa văn nổi bật cùng dáng bơi uyển chuyển sam được nhiều người chơi cá cảnh lựa chọn làm thú cưng cho riêng mình. Vì đuôi sam có độc nên nuôi cá sam riêng 
	một bể hay nuôi chung với các loài cá sống tại tầng trên và tầng giữa bể, vì cá sam ưa thích sống trong môi trường tầng đáy.', 1, 2, 'h1.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(2, N'Cá chọi Betta', 15000, 100, '2020-04-12', N'Cá chọi Betta xuất xứ từ Thái Lan không chỉ có màu sắc tuyệt đẹp được ví như những chiến binh dũng mãnh 
	tại các trường đấu cá trên thế giới. Loài cá tuyệt đẹp này không chỉ có đủ loại màu sắc khác nhau như đỏ, xanh, vàng …Tuy nhiên cá có giá nhất khi tới độ 
	trưởng thành khoảng 2 đầu ngón tay là có thể trở thành “chiến binh” thực thụ. Về giá cả, con nhỏ chỉ 10.000 đồng tới 40.000 đồng / con, nhưng các con cá 
	lớn, chọi tốt có giá lên tới cả nghìn USD.', 1, 3, 'h2.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(3, N'Cá trạng nguyên', 17000, 400, '2020-04-12', N'Cá trạng nguyên (có tên gọi khác là cá mó bông), tên tiếng Anh là cá trạng nguyên, tên khoa học là 
	Synchiropus Splendidus. Loài cá này sống chủ yếu tại các quần đảo san hô của khu vực Thái Bình Dương. Tên gọi của loài cá trạng nguyên xuất phát từ màu 
	sắc của chúng, giống bộ áo của các tân trạng nguyên khi lên nhận phong chức. Loài cá này được dân chơi cá cảnh Việt rất ưa chuộng bởi màu sắc rực rỡ. 
	Tại một số cửa hàng tại các thành phố lớn mới bán loại cá này có lẽ bởi giá của nó khá đắt, lên tới khoảng 3 triệu đồng/con. Những con cá đực được bán 
	với giá cao hơn, khoáng 3,5 – 4 triệu đồng/con.', 1, 1, 'h3.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(4, N'Cá chép Koi', 20000, 50, '2020-04-12', N'Màu sắc của các loài cá Koi được ví như những hình xăm mang ý nghĩa khác nhau. Cá chép Koi là loài có 
	nguồn gốc từ Trung Quốc nhưng lại được người Nhật rất yêu thích và được nuôi nhiều ở đất nước “Mặt trời mọc”. Chúng là biểu tượng cho sự may mắn và 
	thành công. Cá chép Koi có 2 loại chính Koi chuẩn và Koi bướm, loại cá Koi ngoại nhập có sức đề kháng cao trong môi trường Việt Nam. Koi chuẩn có hình 
	dáng giống cá nguyên thủy nhưng pha trộn nhiều màu sắc đẹp hơn, chủ yếu nuôi trong hồ, ao. Koi bướm khác cá nguyên thủy ở vây và đuôi khá dài nên khi 
	bơi mềm mại.', 1, 4, 'h4.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(5, N'Cá rồng nước ngọt vảy vàng', 13000, 200, '2020-04-12', N'Cá rồng được nhập từ nước ngoài như Indonesia, Malaysia, Singapore …, dùng để chưng 
	chơi Tết ý nghĩa mang lại may mắn cho chủ nhân. Với thân hình thuôn dài, vảy tựa vây rồng, cá rồng có nhiều loại được bày bàn ở các cửa hàng cá cảnh 
	như: Huyết Long, Thanh Long, Kim Long Quá Bối và Kim Long Hồng Vỹ. Cá rồng là một trong các loại cá có nhiều yếu tố “sang” nhất hiện nay vì rồng 
	tượng trưng cho sức mạnh và quyền lực, đem lại may mắn, thịnh vượng. Do vậy, cá rồng luôn là lựa chọn hàng đầu của nhiều gia đình. Vì cá rồng là 
	loài cá khá dữ nên chỉ có thể nuôi 1 con duy nhất hay nhiều con trong hồ lớn. Giá thành cho loài cá này thường khá cao từ vài triệu đến hàng trăm 
	triệu bởi ý nghĩa để trấn trạch trong nhà, gia chủ luôn phát đạt và bình an.', 2, 2, 'h5.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(6, N'Cá La Hán', 15000, 100, '2020-04-12', N'Cá la hán trong tiếng Anh là Flower Horn được ưa chuộng nhất tại Việt Nam từ nhiều năm nay bởi sự may 
	mắn và độc đáo của nó. Với chiếc đầu gù ngộ nghĩnh như một ông tiên và hàng chữ đậm trên cơ thể, cá la hán có mức giá khá cao. Tiêu chuẩn chung để 
	đánh giá một chú La hán đẹp là thân phải có nhiều “châu” tức là nhiều vảy cá óng ánh, màu sắc sặc sỡ và cái đầu có phần gù càng to càng giá trị. 
	Cá la hán ra đời nhờ vào sự lai tạo tuyệt vời của các nghệ nhân nên nó thật đáng quý. So với cá rồng thì cá la hán khó nuôi hơn và làm sao lên đầu 
	sao cho đẹp.', 2, 3, 'h6.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(7, N'Cá Ranchu', 17000, 400, '2020-04-12', N'Cá ranchu (Nhật Bản) vẫn luôn được mệnh danh là “vua của các loài cá vàng” và phát triển mạnh mẽ nhất 
	tại Nhật Bản. Giống như lan thọ, cá vàng ranchu không có vây lưng và bướu trên đầu. Ranchu khác lan thọ ở chỗ bướu trên đầu phát triển vừa phải và 
	phần lưng ở gốc đuôi cong hơn. Đặc điểm nổi bật nhất của cá vàng ranchu là không có vây lưng, với dáng chuẩn là các đường cong như quả trứng gà nên 
	trông khá ngộ nghĩnh và đáng yêu. Ranchu khá dễ nuôi, tuy nhiên để nuôi một con cá ranchu chuẩn không lai tạp nhiều thì mức giá khá khá cao.', 1, 1, 'h7.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(8, N'Cá rồng platium', 20000, 50, '2020-04-12', N'Được mệnh danh là vua các loại cá cảnh, cá rồng bạch tạng (hay còn gọi là cá rồng bạch kim) được 
	giới chơi sinh vật cảnh mê mẩn tìm mua. Cá rồng bạch kim là một dạng đột biến đặc biệt về màu sắc cơ thể, tương tự như dạng đột biến bạch tạng ở con 
	người, làm cho cơ thể chúng có màu trắng toát, trong khi họ hàng của chúng có lớp váy đỏ hay xanh, vàng bắt mắt. Tùy theo kích thước, tuổi đời và cơ 
	thể “không tì vết” mà giá của cá rồng bạch kim dao động từ 10,000-80,000 USD / con (khoảng 200 triệu đồng tới 1,7 tỷ đồng).', 2, 4, 'h8.jpg')
INSERT INTO CA(MaCa, TenCa, GiaBan, SoLuongTon, NgayCapNhap, MoTa, MaNCC, MaLoai, AnhBia) VALUES 
	(9, N'Cá Ngân Long', 20000, 50, '2020-04-12', N'Tên khoa học: Osteoglossum bicirrhosum là loài cá thuộc họ Cá rồng, được tìm thấy ở sông Lưu Vũ sông 
	Amazon, sông Rupununi và sông Oyapock trong Nam Mỹ, Guyana. Khi cá nhỏ (còn non), vây lưng cá có màu phấn hồng, ánh xanh lam, thân cá màu sáng bạc 
	ánh hồng. Cá trưởng thành vảy như vỏ sò, dạng nửa tròn, đường bên cá có 31-35 vầy. Toàn thân cá là màu trắng như kim loại xen lẫn ánh xanh lam và phấn
	hồng lấp lanh. Cá ăn thiên về động vật từ cá nhỏ, côn trùng, sâu bọ tới ếch nhái, tôm tép …dạng thức ăn đông lạnh hay thức ăn viên.', 1, 4, 'h9.jpg')
-- Nhập dữ liệu bảng khách hàng
INSERT INTO KHACHHANG(HoTen, TaiKhoan, MatKhau, Email, DiaChiKH, DienThoaiKH, NgaySinh) VALUES 
	(N'Nguyễn Thành Trọng Nghĩa', 'TrongNghia', '123456', 'trongnghia@gmail.com', N'Quận 12, Tp Hồ Chí minh', 0932321234, '1999-01-14')
INSERT INTO KHACHHANG(HoTen, TaiKhoan, MatKhau, Email, DiaChiKH, DienThoaiKH, NgaySinh) VALUES 
	(N'Lễ Nguyễn Việt Thắng', 'VietThang', '123456', 'vietthang@gmail.com', N'Quận 7, Tp Hồ Chí minh', 09323211362, '1999-010-14')
INSERT INTO KHACHHANG(HoTen, TaiKhoan, MatKhau, Email, DiaChiKH, DienThoaiKH, NgaySinh) VALUES 
	(N'Lê Thị Ngọc Diệp', 'NgocDiep', '123456', 'ngocdiep@gmail.com', N'Quận 1, Tp Hồ Chí minh', 0916544209, '1999-07-27')
INSERT INTO KHACHHANG(HoTen, TaiKhoan, MatKhau, Email, DiaChiKH, DienThoaiKH, NgaySinh) VALUES 
	(N'Nguyễn Thị Hồng Thắm', 'HongTham', '123456', 'hongtham@gmail.com', N'Quận Tân Phú, Tp Hồ Chí minh', 0989605347, '1999-03-13')
-- Nhập dữ liệu đơn đặt hàng
INSERT INTO DONDATHANG(Dathanhtoan, Tinhtranggiaohang, Ngaydat, Ngaygiao, MaKH) 
	VALUES (1, 1, '2020-04-14', '2020-04-16', 1)
INSERT INTO DONDATHANG(Dathanhtoan, Tinhtranggiaohang, Ngaydat, Ngaygiao, MaKH) 
	VALUES (1, 1, '2020-04-15', '2020-04-17', 2)
INSERT INTO DONDATHANG(Dathanhtoan, Tinhtranggiaohang, Ngaydat, Ngaygiao, MaKH) 
	VALUES (1, 1, '2020-04-16', '2020-04-18', 3)
-- Nhập dữ liệu bảng chi tiết đặt hàng
INSERT INTO CHITIETDATHANG(MaDonHang, MaCa, SoLuong, DonGia) VALUES (1, 2, 10, 15000)
INSERT INTO CHITIETDATHANG(MaDonHang, MaCa, SoLuong, DonGia) VALUES (2, 3, 15, 17000)
INSERT INTO CHITIETDATHANG(MaDonHang, MaCa, SoLuong, DonGia) VALUES (3, 4, 20, 20000)




-- Xem dữ liệu các bảng
select * from PHANLOAI
select * from NHACUNGCAP
select * from CA
select *from KHACHHANG
select *from DONDATHANG
select *from CHITIETDATHANG


-- Tạo bảng ADMIN
CREATE TABLE ADMIN
(
	UserAdmin			VARCHAR(30) PRIMARY KEY,
	PassAdmin			   VARCHAR(30) NOT NULL,
	Hoten						  NVARCHAR(100),
)	

INSERT INTO ADMIN(UserAdmin, PassAdmin, Hoten) VALUES ('admin', '14011999', N'Nguyễn Thành Trọng Nghĩa')