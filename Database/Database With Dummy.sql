USE [master]
GO

-- Create Database
CREATE DATABASE [san_sigma2]
GO

USE [san_sigma2]
GO

-- Create Tables
CREATE TABLE [dbo].[users]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[name] [nvarchar](50) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[role] [nvarchar](50) CHECK ([role] IN ('admin', 'dosen', 'mahasiswa')),
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_users] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[prodis]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_prodis] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[admins]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[user_id] [int] UNIQUE REFERENCES [users]([id]),
	[name] [nvarchar](100) NOT NULL,
	[gender] [nvarchar](10) CHECK ([gender] IN ('L', 'P')),
	[phone_number] [nvarchar](20) NULL,
	[photo] [nvarchar](max) NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_admins] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[dosens]
(
	[nip] [nvarchar](20) PRIMARY KEY,
	[prodi_id] [int] REFERENCES [prodis]([id]),
	[user_id] [int] UNIQUE REFERENCES [users]([id]),
	[name] [nvarchar](255) NOT NULL,
	[gender] [nvarchar](10) CHECK ([gender] IN ('L', 'P')),
	[phone_number] [nvarchar](20) NULL,
	[status] [nvarchar](20) CHECK ([status] IN ('aktif', 'tidak aktif')),
	[photo] [nvarchar](max) NULL,
	[Alamat] [nvarchar](255) NULL,
	[Kota] [nvarchar](50) NULL,
	[Provinsi] [nvarchar](50) NULL,
	[agama] [nvarchar](50) NULL,
	[score] [int] NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_dosens] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[mahasiswas]
(
	[nim] [nvarchar](20) PRIMARY KEY,
	[prodi_id] [int] REFERENCES [prodis]([id]),
	[user_id] [int] REFERENCES [users]([id]),
	[name] [nvarchar](100) NOT NULL,
	[gender] [nvarchar](1) CHECK ([gender] IN ('l', 'p')),
	[phone_number] [nvarchar](20) NULL,
	[status] [nvarchar](20) CHECK ([status] IN ('aktif', 'tidak aktif')) DEFAULT 'aktif',
	[college_year] [int] NOT NULL,
	[score] [int] NULL,
	[photo] [nvarchar](max) NULL,
	[Alamat] [nvarchar](max) NULL,
	[Kota] [nvarchar](50) NULL,
	[Provinsi] [nvarchar](50) NULL,
	[agama] [nvarchar](50) NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_mahasiswas] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[tingkatans]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL,
	[point] [int] NOT NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_tingkatans] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[peringkats]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[nama] [nvarchar](50) NOT NULL,
	[multiple] [float] NOT NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_peringkats] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[penghargaans]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[mahasiswa_nim] [nvarchar](20) REFERENCES [mahasiswas]([nim]),
	[judul] [nvarchar](255) NOT NULL,
	[tempat] [nvarchar](50) NULL,
	[url] [nvarchar](max) NULL,
	[tanggal_mulai] [date] NULL,
	[tanggal_akhir] [date] NULL,
	[jumlah_instansi] [int] NULL,
	[jumlah_peserta] [int] NULL,
	[file_sertifikat] [nvarchar](max) NULL,
	[file_poster] [nvarchar](max) NULL,
	[file_photo_kegiatan] [nvarchar](max) NULL,
	[score] [int] NULL,
	[tingkat_id] [int] REFERENCES [tingkatans]([id]),
	[peringkat_id] [int] REFERENCES [peringkats]([id]),
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_penghargaans] [bit] DEFAULT 1
)

CREATE TABLE [dbo].[verifikasis]
(
	[id] [int] IDENTITY(1,1) PRIMARY KEY,
	[mahasiswa_nim] [nvarchar](20) REFERENCES [mahasiswas]([nim]),
	[dosen_nip] [nvarchar](20) REFERENCES [dosens]([nip]),
	[admin_id] [int] REFERENCES [admins]([id]),
	[penghargaan_id] [int] REFERENCES [penghargaans]([id]),
	[verif_admin] [nvarchar](50) CHECK ([verif_admin] IN ('DiProses', 'DiTolak', 'Terverifikasi')),
	[pesan_admin] [nvarchar](max) NULL,
	[verif_pembimbing] [nvarchar](50)CHECK ([verif_pembimbing] IN ('DiProses', 'DiTolak', 'Terverifikasi')),
	[pesan_pembimbing] [nvarchar](max) NULL,
	[created_at] [datetime] DEFAULT GETDATE(),
	[visible_verifikasis] [bit] DEFAULT 1,
	[verifed_at] [datetime] NULL
)
GO

create Table [dbo].[events]
(
	[id] [int] identity(1,1) NOT NULL PRIMARY KEY,
	[name] [nvarchar](255) NOT NULL,
	[photo] [nvarchar](max) NULL,
	[url] [nvarchar](255) NOT NULL
)
GO

INSERT [dbo].[events]
	( [name], [photo], [url])
VALUES
	( N'Pimnas', N'pimnas.png', N'https://pimnas37.unair.ac.id')
INSERT [dbo].[events]
	( [name], [photo], [url])

VALUES
	( N'KMIPN', N'kmipn.png', N'https://www.instagram.com/kmipn2024_pnj/')
INSERT [dbo].[events]
	( [name], [photo], [url])

VALUES
	( N'Code Jam', N'codejam.png', N'https://en.wikipedia.org/wiki/Google_Code_Jam')
INSERT [dbo].[events]
	( [name], [photo], [url])

VALUES
	( N'Gemastik', N'gemastik.png', N'https://gemastik.kemdikbud.go.id/')
INSERT [dbo].[events]
	( [name], [photo], [url])
VALUES
	( N'GemasPlayittik', N'playit.png', 'Nhttps://jti.polinema.ac.id/playit2024/')
	INSERT [dbo].[events]
	( [name], [photo], [url])
	VALUES
	( N'pkm', N'pkm.png', 'https://lldikti6.kemdikbud.go.id/program-kreativitas-mahasiswa-pkm-5-bidang/')
	INSERT [dbo].[events]
	( [name], [photo], [url])
	VALUES
	( N'porseni', N'porseni.png', 'http://porseni.polinema.ac.id/')
	INSERT [dbo].[events]
	( [name], [photo], [url])
	VALUES
	( N'worldskill', N'worldskill.png', 'https://worldskills.org/')
	


-- Keep all the INSERT statements as they were in the original script
-- [Previous INSERT statements remain unchanged]

INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'admin1', N'admin', N'admin', N'admin')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Atmin1', N'admin1', N'admin123', N'admin')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'admin2', N'admin2', N'admin123', N'admin')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'admin3', N'admin3', N'admin123', N'admin')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'admin4', N'admin4', N'admin123', N'admin')

INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Andi Pratma', N'2341720201', N'2341720201', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Budi Santoso', N'2341720202', N'2341720202', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Citra Dewi', N'2341720203', N'2341720203', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Dedi Prasetyo', N'2341720204', N'2341720204', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Eka Susanti', N'2341720205', N'2341720205', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Fajar Mahendra', N'2341720206', N'2341720206', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Gita Sari', N'2341720207', N'2341720207', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Hadi Kusuma', N'2341720208', N'2341720208', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Ika Widyaningrum', N'2341720209', N'2341720209', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Joko Priyono', N'2341720210', N'2341720210', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Kiki Ramadhani', N'2341720211', N'2341720211', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Lina Kartika', N'2341720212', N'2341720212', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Miko Hardianto', N'2341720213', N'2341720213', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Nina Putri', N'2341720214', N'2341720214', N'mahasiswa')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Omar Ali', N'2341720215', N'2341720215', N'mahasiswa')


INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Oliver Smith', N'12345678', N'12345678', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'William Jones', N'87654321', N'87654321', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Emma Brown', N'11223344', N'11223344', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Harry Wilson', N'44332211', N'44332211', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'George Taylor', N'55667788', N'55667788', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Sophie Davies', N'88776655', N'88776655', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'James Evans', N'99887766', N'99887766', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Emily Thomas', N'66778899', N'66778899', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Charles Roberts', N'22334455', N'22334455', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Daniel Walker', N'55443322', N'55443322', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Lucy Morgan', N'77889900', N'77889900', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Michael Clarke', N'00998877', N'00998877', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Isabella White', N'66554433', N'66554433', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Thomas Hughes', N'33221100', N'33221100', N'dosen')
INSERT [dbo].[users]
	( [name], [username], [password], [role])
VALUES
	( N'Benjamin Green', N'99001122', N'99001122', N'dosen')
GO
INSERT [dbo].[admins]
	( [user_id], [name], [gender], [phone_number], [photo])
VALUES
	( 1, N'Andi Wijaya', N'L', N'081234567890', N'andi.jpg')
INSERT [dbo].[admins]
	( [user_id], [name], [gender], [phone_number], [photo])
VALUES
	( 2, N'Budi Santoso', N'L', N'081234567891', N'budi.jpg')
INSERT [dbo].[admins]
	( [user_id], [name], [gender], [phone_number], [photo])
VALUES
	( 3, N'Citra Dewi', N'P', N'081234567892', N'citra.jpg')
INSERT [dbo].[admins]
	( [user_id], [name], [gender], [phone_number], [photo])
VALUES
	( 4, N'Dedi Saputra', N'L', N'081234567893', N'dedi.jpg')
INSERT [dbo].[admins]
	( [user_id], [name], [gender], [phone_number], [photo])
VALUES
	( 5, N'Eka Prasetyo', N'L', N'081234567894', N'eka.jpg')

GO




INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Juara 1/sederajat', 2)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Juara 2/sederajat', 1.8)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Juara 3/sederajat', 1.6)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Harapan 1/sederajat', 1.5)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Harapan 2/sederajat', 1.4)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Harapan 3/sederajat', 1.3)
INSERT [dbo].[peringkats]
	( [nama], [multiple])
VALUES
	( N'Lainnya', 1)
GO


INSERT [dbo].[prodis]
	( [nama])
VALUES
	( N'D-IV Teknik Informatika')
INSERT [dbo].[prodis]
	( [nama])
VALUES
	( N'D-IV Sistem Informasi Bisnis')
INSERT [dbo].[prodis]
	( [nama])
VALUES
	( N'D-II PPRS')
INSERT [dbo].[prodis]
	( [nama])
VALUES
	( N'S2 MTRTI')

GO
INSERT [dbo].[tingkatans]
	( [nama], [point])
VALUES
	( N'Internasional', 1000)
INSERT [dbo].[tingkatans]
	( [nama], [point])
VALUES
	( N'Nasional', 500)
INSERT [dbo].[tingkatans]
	( [nama], [point])
VALUES
	( N'Provinsi', 250)
INSERT [dbo].[tingkatans]
	( [nama], [point])
VALUES
	( N'Regional', 100)
GO
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 21, 1, N'Oliver Smith', N'L', N'081234567890', N'12345678', N'aktif', N'andi.jpg', N'Jl. Merdeka No. 1', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 22, 2, N'William Jones', N'L', N'081234567891', N'87654321', N'aktif', N'budi.jpg', N'Jl. Pahlawan No. 2', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 23, 1, N'Emma Brown', N'P', N'081234567892', N'11223344', N'tidak aktif', N'citra.jpg', N'Jl. Bunga No. 3', N'Bandung', N'Jawa Barat', N'Hindu')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 24, 2, N'Harry Wilson', N'L', N'081234567893', N'44332211', N'aktif', N'dedi.jpg', N'Jl. Raya No. 4', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 25, 1, N'George Taylor', N'L', N'081234567894', N'55667788', N'aktif', N'eka.jpg', N'Jl. Merdeka No. 5', N'Malang', N'Jawa Timur', N'Buddha')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 26, 1, N'Sophie Davies', N'P', N'081234567895', N'88776655', N'tidak aktif', N'fitria.jpg', N'Jl. Raya No. 6', N'Yogyakarta', N'DI Yogyakarta', N'Kristen')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 27, 1, N'James Evans', N'L', N'081234567896', N'99887766', N'aktif', N'gilang.jpg', N'Jl. Pahlawan No. 7', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 28, 2, N'Emily Thomas', N'P', N'081234567897', N'66778899', N'aktif', N'hana.jpg', N'Jl. Kemenangan No. 8', N'Bandung', N'Jawa Barat', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 29, 1, N'Charles Roberts', N'L', N'081234567898', N'22334455', N'tidak aktif', N'irfan.jpg', N'Jl. Damai No. 9', N'Surabaya', N'Jawa Timur', N'Protestan')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 30, 2, N'Daniel Walker', N'L', N'081234567899', N'55443322', N'aktif', N'joko.jpg', N'Jl. Raya No. 10', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 31, 1, N'Lucy Morgan', N'P', N'081234567900', N'77889900', N'aktif', N'karin.jpg', N'Jl. Merdeka No. 11', N'Yogyakarta', N'DI Yogyakarta', N'Hindu')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 32, 1, N'Michael Clarke', N'L', N'081234567901', N'00998877', N'tidak aktif', N'lutfi.jpg', N'Jl. Kemenangan No. 12', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 33, 2, N'Isabella White', N'P', N'081234567902', N'66554433', N'aktif', N'maya.jpg', N'Jl. Raya No. 13', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 34, 1, N'Thomas Hughes', N'L', N'081234567903', N'33221100', N'tidak aktif', N'nanda.jpg', N'Jl. Pahlawan No. 14', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[dosens]
	( [user_id],[prodi_id], [name], [gender], [phone_number], [nip], [status], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 35, 1, N'Benjamin Green', N'L', N'081234567904', N'99001122', N'aktif', N'oki.jpg', N'Jl. Damai No. 15', N'Malang', N'Jawa Timur', N'Buddha')
GO

INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 6, N'Andi Pratama', N'L', N'081234567910', N'2341720201', N'aktif', 2022, 2500, N'andi.jpg', N'Jl. Raya No. 1', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 7, N'Budi Santoso', N'L', N'081234567911', N'2341720202', N'aktif', 2021, 2300, N'budi.jpg', N'Jl. Merdeka No. 2', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 8, N'Citra Dewi', N'P', N'081234567912', N'2341720203', N'aktif', 2020, 2200, N'citra.jpg', N'Jl. Pahlawan No. 3', N'Bandung', N'Jawa Barat', N'Hindu')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 9, N'Dedi Saputra', N'L', N'081234567913', N'2341720204', N'aktif', 2023, 2800, N'dedi.jpg', N'Jl. Raya No. 4', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 10, N'Eka Prasetyo', N'L', N'081234567914', N'2341720205', N'aktif', 2022, 2400, N'eka.jpg', N'Jl. Merdeka No. 5', N'Malang', N'Jawa Timur', N'Buddha')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 11, N'Fitria Sari', N'P', N'081234567915', N'2341720206', N'aktif', 2020, 2100, N'fitria.jpg', N'Jl. Pahlawan No. 6', N'Yogyakarta', N'DI Yogyakarta', N'Kristen')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 12, N'Gilang Ramadhan', N'L', N'081234567916', N'2341720207', N'aktif', 2021, 2700, N'gilang.jpg', N'Jl. Raya No. 7', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 13, N'Hana Permata', N'P', N'081234567917', N'2341720208', N'aktif', 2023, 2900, N'hana.jpg', N'Jl. Kemenangan No. 8', N'Bandung', N'Jawa Barat', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 14, N'Irfan Hakim', N'L', N'081234567918', N'2341720209', N'aktif', 2020, 2000, N'irfan.jpg', N'Jl. Damai No. 9', N'Surabaya', N'Jawa Timur', N'Protestan')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 15, N'Joko Susilo', N'L', N'081234567919', N'2341720210', N'aktif', 2022, 2600, N'joko.jpg', N'Jl. Raya No. 10', N'Malang', N'Jawa Timur', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 16, N'Karin Putri', N'P', N'081234567920', N'2341720211', N'aktif', 2021, 2500, N'karin.jpg', N'Jl. Merdeka No. 11', N'Yogyakarta', N'DI Yogyakarta', N'Hindu')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 17, N'Lutfi Mahendra', N'L', N'081234567921', N'2341720212', N'aktif', 2020, 2200, N'lutfi.jpg', N'Jl. Kemenangan No. 12', N'Semarang', N'Jawa Tengah', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 18, N'Maya Anjani', N'P', N'081234567922', N'2341720213', N'aktif', 2023, 3000, N'maya.jpg', N'Jl. Raya No. 13', N'Jakarta', N'DKI Jakarta', N'Islam')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 2, 19, N'Nanda Pratama', N'L', N'081234567923', N'2341720214', N'aktif', 2021, 2400, N'nanda.jpg', N'Jl. Pahlawan No. 14', N'Surabaya', N'Jawa Timur', N'Kristen')
INSERT [dbo].[mahasiswas]
	( [prodi_id], [user_id], [name], [gender], [phone_number], [nim], [status], [college_year], [score], [photo], [Alamat], [Kota], [Provinsi], [agama])
VALUES
	( 1, 20, N'Oki Wibowo', N'L', N'081234567924', N'2341720215', N'aktif', 2022, 2700, N'oki.jpg', N'Jl. Damai No. 15', N'Malang', N'Jawa Timur', N'Buddha')

GO
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720203, N'Juara Basket', N'Surabaya', N'http://example.com/basket', CAST(N'2023-05-01' AS Date), CAST(N'2023-05-03' AS Date), 3, 20, N'sertifikat_basket.pdf', N'poster_basket.jpg', N'photo_basket.jpg', 6400, 2, 1)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720203, N'Juara Futsal', N'Malang', N'http://example.com/futsal', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-03' AS Date), 4, 30, N'sertifikat_futsal.pdf', N'poster_futsal.jpg', N'photo_futsal.jpg', 5180, 3, 2)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720202, N'UI/UX Design Competition', N'Jakarta', N'http://example.com/uiux', CAST(N'2023-07-10' AS Date), CAST(N'2023-07-12' AS Date), 2, 50, N'sertifikat_uiux.pdf', N'poster_uiux.jpg', N'photo_uiux.jpg', 4730, 1, 3)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720202, N'Hackathon Nasional', N'Yogyakarta', N'http://example.com/hackathon', CAST(N'2023-08-05' AS Date), CAST(N'2023-08-07' AS Date), 5, 100, N'sertifikat_hackathon.pdf', N'poster_hackathon.jpg', N'photo_hackathon.jpg', 5350, 4, 1)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720201, N'Lomba Karya Tulis Ilmiah', N'Bandung', N'http://example.com/karya_tulis', CAST(N'2023-09-01' AS Date), CAST(N'2023-09-03' AS Date), 6, 15, N'sertifikat_karya_tulis.pdf', N'poster_karya_tulis.jpg', N'photo_karya_tulis.jpg', 4140, 2, 5)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720203, N'Festival Seni Budaya', N'Surabaya', N'http://example.com/seni_budaya', CAST(N'2023-10-01' AS Date), CAST(N'2023-10-05' AS Date), 4, 40, N'sertifikat_seni_budaya.pdf', N'poster_seni_budaya.jpg', N'photo_seni_budaya.jpg', 3760, 3, 4)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720202, N'Lomba Desain Grafis', N'Jakarta', N'http://example.com/desain_grafis', CAST(N'2023-11-01' AS Date), CAST(N'2023-11-03' AS Date), 2, 60, N'sertifikat_desain_grafis.pdf', N'poster_desain_grafis.jpg', N'photo_desain_grafis.jpg', 2600, 4, 2)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720201, N'Kompetisi Robotik', N'Bandung', N'http://example.com/robotik', CAST(N'2023-12-10' AS Date), CAST(N'2023-12-12' AS Date), 3, 25, N'sertifikat_robotik.pdf', N'poster_robotik.jpg', N'photo_robotik.jpg', 6600, 1, 7)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720201, N'Lomba Presentasi Ilmiah', N'Yogyakarta', N'http://example.com/presentasi', CAST(N'2023-11-15' AS Date), CAST(N'2023-11-17' AS Date), 5, 35, N'sertifikat_presentasi.pdf', N'poster_presentasi.jpg', N'photo_presentasi.jpg', 5450, 2, 6)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720202, N'Seminar Nasional', N'Malang', N'http://example.com/seminar', CAST(N'2023-10-20' AS Date), CAST(N'2023-10-22' AS Date), 4, 80, N'sertifikat_seminar.pdf', N'poster_seminar.jpg', N'photo_seminar.jpg', 4490, 3, 1)
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( 2341720203, N'Ini gagal', N'Malang', N'http://example.com/seminar', CAST(N'2023-10-20' AS Date), CAST(N'2023-10-22' AS Date), 4, 80, N'sertifikat_seminar.pdf', N'poster_seminar.jpg', N'photo_seminar.jpg', 4490, 3, 1)
GO
INSERT [dbo].[penghargaans]
	( [mahasiswa_nim], [judul], [tempat], [url], [tanggal_mulai], [tanggal_akhir], [jumlah_instansi], [jumlah_peserta], [file_sertifikat], [file_poster], [file_photo_kegiatan], [score], [tingkat_id], [peringkat_id])
VALUES
	( N'2341720201', N'Kompetisi Matematika', N'Jakarta', N'http://example.com/matematika', '2018-01-10', '2018-01-12', 5, 50, N'sertifikat_matematika.pdf', N'poster_matematika.jpg', N'photo_matematika.jpg', 5000, 1, 1),
	( N'2341720202', N'Lomba Sains', N'Bandung', N'http://example.com/sains', '2018-02-15', '2018-02-17', 4, 40, N'sertifikat_sains.pdf', N'poster_sains.jpg', N'photo_sains.jpg', 4800, 2, 2),
	( N'2341720203', N'Kompetisi Debat', N'Surabaya', N'http://example.com/debat', '2018-03-20', '2018-03-22', 3, 30, N'sertifikat_debat.pdf', N'poster_debat.jpg', N'photo_debat.jpg', 4600, 3, 3),
	( N'2341720204', N'Lomba Catur', N'Malang', N'http://example.com/catur', '2018-04-25', '2018-04-27', 2, 20, N'sertifikat_catur.pdf', N'poster_catur.jpg', N'photo_catur.jpg', 4400, 4, 4),
	( N'2341720205', N'Kompetisi Menulis', N'Yogyakarta', N'http://example.com/menulis', '2018-05-30', '2018-06-01', 1, 10, N'sertifikat_menulis.pdf', N'poster_menulis.jpg', N'photo_menulis.jpg', 4200, 1, 5),
	( N'2341720206', N'Lomba Fotografi', N'Semarang', N'http://example.com/fotografi', '2018-06-05', '2018-06-07', 5, 50, N'sertifikat_fotografi.pdf', N'poster_fotografi.jpg', N'photo_fotografi.jpg', 4000, 2, 6),
	( N'2341720207', N'Kompetisi Musik', N'Jakarta', N'http://example.com/musik', '2018-07-10', '2018-07-12', 4, 40, N'sertifikat_musik.pdf', N'poster_musik.jpg', N'photo_musik.jpg', 3800, 3, 2),
	( N'2341720208', N'Lomba Tari', N'Bandung', N'http://example.com/tari', '2018-08-15', '2018-08-17', 3, 30, N'sertifikat_tari.pdf', N'poster_tari.jpg', N'photo_tari.jpg', 3600, 4, 5),
	( N'2341720209', N'Kompetisi Drama', N'Surabaya', N'http://example.com/drama', '2018-09-20', '2018-09-22', 2, 20, N'sertifikat_drama.pdf', N'poster_drama.jpg', N'photo_drama.jpg', 3400, 1, 1),
	( N'2341720210', N'Lomba Pidato', N'Malang', N'http://example.com/pidato', '2018-10-25', '2018-10-27', 1, 10, N'sertifikat_pidato.pdf', N'poster_pidato.jpg', N'photo_pidato.jpg', 3200, 2, 2),
	( N'2341720211', N'Kompetisi Puisi', N'Yogyakarta', N'http://example.com/puisi', '2018-11-30', '2018-12-01', 5, 50, N'sertifikat_puisi.pdf', N'poster_puisi.jpg', N'photo_puisi.jpg', 3000, 3, 3),
	( N'2341720212', N'Lomba Melukis', N'Semarang', N'http://example.com/melukis', '2019-01-10', '2019-01-12', 4, 40, N'sertifikat_melukis.pdf', N'poster_melukis.jpg', N'photo_melukis.jpg', 2800, 4, 3),
	( N'2341720213', N'Kompetisi Renang', N'Jakarta', N'http://example.com/renang', '2019-02-15', '2019-02-17', 3, 30, N'sertifikat_renang.pdf', N'poster_renang.jpg', N'photo_renang.jpg', 2600, 1, 1),
	( N'2341720214', N'Lomba Lari', N'Bandung', N'http://example.com/lari', '2019-03-20', '2019-03-22', 2, 20, N'sertifikat_lari.pdf', N'poster_lari.jpg', N'photo_lari.jpg', 2400, 2, 3),
	( N'2341720215', N'Kompetisi Sepak Bola', N'Surabaya', N'http://example.com/sepak_bola', '2019-04-25', '2019-04-27', 1, 10, N'sertifikat_sepak_bola.pdf', N'poster_sepak_bola.jpg', N'photo_sepak_bola.jpg', 2200, 3, 4),
	( N'2341720201', N'Lomba Voli', N'Malang', N'http://example.com/voli', '2019-05-30', '2019-06-01', 5, 50, N'sertifikat_voli.pdf', N'poster_voli.jpg', N'photo_voli.jpg', 2000, 4, 4),
	( N'2341720202', N'Kompetisi Tenis', N'Yogyakarta', N'http://example.com/tenis', '2019-06-05', '2019-06-07', 4, 40, N'sertifikat_tenis.pdf', N'poster_tenis.jpg', N'photo_tenis.jpg', 1800, 1, 1),
	( N'2341720203', N'Lomba Badminton', N'Semarang', N'http://example.com/badminton', '2019-07-10', '2019-07-12', 3, 30, N'sertifikat_badminton.pdf', N'poster_badminton.jpg', N'photo_badminton.jpg', 1600, 2, 1),
	( N'2341720204', N'Kompetisi Panahan', N'Jakarta', N'http://example.com/panahan', '2019-08-15', '2019-08-17', 2, 20, N'sertifikat_panahan.pdf', N'poster_panahan.jpg', N'photo_panahan.jpg', 1400, 3, 2),
	( N'2341720205', N'Lomba Anggar', N'Bandung', N'http://example.com/anggar', '2019-09-20', '2019-09-22', 1, 10, N'sertifikat_anggar.pdf', N'poster_anggar.jpg', N'photo_anggar.jpg', 1200, 4, 5),
	( N'2341720206', N'Kompetisi Karate', N'Surabaya', N'http://example.com/karate', '2019-10-25', '2019-10-27', 5, 50, N'sertifikat_karate.pdf', N'poster_karate.jpg', N'photo_karate.jpg', 1000, 1, 1),
	( N'2341720207', N'Lomba Judo', N'Malang', N'http://example.com/judo', '2019-11-30', '2019-12-01', 4, 40, N'sertifikat_judo.pdf', N'poster_judo.jpg', N'photo_judo.jpg', 800, 2, 2),
	( N'2341720208', N'Kompetisi Taekwondo', N'Yogyakarta', N'http://example.com/taekwondo', '2020-01-10', '2020-01-12', 3, 30, N'sertifikat_taekwondo.pdf', N'poster_taekwondo.jpg', N'photo_taekwondo.jpg', 600, 3, 4),
	( N'2341720209', N'Lomba Silat', N'Semarang', N'http://example.com/silat', '2020-02-15', '2020-02-17', 2, 20, N'sertifikat_silat.pdf', N'poster_silat.jpg', N'photo_silat.jpg', 400, 4, 2),
	( N'2341720210', N'Kompetisi Wushu', N'Jakarta', N'http://example.com/wushu', '2020-03-20', '2020-03-22', 1, 10, N'sertifikat_wushu.pdf', N'poster_wushu.jpg', N'photo_wushu.jpg', 200, 1, 1),
	( N'2341720211', N'Lomba Gulat', N'Bandung', N'http://example.com/gulat', '2020-04-25', '2020-04-27', 5, 50, N'sertifikat_gulat.pdf', N'poster_gulat.jpg', N'photo_gulat.jpg', 100, 2, 2),
	( N'2341720212', N'Kompetisi Angkat Besi', N'Surabaya', N'http://example.com/angkat_besi', '2020-05-30', '2020-06-01', 4, 40, N'sertifikat_angkat_besi.pdf', N'poster_angkat_besi.jpg', N'photo_angkat_besi.jpg', 50, 3, 2),
	( N'2341720213', N'Lomba Tinju', N'Malang', N'http://example.com/tinju', '2020-06-05', '2020-06-07', 3, 30, N'sertifikat_tinju.pdf', N'poster_tinju.jpg', N'photo_tinju.jpg', 25, 4, 2),
	( N'2341720214', N'Kompetisi Sepeda', N'Yogyakarta', N'http://example.com/sepeda', '2020-07-10', '2020-07-12', 2, 20, N'sertifikat_sepeda.pdf', N'poster_sepeda.jpg', N'photo_sepeda.jpg', 10, 1, 1),
	( N'2341720215', N'Lomba Skateboard', N'Semarang', N'http://example.com/skateboard', '2020-08-15', '2020-08-17', 1, 10, N'sertifikat_skateboard.pdf', N'poster_skateboard.jpg', N'photo_skateboard.jpg', 5, 2, 1)
GO



INSERT INTO [dbo].[verifikasis]
	([mahasiswa_nim], [dosen_nip], [admin_id], [penghargaan_id], [verif_admin], [pesan_admin], [verif_pembimbing], [pesan_pembimbing], [verifed_at])
VALUES

	-- Fully verified achievements
	(N'2341720203', N'12345678', 1, 1, N'Terverifikasi', N'Dokumen lengkap dan valid', N'Terverifikasi', N'Prestasi sangat baik', GETDATE()),
	(N'2341720203', N'87654321', 2, 2, N'Terverifikasi', N'Berkas sesuai ketentuan', N'Terverifikasi', N'Pencapaian membanggakan', GETDATE()),
	(N'2341720202', N'11223344', 1, 3, N'Terverifikasi', N'Data sudah sesuai', N'Terverifikasi', N'Pertahankan prestasi', GETDATE()),

	-- Partially verified (admin approved, pembimbing processing)
	(N'2341720202', N'44332211', 3, 4, N'Terverifikasi', N'Dokumen lengkap', N'DiProses', N'Sedang dalam peninjauan', NULL),
	(N'2341720201', N'55667788', 2, 5, N'Terverifikasi', N'Berkas valid', N'DiProses', N'Menunggu verifikasi final', NULL),

	-- Partially verified (pembimbing approved, admin processing)
	(N'2341720203', N'88776655', 4, 6, N'DiProses', N'Sedang direview', N'Terverifikasi', N'Prestasi layak diakui', NULL),
	(N'2341720202', N'99887766', 1, 7, N'DiProses', N'Dalam peninjauan', N'Terverifikasi', N'Pencapaian sesuai standar', NULL),

	-- Rejected by admin
	(N'2341720201', N'66778899', 5, 8, N'DiTolak', N'Dokumen tidak lengkap', N'DiProses', N'Masih dalam review', NULL),
	(N'2341720201', N'22334455', 2, 9, N'DiTolak', N'Berkas kadaluarsa', N'Terverifikasi', N'Prestasi baik', NULL),

	-- Rejected by pembimbing
	(N'2341720202', N'55443322', 3, 10, N'DiProses', N'Sedang diverifikasi', N'DiTolak', N'Data tidak sesuai', NULL),

	-- Rejected by admin and pembimbing
	(N'2341720203', N'55443322', 4, 11, N'DiTolak', N'Dokumen tidak valid', N'DiTolak', N'Prestasi tidak sesuai', NULL),
	(N'2341720201', N'12345678', 1, 12, N'Terverifikasi', N'Dokumen lengkap dan valid', N'Terverifikasi', N'Prestasi sangat baik', '2018-01-10'),
	(N'2341720202', N'87654321', 2, 13, N'Terverifikasi', N'Berkas sesuai ketentuan', N'Terverifikasi', N'Pencapaian membanggakan', '2018-02-15'),
	(N'2341720203', N'11223344', 3, 14, N'Terverifikasi', N'Data sudah sesuai', N'Terverifikasi', N'Pertahankan prestasi', '2018-03-20'),
	(N'2341720204', N'44332211', 4, 15, N'Terverifikasi', N'Dokumen lengkap', N'DiProses', N'Sedang dalam peninjauan', '2022-03-20'),
	(N'2341720205', N'55667788', 5, 16, N'Terverifikasi', N'Berkas valid', N'DiProses', N'Menunggu verifikasi final', NULL),
	(N'2341720206', N'88776655', 1, 17, N'DiProses', N'Sedang direview', N'Terverifikasi', N'Prestasi layak diakui', NULL),
	(N'2341720207', N'99887766', 2, 18, N'DiProses', N'Dalam peninjauan', N'Terverifikasi', N'Pencapaian sesuai standar', NULL),
	(N'2341720208', N'66778899', 3, 19, N'DiTolak', N'Dokumen tidak lengkap', N'DiProses', N'Masih dalam review', NULL),
	(N'2341720209', N'22334455', 4, 20, N'DiTolak', N'Berkas kadaluarsa', N'Terverifikasi', N'Prestasi baik', NULL),
	(N'2341720210', N'55443322', 5, 21, N'DiProses', N'Sedang diverifikasi', N'DiTolak', N'Data tidak sesuai', NULL),
	(N'2341720211', N'00998877', 1, 22, N'DiTolak', N'Dokumen tidak valid', N'DiTolak', N'Prestasi tidak sesuai', NULL),
	(N'2341720212', N'66554433', 2, 23, N'Terverifikasi', N'Dokumen lengkap dan valid', N'Terverifikasi', N'Prestasi sangat baik', '2019-01-10'),
	(N'2341720213', N'33221100', 3, 24, N'Terverifikasi', N'Berkas sesuai ketentuan', N'Terverifikasi', N'Pencapaian membanggakan', '2019-02-15'),
	(N'2341720214', N'99001122', 4, 25, N'Terverifikasi', N'Data sudah sesuai', N'Terverifikasi', N'Pertahankan prestasi', '2019-03-20'),
	(N'2341720215', N'12345678', 5, 26, N'Terverifikasi', N'Dokumen lengkap', N'DiProses', N'Sedang dalam peninjauan', NULL),
	(N'2341720201', N'87654321', 1, 27, N'Terverifikasi', N'Berkas valid', N'DiProses', N'Menunggu verifikasi final', NULL),
	(N'2341720202', N'11223344', 2, 28, N'DiProses', N'Sedang direview', N'Terverifikasi', N'Prestasi layak diakui', NULL),
	(N'2341720203', N'44332211', 3, 29, N'DiProses', N'Dalam peninjauan', N'Terverifikasi', N'Pencapaian sesuai standar', NULL),
	(N'2341720204', N'55667788', 4, 30, N'DiTolak', N'Dokumen tidak lengkap', N'DiProses', N'Masih dalam review', NULL),
	(N'2341720205', N'88776655', 5, 31, N'DiTolak', N'Berkas kadaluarsa', N'Terverifikasi', N'Prestasi baik', NULL),
	(N'2341720206', N'99887766', 1, 32, N'DiProses', N'Sedang diverifikasi', N'DiTolak', N'Data tidak sesuai', NULL),
	(N'2341720207', N'66778899', 2, 33, N'DiTolak', N'Dokumen tidak valid', N'DiTolak', N'Prestasi tidak sesuai', NULL),
	(N'2341720208', N'22334455', 3, 34, N'Terverifikasi', N'Dokumen lengkap dan valid', N'Terverifikasi', N'Prestasi sangat baik', '2021-01-10'),
	(N'2341720209', N'55443322', 4, 35, N'Terverifikasi', N'Berkas sesuai ketentuan', N'Terverifikasi', N'Pencapaian membanggakan', '2020-02-15'),
	(N'2341720210', N'00998877', 5, 36, N'Terverifikasi', N'Data sudah sesuai', N'Terverifikasi', N'Pertahankan prestasi', '2020-03-20'),
	(N'2341720211', N'66554433', 1, 37, N'Terverifikasi', N'Dokumen lengkap', N'DiProses', N'Sedang dalam peninjauan', NULL),
	(N'2341720212', N'33221100', 2, 38, N'Terverifikasi', N'Berkas valid', N'DiProses', N'Menunggu verifikasi final', NULL),
	(N'2341720213', N'99001122', 3, 39, N'DiProses', N'Sedang direview', N'Terverifikasi', N'Prestasi layak diakui', NULL),
	(N'2341720214', N'12345678', 4, 40, N'DiProses', N'Dalam peninjauan', N'Terverifikasi', N'Pencapaian sesuai standar', NULL),
	(N'2341720215', N'87654321', 5, 41, N'DiTolak', N'Dokumen tidak lengkap', N'DiProses', N'Masih dalam review', NULL)
GO

UPDATE [dbo].[dosens] SET [score] = 2500 WHERE [nip] = 12345678
UPDATE [dbo].[dosens] SET [score] = 3000 WHERE [nip] = 87654321
UPDATE [dbo].[dosens] SET [score] = 2000 WHERE [nip] = 11223344
UPDATE [dbo].[dosens] SET [score] = 2800 WHERE [nip] = 44332211
UPDATE [dbo].[dosens] SET [score] = 2600 WHERE [nip] = 55667788
UPDATE [dbo].[dosens] SET [score] = 2300 WHERE [nip] = 88776655
UPDATE [dbo].[dosens] SET [score] = 3200 WHERE [nip] = 99887766
UPDATE [dbo].[dosens] SET [score] = 2900 WHERE [nip] = 66778899
UPDATE [dbo].[dosens] SET [score] = 2100 WHERE [nip] = 22334455
UPDATE [dbo].[dosens] SET [score] = 2700 WHERE [nip] = 55443322
UPDATE [dbo].[dosens] SET [score] = 2400 WHERE [nip] = 77889900
UPDATE [dbo].[dosens] SET [score] = 2200 WHERE [nip] = 00998877
UPDATE [dbo].[dosens] SET [score] = 3100 WHERE [nip] = 66554433
UPDATE [dbo].[dosens] SET [score] = 2500 WHERE [nip] = 33221100
UPDATE [dbo].[dosens] SET [score] = 2800 WHERE [nip] = 99001122
GO


-------------------Views---------------------------------------------
CREATE VIEW [dbo].[view_user_mahasiswa]
AS
	SELECT
		u.id AS user_id,
		u.username,
		u.password,
		u.role,
		m.nim,
		m.name,
		m.gender,
		m.phone_number,
		m.status,
		m.college_year,
		m.score,
		m.photo,
		m.Alamat,
		m.Kota,
		m.Provinsi,
		m.agama,
		m.prodi_id,
		m.created_at,
		m.visible_mahasiswas
	FROM
		[dbo].[users] u
		INNER JOIN
		[dbo].[mahasiswas] m ON u.id = m.user_id
	WHERE 
    u.role = 'mahasiswa'
		AND u.visible_users = 1
		AND m.visible_mahasiswas = 1
GO

CREATE VIEW [dbo].[view_user_dosen]
AS
	SELECT
		u.id AS user_id,
		u.username,
		u.password,
		u.role,
		d.nip,
		d.name,
		d.gender,
		d.phone_number,
		d.status,
		d.photo,
		d.Alamat,
		d.Kota,
		d.Provinsi,
		d.agama,
		d.score,
		d.prodi_id,
		d.created_at,
		d.visible_dosens
	FROM
		[dbo].[users] u
		INNER JOIN
		[dbo].[dosens] d ON u.id = d.user_id
	WHERE 
    u.role = 'dosen'
		AND u.visible_users = 1
		AND d.visible_dosens = 1
GO

CREATE VIEW [dbo].[view_user_admin]
AS
	SELECT
		u.id AS user_id,
		a.id AS admin_id,
		u.username,
		u.password,
		u.role,
		a.name,
		a.gender,
		a.phone_number,
		a.photo,
		a.created_at,
		a.visible_admins
	FROM
		[dbo].[users] u
		INNER JOIN
		[dbo].[admins] a ON u.id = a.user_id
	WHERE 
    u.role = 'admin'
		AND u.visible_users = 1
		AND a.visible_admins = 1
GO

-------------------Triggers---------------------------------------------
CREATE TRIGGER trg_AfterUpdate_Mahasiswa
ON [dbo].[mahasiswas]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE u
    SET u.visible_users = 0
    FROM [dbo].[users] u
		INNER JOIN inserted i ON u.id = i.user_id
    WHERE i.visible_mahasiswas = 0;
END
GO


CREATE TRIGGER trg_AfterUpdate_Dosen
ON [dbo].[dosens]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE u
    SET u.visible_users = 0
    FROM [dbo].[users] u
		INNER JOIN inserted i ON u.id = i.user_id
    WHERE i.visible_dosens = 0;
END
GO

CREATE TRIGGER trg_AfterUpdate_Admin
ON [dbo].[admins]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE u
    SET u.visible_users = 0
    FROM [dbo].[users] u
		INNER JOIN inserted i ON u.id = i.user_id
	WHERE i.visible_admins = 0;
END
GO

------------------------ Hall Of Fame --------------------------------

CREATE FUNCTION dbo.fn_GetTop10MahasiswaScoresByYear(@year INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 10
	m.name AS mahasiswa_name1,
	p.nama AS prodi_name,
	YEAR(v.verifed_at) AS year,
	SUM(ph.score) AS total_score
FROM
	verifikasis v
	INNER JOIN
	penghargaans ph ON v.penghargaan_id = ph.id
	INNER JOIN
	mahasiswas m ON v.mahasiswa_nim = m.nim
	INNER JOIN
	prodis p ON m.prodi_id = p.id
WHERE 
        v.verif_admin = 'Terverifikasi'
	AND v.verif_pembimbing = 'Terverifikasi'
	AND YEAR(v.verifed_at) = @year
GROUP BY 
        m.name, p.nama, YEAR(v.verifed_at)
ORDER BY 
        total_score DESC
);
GO
CREATE FUNCTION dbo.fn_GetTop10DosenScoresByYear(@year INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 10
	d.name AS dosen_name,
	p.nama AS prodi_name,
	YEAR(v.verifed_at) AS year,
	SUM(ph.score) AS total_score
FROM
	verifikasis v
	INNER JOIN
	penghargaans ph ON v.penghargaan_id = ph.id
	INNER JOIN
	dosens d ON v.dosen_nip = d.nip
	INNER JOIN
	prodis p ON d.prodi_id = p.id
WHERE 
        v.verif_admin = 'Terverifikasi'
	AND v.verif_pembimbing = 'Terverifikasi'
	AND YEAR(v.verifed_at) = @year
GROUP BY 
        d.name, p.nama, YEAR(v.verifed_at)
ORDER BY 
        total_score DESC
);
GO
------------------------Admin Store Procedure----------------------------------------
CREATE PROCEDURE sp_GetAllVerifikasiAndPenghargaan
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		v.*,
		p.*,
		t.nama as tingkatan_nama,
		d.name as dosen_name,
		m.name as mahasiswa_name
	FROM verifikasis v
		LEFT JOIN penghargaans p ON v.penghargaan_id = p.id
		LEFT JOIN tingkatans t ON p.tingkat_id = t.id
		LEFT JOIN dosens d ON v.dosen_nip = d.nip
		LEFT JOIN mahasiswas m ON v.mahasiswa_nim = m.nim
	WHERE v.verif_admin = 'DiProses' AND v.visible_verifikasis = 1
	ORDER BY v.created_at DESC;
END
GO

CREATE PROCEDURE sp_GetAllVerifikasiAndPenghargaanOv
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		v.*,
		p.*,
		t.nama as tingkatan_nama,
		d.name as dosen_name,
		m.name as mahasiswa_name,
		per.nama as peringkat_nama,
		prod.nama as prodi_nama
	FROM verifikasis v
		LEFT JOIN penghargaans p ON v.penghargaan_id = p.id
		LEFT JOIN tingkatans t ON p.tingkat_id = t.id
		LEFT JOIN dosens d ON v.dosen_nip = d.nip
		LEFT JOIN mahasiswas m ON v.mahasiswa_nim = m.nim
		LEFT JOIN peringkats per ON p.peringkat_id = per.id
		LEFT JOIN prodis prod ON m.prodi_id = prod.id
	WHERE v.verif_admin != 'DiProses' AND v.visible_verifikasis = 1
	ORDER BY v.created_at DESC;
END
GO

CREATE PROCEDURE sp_GetVerifikasiAndPenghargaanByIdVerifikasi
	@id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		v.*,
		p.*,
		p.id as pengId,
		t.nama as tingkatan_nama,
		d.name as dosen_name,
		d.nip as dosen_nip,
		per.nama as peringkat_nama,
		m.name as mahasiswa_name,
		m.nim as nim,
		m.college_year as angkatan,
		prod.nama as prodi
	FROM verifikasis v
		LEFT JOIN penghargaans p ON v.penghargaan_id = p.id
		LEFT JOIN tingkatans t ON p.tingkat_id = t.id
		LEFT JOIN peringkats per ON p.peringkat_id = per.id
		LEFT JOIN dosens d ON v.dosen_nip = d.nip
		LEFT JOIN mahasiswas m ON v.mahasiswa_nim = m.nim
		LEFT JOIN prodis prod ON m.prodi_id = prod.id
	WHERE v.id = @id;
END
GO

------------------------------------------------admin function----------------------------------------------------------------
CREATE FUNCTION dbo.fn_GetCountTahunVerif()
RETURNS TABLE
AS
RETURN
(
    SELECT YEAR(v.verifed_at) as year, COUNT(*) AS count
FROM verifikasis v
WHERE v.verif_admin = 'Terverifikasi' AND v.verif_pembimbing = 'Terverifikasi'
GROUP BY YEAR(v.verifed_at)
);
GO

CREATE FUNCTION dbo.fn_GetCountAngkatanMahasiswa()
RETURNS TABLE
AS
RETURN
(
    SELECT m.college_year, COUNT(*) AS count
FROM verifikasis v
	INNER JOIN mahasiswas m ON v.mahasiswa_nim = m.nim
WHERE v.verif_admin = 'Terverifikasi' AND v.verif_pembimbing = 'Terverifikasi'
GROUP BY m.college_year
);
GO

