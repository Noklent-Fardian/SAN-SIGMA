USE [master]
GO

-- Create Database
CREATE DATABASE [san_sigma2]
GO

USE [san_sigma2]
GO

-- Create Tables
CREATE TABLE [dbo].[users](
	[id] [int]  PRIMARY KEY,
	[name] [nvarchar](50) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[role] [nvarchar](50) CHECK ([role] IN ('admin', 'dosen', 'mahasiswa'))
)

CREATE TABLE [dbo].[prodis](
	[id] [int] PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL
)

CREATE TABLE [dbo].[admins](
	[id] [int] PRIMARY KEY,
	[user_id] [int] UNIQUE REFERENCES [users]([id]),
	[name] [nvarchar](100) NOT NULL,
	[gender] [nvarchar](10) CHECK ([gender] IN ('L', 'P')),
	[phone_number] [nvarchar](20) NULL,
	[photo] [nvarchar](max) NULL
)

CREATE TABLE [dbo].[dosens](
	[id] [int] PRIMARY KEY,
	[user_id] [int] UNIQUE REFERENCES [users]([id]),
	[name] [nvarchar](255) NOT NULL,
	[gender] [nvarchar](10) CHECK ([gender] IN ('L', 'P')),
	[phone_number] [nvarchar](20) NULL,
	[nip] [nvarchar](20) NULL,
	[status] [nvarchar](20) NULL,
	[photo] [nvarchar](max) NULL,
	[Alamat] [nvarchar](255) NULL,
	[Kota] [nvarchar](50) NULL,
	[Provinsi] [nvarchar](50) NULL,
	[agama] [nvarchar](50) NULL,
	[score] [int] NULL,
)

CREATE TABLE [dbo].[mahasiswas](
	[id] [int]  PRIMARY KEY,
	[prodi_id] [int] REFERENCES [prodis]([id]),
	[user_id] [int] REFERENCES [users]([id]),
	[name] [nvarchar](100) NOT NULL,
	[gender] [nvarchar](1) CHECK ([gender] IN ('l', 'p')),
	[phone_number] [nvarchar](20) NULL,
	[nim] [nvarchar](50) UNIQUE NOT NULL,
	[status] [nvarchar](50) NULL,
	[college_year] [int] NOT NULL,
	[score] [int] NULL,
	[photo] [nvarchar](max) NULL,
	[Alamat] [nvarchar](max) NULL,
	[Kota] [nvarchar](50) NULL,
	[Provinsi] [nvarchar](50) NULL,
	[agama] [nvarchar](50) NULL
)

CREATE TABLE [dbo].[tingkatans](
	[id] [int] PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL,
	[point] [int] NOT NULL
)

CREATE TABLE [dbo].[peringkats](
	[id] [int] PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL,
	[multiple] [float] NOT NULL
)

CREATE TABLE [dbo].[penghargaans](
	[id] [int] PRIMARY KEY,
	[mahasiswa_id] [int] REFERENCES [mahasiswas]([id]),
	[judul] [nvarchar](255) NOT NULL,
	[tempat] [nvarchar](50) NULL,
	[url] [nvarchar](max) NULL,
	[tanggal_mulai] [date] NULL,
	[tanggal_akhir] [date] NULL,
	[jumlah_instansi] [int] NULL,
	[jumlah_peserta] [int] NULL,
	[no_surat_tugas] [nvarchar](50) NULL,
	[tanggal_surat] [date] NULL,
	[file_surat_tugas] [nvarchar](max) NULL,
	[file_sertifikat] [nvarchar](max) NULL,
	[file_poster] [nvarchar](max) NULL,
	[file_photo_kegiatan] [nvarchar](max) NULL,
	[score] [int] NULL,
	[tingkat_id] [int] REFERENCES [tingkatans]([id]),
	[peringkat_id] [int] REFERENCES [peringkats]([id])
)

CREATE TABLE [dbo].[verifikasis](
	[id] [int] PRIMARY KEY,
	[mahasiswa_id] [int] REFERENCES [mahasiswas]([id]),
	[dosen_id] [int] REFERENCES [dosens]([id]),
	[admin_id] [int] REFERENCES [admins]([id]),
	[penghargaan_id] [int] REFERENCES [penghargaans]([id]),
	[verif_admin] [nvarchar](50) NULL,
	[pesan_admin] [nvarchar](max) NULL,
	[verif_pembimbing] [nvarchar](50) NULL,
	[pesan_pembimbing] [nvarchar](max) NULL
)
GO

-- Keep all the INSERT statements as they were in the original script
-- [Previous INSERT statements remain unchanged]

INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (1, N'admin1', N'admin', N'admin', N'admin')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (2, N'Atmin1', N'admin', N'admin123', N'admin')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (3, N'admin2', N'admin2', N'admin123', N'admin')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (4, N'admin3', N'admin3', N'admin123', N'admin')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (5, N'admin4', N'admin4', N'admin123', N'admin')

INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (21, N'Adi Putra', N'2341720201', N'2341720201', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (22, N'Budi Santoso', N'2341720202', N'2341720202', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (23, N'Citra Dewi', N'2341720203', N'2341720203', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (24, N'Dedi Prasetyo', N'2341720204', N'2341720204', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (25, N'Eka Susanti', N'2341720205', N'2341720205', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (26, N'Fajar Mahendra', N'2341720206', N'2341720206', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (27, N'Gita Sari', N'2341720207', N'2341720207', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (28, N'Hadi Kusuma', N'2341720208', N'2341720208', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (29, N'Ika Widyaningrum', N'2341720209', N'2341720209', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (30, N'Joko Priyono', N'2341720210', N'2341720210', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (31, N'Kiki Ramadhani', N'2341720211', N'2341720211', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (32, N'Lina Kartika', N'2341720212', N'2341720212', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (33, N'Miko Hardianto', N'2341720213', N'2341720213', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (34, N'Nina Putri', N'2341720214', N'2341720214', N'mahasiswa')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (35, N'Omar Ali', N'2341720215', N'2341720215', N'mahasiswa')


INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (36, N'Ahmad Fauzi, S.Pd., M.T.', N'12345678', N'12345678', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (37, N'Budi Santoso, S.Pd., M.T.', N'87654321', N'87654321', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (38, N'Citra Dewi, S.Pd., M.T.', N'11223344', N'11223344', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (39, N'Dedi Saputra, S.Pd., M.T.', N'44332211', N'44332211', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (40, N'Eka Prasetyo, S.Pd., M.T.', N'55667788', N'55667788', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (41, N'Fitria Sari, S.Pd., M.T.', N'88776655', N'88776655', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (42, N'Gilang Ramadhan, S.Pd., M.T.', N'99887766', N'99887766', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (43, N'Hana Permata, S.Pd., M.T.', N'66778899', N'66778899', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (44, N'Irfan Hakim, S.Pd., M.T.', N'22334455', N'22334455', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (45, N'Joko Susilo, S.Pd., M.T.', N'55443322', N'55443322', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (46, N'Karin Putri, S.Pd., M.T.', N'77889900', N'77889900', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (47, N'Lutfi Mahendra, S.Pd., M.T.', N'00998877', N'00998877', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (48, N'Maya Anjani, S.Pd., M.T.', N'66554433', N'66554433', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (49, N'Nanda Pratama, S.Pd., M.T.', N'33221100', N'33221100', N'dosen')
INSERT [dbo].[users] ([id], [name], [username], [password], [role]) VALUES (50, N'Oki Wibowo, S.Pd., M.T.', N'99001122', N'99001122', N'dosen')
GO
INSERT [dbo].[admins] ([id], [user_id], [name], [gender], [phone_number], [photo]) VALUES (1, 1, N'Andi Wijaya', N'L', N'081234567890', N'andi.jpg')
INSERT [dbo].[admins] ([id], [user_id], [name], [gender], [phone_number], [photo]) VALUES (2, 2, N'Budi Santoso', N'L', N'081234567891', N'budi.jpg')
INSERT [dbo].[admins] ([id], [user_id], [name], [gender], [phone_number], [photo]) VALUES (3, 3, N'Citra Dewi', N'P', N'081234567892', N'citra.jpg')
INSERT [dbo].[admins] ([id], [user_id], [name], [gender], [phone_number], [photo]) VALUES (4, 4, N'Dedi Saputra', N'L', N'081234567893', N'dedi.jpg')
INSERT [dbo].[admins] ([id], [user_id], [name], [gender], [phone_number], [photo]) VALUES (5, 5, N'Eka Prasetyo', N'L', N'081234567894', N'eka.jpg')
GO
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (1, 36, N'Andi Wijaya', N'L', N'081234567890', N'12345678', N'aktif', N'andi.jpg', N'Jl. Merdeka No. 1', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (2, 37, N'Budi Santoso', N'L', N'081234567891', N'87654321', N'aktif', N'budi.jpg', N'Jl. Pahlawan No. 2', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (3, 38, N'Citra Dewi', N'P', N'081234567892', N'11223344', N'ga aktif', N'citra.jpg', N'Jl. Bunga No. 3', N'Bandung', N'Jawa Barat', N'Hindu')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (4, 39, N'Dedi Saputra', N'L', N'081234567893', N'44332211', N'aktif', N'dedi.jpg', N'Jl. Raya No. 4', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (5, 40, N'Eka Prasetyo', N'L', N'081234567894', N'55667788', N'aktif', N'eka.jpg', N'Jl. Merdeka No. 5', N'Malang', N'Jawa Timur', N'Buddha')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (6, 41, N'Fitria Sari', N'P', N'081234567895', N'88776655', N'ga aktif', N'fitria.jpg', N'Jl. Raya No. 6', N'Yogyakarta', N'DI Yogyakarta', N'Kristen')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (7, 42, N'Gilang Ramadhan', N'L', N'081234567896', N'99887766', N'aktif', N'gilang.jpg', N'Jl. Pahlawan No. 7', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (8, 43, N'Hana Permata', N'P', N'081234567897', N'66778899', N'aktif', N'hana.jpg', N'Jl. Kemenangan No. 8', N'Bandung', N'Jawa Barat', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (9, 44, N'Irfan Hakim', N'L', N'081234567898', N'22334455', N'ga aktif', N'irfan.jpg', N'Jl. Damai No. 9', N'Surabaya', N'Jawa Timur', N'Protestan')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (10, 45, N'Joko Susilo', N'L', N'081234567899', N'55443322', N'aktif', N'joko.jpg', N'Jl. Raya No. 10', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (11, 46, N'Karin Putri', N'P', N'081234567900', N'77889900', N'aktif', N'karin.jpg', N'Jl. Merdeka No. 11', N'Yogyakarta', N'DI Yogyakarta', N'Hindu')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (12, 47, N'Lutfi Mahendra', N'L', N'081234567901', N'00998877', N'ga aktif', N'lutfi.jpg', N'Jl. Kemenangan No. 12', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (13, 48, N'Maya Anjani', N'P', N'081234567902', N'66554433', N'aktif', N'maya.jpg', N'Jl. Raya No. 13', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (14, 49, N'Nanda Pratama', N'L', N'081234567903', N'33221100', N'ga aktif', N'nanda.jpg', N'Jl. Pahlawan No. 14', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[dosens] ([id], [user_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (15, 50, N'Oki Wibowo', N'L', N'081234567904', N'99001122', N'aktif', N'oki.jpg', N'Jl. Damai No. 15', N'Malang', N'Jawa Timur', N'Buddha')
GO
UPDATE [dbo].[dosens] SET [score] = 2500 WHERE [id] = 1
UPDATE [dbo].[dosens] SET [score] = 3000 WHERE [id] = 2 
UPDATE [dbo].[dosens] SET [score] = 2000 WHERE [id] = 3
UPDATE [dbo].[dosens] SET [score] = 2800 WHERE [id] = 4
UPDATE [dbo].[dosens] SET [score] = 2600 WHERE [id] = 5
UPDATE [dbo].[dosens] SET [score] = 2300 WHERE [id] = 6
UPDATE [dbo].[dosens] SET [score] = 3200 WHERE [id] = 7
UPDATE [dbo].[dosens] SET [score] = 2900 WHERE [id] = 8
UPDATE [dbo].[dosens] SET [score] = 2100 WHERE [id] = 9
UPDATE [dbo].[dosens] SET [score] = 2700 WHERE [id] = 10
UPDATE [dbo].[dosens] SET [score] = 2400 WHERE [id] = 11
UPDATE [dbo].[dosens] SET [score] = 2200 WHERE [id] = 12
UPDATE [dbo].[dosens] SET [score] = 3100 WHERE [id] = 13
UPDATE [dbo].[dosens] SET [score] = 2500 WHERE [id] = 14
UPDATE [dbo].[dosens] SET [score] = 2800 WHERE [id] = 15
GO



INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (1, N'Juara 1/sederajat', 2)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (2, N'Juara 2/sederajat', 1.8)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (3, N'Juara 3/sederajat', 1.6)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (4, N'Harapan 1/sederajat', 1.5)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (5, N'Harapan 2/sederajat', 1.4)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (6, N'Harapan 3/sederajat', 1.3)
INSERT [dbo].[peringkats] ([id], [nama], [multiple]) VALUES (7, N'Lainnya', 1)
GO


INSERT [dbo].[prodis] ([id], [nama]) VALUES (1, N'D-IV Teknik Informatika')
INSERT [dbo].[prodis] ([id], [nama]) VALUES (2, N'D-IV Sistem Informasi Bisnis')
INSERT [dbo].[prodis] ([id], [nama]) VALUES (3, N'D-II PPRS')
INSERT [dbo].[prodis] ([id], [nama]) VALUES (4, N'S2 MTRTI')

GO
INSERT [dbo].[tingkatans] ([id], [nama], [point]) VALUES (1, N'Internasional', 1000)
INSERT [dbo].[tingkatans] ([id], [nama], [point]) VALUES (2, N'Nasional', 500)
INSERT [dbo].[tingkatans] ([id], [nama], [point]) VALUES (3, N'Provinsi', 250)
INSERT [dbo].[tingkatans] ([id], [nama], [point]) VALUES (4, N'Regional', 100)
GO
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (1, 1, 21, N'Andi Pratama', N'L', N'081234567910', N'2341720201', N'aktif', 2022, 2500, N'andi.jpg', N'Jl. Raya No. 1', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (2, 2, 22, N'Budi Santoso', N'L', N'081234567911', N'2341720202', N'aktif', 2021, 2300, N'budi.jpg', N'Jl. Merdeka No. 2', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (3, 1, 23, N'Citra Dewi', N'P', N'081234567912', N'2341720203', N'aktif', 2020, 2200, N'citra.jpg', N'Jl. Pahlawan No. 3', N'Bandung', N'Jawa Barat', N'Hindu')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (4, 2, 24, N'Dedi Saputra', N'L', N'081234567913', N'2341720204', N'aktif', 2023, 2800, N'dedi.jpg', N'Jl. Raya No. 4', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (5, 1, 25, N'Eka Prasetyo', N'L', N'081234567914', N'2341720205', N'aktif', 2022, 2400, N'eka.jpg', N'Jl. Merdeka No. 5', N'Malang', N'Jawa Timur', N'Buddha')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (6, 2, 26, N'Fitria Sari', N'P', N'081234567915', N'2341720206', N'aktif', 2020, 2100, N'fitria.jpg', N'Jl. Pahlawan No. 6', N'Yogyakarta', N'DI Yogyakarta', N'Kristen')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (7, 1, 27, N'Gilang Ramadhan', N'L', N'081234567916', N'2341720207', N'aktif', 2021, 2700, N'gilang.jpg', N'Jl. Raya No. 7', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (8, 2, 28, N'Hana Permata', N'P', N'081234567917', N'2341720208', N'aktif', 2023, 2900, N'hana.jpg', N'Jl. Kemenangan No. 8', N'Bandung', N'Jawa Barat', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (9, 1, 29, N'Irfan Hakim', N'L', N'081234567918', N'2341720209', N'aktif', 2020, 2000, N'irfan.jpg', N'Jl. Damai No. 9', N'Surabaya', N'Jawa Timur', N'Protestan')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (10, 2, 30, N'Joko Susilo', N'L', N'081234567919', N'2341720210', N'aktif', 2022, 2600, N'joko.jpg', N'Jl. Raya No. 10', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (11, 1, 31, N'Karin Putri', N'P', N'081234567920', N'2341720211', N'aktif', 2021, 2500, N'karin.jpg', N'Jl. Merdeka No. 11', N'Yogyakarta', N'DI Yogyakarta', N'Hindu')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (12, 2, 32, N'Lutfi Mahendra', N'L', N'081234567921', N'2341720212', N'aktif', 2020, 2200, N'lutfi.jpg', N'Jl. Kemenangan No. 12', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (13, 1, 33, N'Maya Anjani', N'P', N'081234567922', N'2341720213', N'aktif', 2023, 3000, N'maya.jpg', N'Jl. Raya No. 13', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (14, 2, 34, N'Nanda Pratama', N'L', N'081234567923', N'2341720214', N'aktif', 2021, 2400, N'nanda.jpg', N'Jl. Pahlawan No. 14', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[mahasiswas] ([id], [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama]) VALUES (15, 1, 35, N'Oki Wibowo', N'L', N'081234567924', N'2341720215', N'aktif', 2022, 2700, N'oki.jpg', N'Jl. Damai No. 15', N'Malang', N'Jawa Timur', N'Buddha')

GO
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (1, 2, N'Juara Basket', N'Surabaya', N'http://example.com/basket', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-03' AS Date), 3, 20, N'ST001', CAST(N'2023-04-28' AS Date), N'surat_basket.pdf', N'sertifikat_basket.pdf', N'poster_basket.jpg', N'photo_basket.jpg', 6400, 2, 1)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (2, 1, N'Juara Futsal', N'Malang', N'http://example.com/futsal', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-03' AS Date), 4, 30, N'ST002', CAST(N'2023-05-29' AS Date), N'surat_futsal.pdf', N'sertifikat_futsal.pdf', N'poster_futsal.jpg', N'photo_futsal.jpg', 5180, 3, 2)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (3, 2, N'UI/UX Design Competition', N'Jakarta', N'http://example.com/uiux', CAST(N'2023-07-10' AS Date), CAST(N'2023-07-12' AS Date), 2, 50, N'ST003', CAST(N'2023-07-05' AS Date), N'surat_uiux.pdf', N'sertifikat_uiux.pdf', N'poster_uiux.jpg', N'photo_uiux.jpg', 4730, 1, 3)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (4, 1, N'Hackathon Nasional', N'Yogyakarta', N'http://example.com/hackathon', CAST(N'2023-08-05' AS Date), CAST(N'2023-08-07' AS Date), 5, 100, N'ST004', CAST(N'2023-08-02' AS Date), N'surat_hackathon.pdf', N'sertifikat_hackathon.pdf', N'poster_hackathon.jpg', N'photo_hackathon.jpg', 5350, 4, 1)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (5, 1, N'Lomba Karya Tulis Ilmiah', N'Bandung', N'http://example.com/karya_tulis', CAST(N'2023-09-01' AS Date), CAST(N'2023-09-03' AS Date), 6, 15, N'ST005', CAST(N'2023-08-30' AS Date), N'surat_karya_tulis.pdf', N'sertifikat_karya_tulis.pdf', N'poster_karya_tulis.jpg', N'photo_karya_tulis.jpg', 4140, 2, 5)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (6, 3, N'Festival Seni Budaya', N'Surabaya', N'http://example.com/seni_budaya', CAST(N'2023-10-01' AS Date), CAST(N'2023-10-05' AS Date), 4, 40, N'ST006', CAST(N'2023-09-28' AS Date), N'surat_seni_budaya.pdf', N'sertifikat_seni_budaya.pdf', N'poster_seni_budaya.jpg', N'photo_seni_budaya.jpg', 3760, 3, 4)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (7, 3, N'Lomba Desain Grafis', N'Jakarta', N'http://example.com/desain_grafis', CAST(N'2023-11-01' AS Date), CAST(N'2023-11-03' AS Date), 2, 60, N'ST007', CAST(N'2023-10-28' AS Date), N'surat_desain_grafis.pdf', N'sertifikat_desain_grafis.pdf', N'poster_desain_grafis.jpg', N'photo_desain_grafis.jpg', 2600, 4, 2)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (8, 3, N'Kompetisi Robotik', N'Bandung', N'http://example.com/robotik', CAST(N'2023-12-10' AS Date), CAST(N'2023-12-12' AS Date), 3, 25, N'ST008', CAST(N'2023-12-07' AS Date), N'surat_robotik.pdf', N'sertifikat_robotik.pdf', N'poster_robotik.jpg', N'photo_robotik.jpg', 6600, 1, 7)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (9, 1, N'Lomba Presentasi Ilmiah', N'Yogyakarta', N'http://example.com/presentasi', CAST(N'2023-11-15' AS Date), CAST(N'2023-11-17' AS Date), 5, 35, N'ST009', CAST(N'2023-11-12' AS Date), N'surat_presentasi.pdf', N'sertifikat_presentasi.pdf', N'poster_presentasi.jpg', N'photo_presentasi.jpg', 5450, 2, 6)
INSERT [dbo].[penghargaans] ([id], [mahasiswa_id], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [no_surat_tugas], [tanggal_surat], [file_surat_tugas], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id]) VALUES (10, 2, N'Seminar Nasional', N'Malang', N'http://example.com/seminar', CAST(N'2023-10-20' AS Date), CAST(N'2023-10-22' AS Date), 4, 80, N'ST010', CAST(N'2023-10-17' AS Date), N'surat_seminar.pdf', N'sertifikat_seminar.pdf', N'poster_seminar.jpg', N'photo_seminar.jpg', 4490, 3, 1)
GO

