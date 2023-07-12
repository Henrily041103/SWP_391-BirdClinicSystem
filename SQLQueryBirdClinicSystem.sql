﻿/*CREATE DATABASE SWP391 before execute scripts*/
CREATE TABLE Images (
  imageID CHAR(32) NOT NULL,
  imageURLName varchar(50) NOT NULL,
  
  CONSTRAINT PK_Images PRIMARY KEY CLUSTERED 
(
	imageID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Users (
  userID CHAR(32) NOT NULL,
  imageID CHAR(32) NOT NULL,
  userName VARCHAR(30) NOT NULL,
  userPassword CHAR(32) NOT NULL,
  fullName NVARCHAR(50),
  phoneNumber CHAR(10),
  gender VARCHAR(7) NOT NULL,
  email VARCHAR(40) NOT NULL, 
  userRole VARCHAR(10) NOT NULL, 
  status_ VARCHAR(10) NOT NULL,
  FOREIGN KEY (imageID) REFERENCES Images(imageID),
  CONSTRAINT PK_Users PRIMARY KEY CLUSTERED 
(
	userID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Customer (
  customerID CHAR(32) NOT NULL,
  dob DATE,
  customerAddress NVARCHAR(70) COLLATE Vietnamese_CI_AS,
  CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (customerID ASC)
) ON [PRIMARY];

CREATE TABLE Speciality (
  specialityID CHAR(32) NOT NULL,
  specialityName VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Speciality PRIMARY KEY CLUSTERED 
(
	SpecialityID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Doctor (
  doctorID CHAR(32) NOT NULL,
  specialityID CHAR(32) NOT NULL,
  docAge TINYINT NOT NULL,
  yearsOfExperience TINYINT NOT NULL,
  academicTitle NVARCHAR(20),
  degree NVARCHAR(10),
  FOREIGN KEY (specialityID) REFERENCES Speciality(specialityID),
  CONSTRAINT PK_Doctor PRIMARY KEY CLUSTERED 
(
	doctorID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE TimeSlot (
  timeSlotID CHAR(32) NOT NULL,
  timeSlot TIME NOT NULL,
  day_ NVARCHAR(11) NOT NULL,
  CONSTRAINT PK_TimeSlot PRIMARY KEY CLUSTERED 
(
	timeSlotID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE DoctorTimeSlot (
	doctorID CHAR(32) NOT NULL,
	timeSlotID CHAR(32) NOT NULL,
	FOREIGN KEY (timeSlotID) REFERENCES TimeSlot(timeSlotID),
	FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID),
)

CREATE TABLE Medicine (
  medicineID CHAR(32) NOT NULL,
  medicineName NVARCHAR(30) NOT NULL,
  medicinePrice DECIMAL(10, 2) NOT NULL,
  unit CHAR (13) NOT NULL,
  CONSTRAINT PK_Medicine PRIMARY KEY CLUSTERED 
(
	medicineID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Service_ (
  serviceID CHAR(32) NOT NULL,
  specialityID CHAR(32) NOT NULL,
  serviceName VARCHAR(60) NOT NULL,
  servicePrice DECIMAL(9, 2) NOT NULL,
  FOREIGN KEY (specialityID) REFERENCES Speciality(specialityID),
  CONSTRAINT PK_Service_ PRIMARY KEY CLUSTERED 
(
	serviceID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Bird (
  birdID CHAR(32) NOT NULL,
  customerID CHAR(32),
  imageID CHAR(32) NOT NULL,
  birdFullname NVARCHAR(30) NOT NULL,
  birdGender VARCHAR(6) NOT NULL,
  breed NVARCHAR(20) NOT NULL,
  band_chip CHAR(6),
  birdWeight FLOAT NOT NULL,
  sexingMethod VARCHAR(60) NOT NULL,
  medicalHistory NVARCHAR(60),
  hatchingDate DATE NOT NULL,
  featherColor NVARCHAR(50) NOT NULL,
  FOREIGN KEY (customerID) REFERENCES Customer(customerID),
  FOREIGN KEY (imageID) REFERENCES Images(imageID),
  CONSTRAINT PK_Bird PRIMARY KEY CLUSTERED 
(
	birdID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Appointment (
  appointmentID CHAR(32) NOT NULL,
  birdID CHAR(32) NOT NULL,
  doctorID CHAR(32),
  timeSlotID CHAR(32) NOT NULL,
  serviceID CHAR(32) NOT NULL,
  appTime DATE NOT NULL,
  notes NVARCHAR(200),
  payment NVARCHAR(20),
  appStatus VARCHAR(20) NOT NULL,
  FOREIGN KEY (birdID) REFERENCES Bird(birdID),
  FOREIGN KEY (doctorID) REFERENCES Doctor(doctorID),
  FOREIGN KEY (timeSlotID) REFERENCES TimeSlot(timeSlotID),
  FOREIGN KEY (serviceID) REFERENCES Service_(serviceID),
  CONSTRAINT PK_Appointment PRIMARY KEY CLUSTERED 
(
	appointmentID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE AppointmentCancel (
	appointmentID CHAR(32) NOT NULL,
	reason NVARCHAR (100) NOT NULL,
	FOREIGN KEY (appointmentID) REFERENCES Appointment(appointmentID),
	)

CREATE TABLE MedicalRecord (
  medicalRecordID CHAR(32) NOT NULL,
  appointmentID CHAR(32) NOT NULL,
  recordTime DATETIME NOT NULL,
  diagnosis NVARCHAR(100) NOT NULL,
  treatmentDays int NOT NULL,
  doctorNotes nvarchar(300),
  FOREIGN KEY (appointmentID) REFERENCES Appointment(appointmentID),
  CONSTRAINT PK_MedicalRecord PRIMARY KEY CLUSTERED 
(
	medicalrecordID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE RecordServices (
  medicalRecordID CHAR(32) NOT NULL,
  serviceID CHAR(32) NOT NULL,
  FOREIGN KEY (medicalRecordID) REFERENCES MedicalRecord(medicalRecordID),
  FOREIGN KEY (serviceID) REFERENCES service_(serviceID),
)

CREATE TABLE RecordMedicine (
  medicalRecordID CHAR(32) NOT NULL,
  medicineID CHAR(32) NOT NULL,
  quantity INT NOT NULL,
  description_ NVARCHAR(200),
  FOREIGN KEY (medicalRecordID) REFERENCES MedicalRecord(medicalRecordID),
  FOREIGN KEY (medicineID) REFERENCES Medicine(medicineID)
);

CREATE TABLE Feedback (
  feedbackID CHAR(32) NOT NULL,
  appointmentID CHAR(32) NOT NULL,
  feedbackContent NVARCHAR(500) NOT NULL,
  title NVARCHAR(100) NOT NULL,
  feedbackTime DATETIME NOT NULL,
  rating DECIMAL(2, 1) NOT NULL,
  FOREIGN KEY (appointmentID) REFERENCES Appointment(appointmentID),
  CONSTRAINT PK_Feedback PRIMARY KEY CLUSTERED 
  (
    feedbackID ASC
  ),
  CONSTRAINT UC_AppointmentID UNIQUE (appointmentID)
) ON [PRIMARY];

CREATE TABLE Blog (
  blogID CHAR(32) NOT NULL,
  title NVARCHAR(100) NOT NULL,
  uploadDatetime DATETIME NOT NULL,
  category NVARCHAR(50) NOT NULL,
  blogContent NVARCHAR(MAX) NOT NULL,
  CONSTRAINT PK_Blog PRIMARY KEY CLUSTERED 
(
	blogID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO Images(imageID, imageURLName)
VALUES
    ('4twgbi3qw84bgqhorwoee83hf93jj30f', 'admin.jpg'),
	('janfa98h943ghafa92rhfuewhfnhfn3g', 'malecustomerdefault.png'),
	('gha948ga489hra3r9fh32f32f9838r93', 'femalecustomerdefault.png'),
    ('janfuewhfnhfn3ga98h943ghafa92rhf', 'malecustomer1.jpg'),
	('jan92rhffuewhfnhfn3ga98h943ghafa', 'malecustomer2.jpg'),
	('jhfnhfn3anfuewga98h943ghafa92rhf', 'malecustomer3.jpg'),
	('janfuewhhafa92rfnhfn3ga98h943ghf', 'malecustomer4.jpg'),
	('hfnhfn3ga98h94janfuew3ghafa92rhf', 'malecustomer5.jpg'),
	('janfuewhfnhfafa92n3ga98h943ghrhf', 'malecustomer6.jpg'),
	('jfnhfn3ga98h9anfuewh43ghafa92rhf', 'malecustomer7.jpg'),
	('whfnhfn3ga98h943ghjanfueafa92rhf', 'malecustomer8.jpg'),
	('janfuewh8h943ghaffnhfn3ga9a92rhf', 'malecustomer9.jpg'),
	('uewh8h943ghaffnhfnjanf3ga9a92rhf', 'malecustomer10.jpg'),
	('fn3ga9aewjanfun92rhfhh8h943ghaff', 'malecustomer11.jpg'),
	('h8ewa9a92rhfaffnhfnh943ghfu3gjan', 'malecustomer12.jpg'),
	('ga98h943ghjanwhfnhfn3fueafa92rhf', 'femalecustomer1.jpg'),
	('3ghjanwhfnga98h94hfn3fueafa92rhf', 'femalecustomer2.jpg'),
	('gnhfn3a98h943ghjanwhffueafa92rhf', 'femalecustomer3.jpg'),
	('hjanwhfnhfn3ga98h943gfueafa92rhf', 'femalecustomer4.jpg'),
	('ga98h943gfueafhjanwhfnhfn3a92rhf', 'femalecustomer5.jpg'),
	('gahjanwhfnhfn3fuea98h943gfa92rhf', 'femalecustomer6.jpg'),
	('gaafa9298h943ghjanwhfnhfn3fuerhf', 'femalecustomer7.jpg'),
	('anwhga98h943ghjfnhfn3fueafa92rhf', 'femalecustomer8.jpg'),
	('ga98hfnhfn3fueaf943ghjanwha92rhf', 'femalecustomer9.jpg'),
    ('nanwha92r943ghga98hfnh3fueaffjhf', 'femalecustomer10.jpg'),
	('hga98hfnhfn3a92rhfueaf943ghjanwf', 'femalecustomer11.jpg'),
	('hfn3fueaf94gajanwha932rhf98hfngh', 'femalecustomer12.jpg'),
	('rhaanwha928hfnhff943ghjga9fue3nf', 'femalecustomer13.jpg'),
	('3ghjga9frf94aanwhavfnhf928hue3nf', 'femalecustomer14.jpg'),
    ('fhawfbwa98fha98hf9na9uwbga9ubvg9', 'lgbtcustomer.jpg'),
	('f7384hfw34f38wb4fw38h4f03h43f93f', 'malestaff.jpg'),
	('ngseriug908hg93h4g934nf34f938f4h', 'femalestaff.jpg'),
	('cjndsjkcfnzslkjvnawjefn8jfh38fu3', 'bs1.png'),
	('vnaeojvner9gh39g4waofh28f28hfa93', 'bs2.png'),
	('fhafgbyfg87gf83bfiwifhweufhwe5g5', 'bs3.png'),
	('g73f93hf9bwfb3v384ub83bg3487fb43', 'bs4.jpg'),
	('biserhbf9473hf9b94gb49f93f38f984', 'bs5.jpg'),
	('gsbheirbfg7a843hgfa943bfu9fb3f93', 'bs6.png'),
	('fbriehafbihfa7hfa3hf983hf98qff82', 'bs7.jpg'),
	('rfhiarebfniuaerhnfuah9f48h34f843', 'bs8.png'),
	('fherajfhriuehfraufha94hf98fh93hf', 'bs9.png'),
	('fnerajfha974fhy4973haf9ha49hf338', 'bs10.jpg'),
	('0fe30e1ff175eb1c538613084ab12417', 'bs11.jpg'),
    ('fafnbuhfauhfweoufha8hfa9hfa48hf8', 'chimyen.png'),
    ('avewifbaiuwefnwajenfhiuahenf998f', 'chimcongxanh.jpg'),
	('fewabf9qb439fufh9h438q9h34fq34t4', 'chimen.jpg'),
	('frheafiuewhf9hf983h3f4ha438f94f4', 'chimtri.jpg'),
	('4rt43t5y56y465t4r3e24r435y65u76i', 'chimse.jpg'),
	('efrgtrytuiykjhmngfbvdfewr4567898', 'chimhongyen.jpg'),
	('48c967910f7eb39ea5f7b7602a3df9ea', 'chimhactrang.jpg'),
	('3b94ace86063b245916a6e906221e6a8', 'chimkhuyentrang.jpg'),
	('249fb9cb11171ae6ab41794bee070a8f', 'chimyenphung.jpg'),
	('b3b9752ec51a5433b44e27b8d9b81c76', 'chimbocau.jpg'),
	('ee38603c9cfdb54fb0a0ab4a197f92a3', 'chimvet.jpg'),
	('ef94fe9d57eed266b24c3fc1203c1e17', 'chimhoangyen.jpg'),
	('a8cf052632950deb5ab9c1f5ec36334d', 'chimchichchoelua.png'),
	('7b1bc65da7abbaceaaadc0ea9564c175', 'chimchaomao.png'),
	('95f7e5a8c051e6b60905912bd8aedf7d', 'chimoanhcodo.png'),
	('365c43bd856cf86e0e0b4cd4b7bc0462', 'chimkhuoubacma.png'),
	('b51f1bb2e54d243e60e32563b2b1a7ed', 'chimchichbong.png'),
	('08eed66a05827e8dc02d6ff1392f9bf6', 'chimdiecdauden.png'),
	('ddfff0e1f9009fe5d621e2ed07348a51', 'chimcuccu.png'),
	('cbe26c3a3f34407ed023e3f02399d2fa', 'chimnhanden.png'),
	('05b5b4345d8ac2f73ece3df15be03230', 'chimhoamidongco.png'),
	('2bda592b2aada870747dd4366a3dff18', 'chimnhantrang.png'),
	('e28e1458f599f2391b91bfd61338483e', 'chimbimbipdongduong.png'),
	('84cb52eda2e4f0b66f8509c37e857e8c', 'chimsaobungden.png'),
	('8721d5a5f3f44bd01529d24dcf519239', 'chimchiavoihongtrang.png'),
	('66a5473e01debb47bff7f215d6c4a228', 'Chimcatmindoro.png'),
	('6d47ad177fb45c2d87e1b54fc363676b', 'Chimdopruoicamden.png'),
	('25abf9603856427e295b7bd1137fd04a', 'chimvetnammy.png'),
	('ed1ed3634186fc66ee692da3ba98272f' , 'chimsonca.png'),
	('e47ccaddaa9e2cd4c25e84cae624b077' , 'chimvanganh.png');

-- Insert data into the Users table
INSERT INTO Users (userID, imageID, userName, userPassword, fullName, phoneNumber, gender, email, userRole, status_)
VALUES
    ('df906a974056cd590d0b9fc4ddc37c22', '4twgbi3qw84bgqhorwoee83hf93jj30f', 'tiendkmSE172051', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Kim Minh Tiến', '0987896754', 'male', 'tiendkmse172051@fpt.edu.vn', 'admin', 'active' ),
    ('2c9320b8639fc9e1c784880bbecfdfa1', 'janfa98h943ghafa92rhfuewhfnhfn3g', 'tuanntaSE140515', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Thanh Anh Tuấn', '0748195317', 'male', 'tuanntase140515@fpt.edu.vn', 'customer', 'active' ),
    ('3ff56e23cc31e9c9a85bc037341a65ee', 'janfa98h943ghafa92rhfuewhfnhfn3g', 'bachnhSE172021', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Huy Bách', '0987656788', 'male', 'bachnhSE172021@fpt.edu.vn', 'customer', 'active' ),
	('3ff5njfnijhfdsf8845bc037341a65ee', 'janfa98h943ghafa92rhfuewhfnhfn3g', 'minhdnaSE172977', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đặng Võ Anh Minh', '0876549456', 'male', 'minhdnaSE172977@fpt.edu.vn', 'customer', 'active' ),
	('82d5cf38dc655bd1722ac5d4d350bce3', 'janfa98h943ghafa92rhfuewhfnhfn3g', 'PhuctqhSE171472', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trương Quang Hồng Phúc', '0897412324', 'male', 'PhuctqhSE171472@fpt.edu.vn', 'customer', 'active' ),
	('1c4f04058f291642c159e27e1554ddf8', 'janfa98h943ghafa92rhfuewhfnhfn3g', 'anptSE172048', '5f4dcc3b5aa765d61d8327deb882cf99', N'Phan Thiên Ân', '0987656788', 'male', 'anptSE172048@fpt.edu.vn', 'customer', 'active' ),
	('c0637bb4f3d7531d936f2686b9672a66', 'janfuewhfnhfn3ga98h943ghafa92rhf', 'nghoangphuc01', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Hoàng Phúc', '1234567890', 'male', 'phucnh01@gmail.com', 'customer', 'banned' ),
    ('11eee90acf45377f4cc3ca0758f2bf30', 'janfuewhhafa92rfnhfn3ga98h943ghf', 'tuannt02ert', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Thanh Tuấn', '0987654321', 'male', 'tuannt02@gmail.com', 'customer', 'active' ),
    ('48b31829bc7599f232d06a1e686534bd', 'ga98h943ghjanwhfnhfn3fueafa92rhf', 'anhttl03edc', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Thị Lan Anh', '0123456789', 'unknown', 'anhttl03@gmail.com', 'customer', 'active' ),
    ('4e192dacb208ceb2413376e2ad3b3db8', '3ghjga9frf94aanwhavfnhf928hue3nf', 'rienglt01', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lê Thị Riêng', '9876543210', 'female', 'riengtl01@gmail.com', 'customer', 'active' ),
    ('6cb9c7dba65dd3d9e1946c5dd265dbcd', 'jan92rhffuewhfnhfn3ga98h943ghafa', 'hungnm02nbv', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Mạnh Hùng', '5678901234', 'male', 'hungnm02@gmail.com', 'customer', 'banned' ),
	('45b76de8eb0fd35e124955a2ff2473db', '3ghjanwhfnga98h94hfn3fueafa92rhf', 'thaophy04', '5f4dcc3b5aa765d61d8327deb882cf99', N'Phan Hồng Yến Thảo', '6565743635', 'female', 'thaophy04@gmail.com', 'customer', 'banned' ),
    ('ea03ec90c8836f413784ee96e50a4f11', 'gnhfn3a98h943ghjanwhffueafa92rhf', 'toanhm07cvb', '5f4dcc3b5aa765d61d8327deb882cf99', N'Huỳnh Minh Toàn', '0976534156', 'male', 'toanmt07@gmail.com', 'customer', 'active' ),
    ('bc6c32dbbb8bd0660d158b08d7cad96f', 'hfnhfn3ga98h94janfuew3ghafa92rhf', 'haileduc56', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lê Đức Hải', '0965783451', 'unknown', 'haild56@gmail.com', 'customer', 'active' ),
    ('7e55fcb3a457634cfa78b49bdb774b3a', 'nanwha92r943ghga98hfnh3fueaffjhf', 'yennth09jkl', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Thị Hải Yến', '0914135352', 'female', 'yennth09@gmail.com', 'customer', 'active' ),
    ('d8869200b4fbde66a3475d6e730e1b6d', 'janfuewhfnhfafa92n3ga98h943ghrhf', 'minhngtr04', '5f4dcc3b5aa765d61d8327deb882cf99', 'Nguyên Khôi', '0765678234', 'male', 'minhngtr04@gmail.com', 'customer', 'banned' ),
	('128ce6812392dce1ca5a6919f03a26a2', 'hga98hfnhfn3a92rhfueaf943ghjanwf', 'thuthitran06', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Thị Thu', '0908070605', 'female', 'thuthitran06@gmail.com', 'customer', 'banned' ),
    ('87ccfc84f4eb846b5aeb0e04f6ea12ea', 'uewh8h943ghaffnhfnjanf3ga9a92rhf', 'bayvanng08', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Văn Bảy', '0990807067', 'male', 'bayvanng08@gmail.com', 'customer', 'active' ),
    ('715c43d86b98da2212d7a9c9ce9d3062', 'jfnhfn3ga98h9anfuewh43ghafa92rhf', 'phattrduc04', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Đức Phát', '0975432654', 'unknown', 'phattrduc04@gmail.com', 'customer', 'banned' ),
    ('a69b4087d281cb16efaa6bc91308f64d', 'hjanwhfnhfn3ga98h943gfueafa92rhf', 'giangngquy03', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Quỳnh Giang', '0914153645', 'female', 'giangngquy03@gmail.com', 'customer', 'active' ),
    ('61dd2b9c89fdcc1dce9fb553bf29cd8d', 'fn3ga9aewjanfun92rhfhh8h943ghaff', 'minhngqua07', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Quang Minh', '0998877665', 'male', 'minhngqua07@gmail.com', 'customer', 'active' ),
	('03b016eef369ef40bba639aa4f04341b', 'hfn3fueaf94gajanwha932rhf98hfngh', 'anhtrdan06ewq', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đặng Trâm Anh', '0908866442', 'female', 'anhtrdan06@gmail.com', 'customer', 'active' ),
    ('f8b0ed4e38a71924a7d2bca97029778a', 'whfnhfn3ga98h943ghjanfueafa92rhf', 'datquocle05', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lê Quốc Đạt', '0913254465', 'male', 'datqule05@gmail.com', 'customer', 'banned' ),
    ('5cbae581d99c1c3d17b8c09b07c54892', 'fhawfbwa98fha98hf9na9uwbga9ubvg9', 'yenkinguy45', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Kim Yến', '0914253647', 'unknown', 'yenkinguy45@gmail.com', 'customer', 'active' ),
    ('20e843f249d75ada67c1a2eef0dac92e', 'ga98h943gfueafhjanwhfnhfn3a92rhf', 'kimletha45', '5f4dcc3b5aa765d61d8327deb882cf99', 'Lê Thanh Kim', '0912233445', 'female', 'kimletha45@gmail.com', 'customer', 'banned' ),
    ('712da4f1096f6ae70d0f3c091b84ae7c', 'h8ewa9a92rhfaffnhfnh943ghfu3gjan', 'phucngminh17', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Minh Phúc', '0945566748', 'male', 'phucngminh17@gmail.com', 'customer', 'active' ),
	('b03c6f5a51ee06d3dbd17d0e38507ede', 'gahjanwhfnhfn3fuea98h943gfa92rhf', 'vyngphuo57qwe', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Phương Vy', '0908123452', 'female', 'vyngphuo57@gmail.com', 'customer', 'active' ),
    ('b83bb75b898592b75232c4816842d824', 'janfuewh8h943ghaffnhfn3ga9a92rhf', 'longngvu14zxc', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Vũ Long', '0987432456', 'male', 'longngvu14@gmail.com', 'customer', 'active' ),
    ('a68757602ea7419f0e2313a842be9abf', 'fhawfbwa98fha98hf9na9uwbga9ubvg9', 'ngocvanng45', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Văn Ngọc', '0965478154', 'unknown', 'ngocvanng45@gmail.com', 'customer', 'active' ),
    ('2b1850783245c06d0b782a4c9cd6a0a0', 'gaafa9298h943ghjanwhfnhfn3fuerhf', 'tratrthihuo37', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Thị Hương Trà', '9876543210', 'female', 'tratrthihuo37@gmail.com', 'customer', 'banned' ),
    ('eb70ed9c4c32afea8f482dc873be4f6a', 'rhaanwha928hfnhff943ghjga9fue3nf', 'tranglethihuo75', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lê Thị Hương Trang', '0904534256', 'female', 'tranglethihuo75@gmail.com', 'customer', 'active' ),
	('ae114dac5897fbcfd25797bf4be08fd3', 'cjndsjkcfnzslkjvnawjefn8jfh38fu3', 'yentrthith87', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Thị Thanh Yến', '0789145356', 'female', 'yentrthith87@gmail.com', 'doctor', 'active' ),
	('9eae70b054be6eba305323d8c9106cfb', 'vnaeojvner9gh39g4waofh28f28hfa93', 'anhdongtr09', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đỗ Nguyễn Trâm Anh', '0345762433', 'female', 'anhdongtr09@gmail.com', 'doctor', 'active' ),
	('c8aa14ffb7da0912c84635aa2ee0bb62', 'fhafgbyfg87gf83bfiwifhweufhwe5g5', 'anhdoquynh35', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đỗ Quỳnh Anh', '0543749273', 'female', 'anhdoquynh35@gmail.com', 'doctor', 'active' ),
	('dd0e3f50648088bfecc501f809a06ca8', 'g73f93hf9bwfb3v384ub83bg3487fb43', 'tiennamtr36', '5f4dcc3b5aa765d61d8327deb882cf99', N'Trần Nam Tiến', '0546328472', 'male', 'tiennamtr36@gmail.com', 'doctor', 'active' ),
	('62fe46dae9470f311d52973a6eeb6a1a', 'biserhbf9473hf9b94gb49f93f38f984', 'anhquochoa67', '5f4dcc3b5aa765d61d8327deb882cf99', N'Hoàng Quốc Anh', '0534732843', 'male', 'anhquochoa67@gmail.com', 'doctor', 'active' ),
	('9c6189a20beb35a93df963e3b48eb9b0', 'gsbheirbfg7a843hgfa943bfu9fb3f93', 'sangkim16abcd', '5f4dcc3b5aa765d61d8327deb882cf99', N'Ngô Kim Sa', '0534254324', 'female', 'sangkim16@gmail.com', 'doctor', 'active' ),
	('1c38dd30f9e415b3a34879be077381ce', 'fbriehafbihfa7hfa3hf983hf98qff82', 'taileanh78xyz', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lê Anh Tài', '0523423234', 'male', 'taileanh78@gmail.com', 'doctor', 'active' ),
	('21fc9daf44e2637d7972bd248c83577d', 'rfhiarebfniuaerhnfuah9f48h34f843', 'nhiluoman19rty', '5f4dcc3b5aa765d61d8327deb882cf99', N'Lương Mẫn Nhi', '0556475242', 'female', 'nhiluoman19@gmail.com', 'doctor', 'active' ),
	('01c1fa1b81297a2de21056f35303ad84', 'fherajfhriuehfraufha94hf98fh93hf', 'kietnganhmin47', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Minh Anh Kiệt', '0556253524', 'male', 'kietnganhmin47@gmail.com', 'doctor', 'active' ),
	('fe30e1ff175e10b1c538613084ab2417', 'fnerajfha974fhy4973haf9ha49hf338', 'thaodothithu64', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đoàn Thị Thu Thảo', '0534719873', 'female', 'thaodothithu64@gmail.com', 'doctor', 'active' ),
	('0fe30e184ab12417ff175eb1c5386130', '0fe30e1ff175eb1c538613084ab12417', 'dungdomanh57', '5f4dcc3b5aa765d61d8327deb882cf99', N'Đỗ Mạnh Dũng', '0512345946', 'male', 'dungdomanh57@gmail.com', 'doctor', 'active' ),
	('hebrf38f7h348fb384fb38ybf38byfr3', 'f7384hfw34f38wb4fw38h4f03h43f93f', 'dongovan456qwer', '5f4dcc3b5aa765d61d8327deb882cf99', N'Ngô Văn Đô', '0512345469', 'male', 'dongovan456@gmail.com', 'staff', 'active' ),
	('f7834yf8h3w9b93wfb943hf943f934hf', 'ngseriug908hg93h4g934nf34f938f4h', 'thaongthiphuong6969', '5f4dcc3b5aa765d61d8327deb882cf99', N'Nguyễn Thị Phương Thảo', '0705536741', 'female', 'thaongthiphuong6969@gmail.com', 'staff', 'active' );

-- Insert data into the Customer table

INSERT INTO Customer (customerID, dob, customerAddress)
VALUES 
	('2c9320b8639fc9e1c784880bbecfdfa1', '1990-02-15', N'123 Nguyễn Văn A, Phường Bến Nghé, Quận 1, TP.HCM'),
    ('3ff56e23cc31e9c9a85bc037341a65ee', '1985-07-28', N'456 Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM'),
    ('3ff5njfnijhfdsf8845bc037341a65ee', '1978-11-03', N'258/3 Ngô Quyền, Phường Phạm Ngũ Lão, Quận 1, TP.HCM'),
	('82d5cf38dc655bd1722ac5d4d350bce3', '1992-09-10', N'369/2 Hàm Nghi, Phường Nguyễn Thái Bình, Quận 1, TP.HCM'),
	('1c4f04058f291642c159e27e1554ddf8', '1987-04-21', N'753/1 Trần Quang Khải, Phường Tân Định, Quận 1, TP.HCM'),
	('c0637bb4f3d7531d936f2686b9672a66', '1995-12-06', N'123 Nguyễn Cư Trinh, Phường Nguyễn Cư Trinh, Quận 1, TP.HCM'),
	('11eee90acf45377f4cc3ca0758f2bf30', '1982-03-17', N'456 Bùi Thị Xuân, Phường Phạm Ngũ Lão, Quận 1, TP.HCM'),
	('48b31829bc7599f232d06a1e686534bd', '1998-08-24', N'789 Huỳnh Thúc Kháng, Phường Bến Nghé, Quận 1, TP.HCM'),
	('4e192dacb208ceb2413376e2ad3b3db8', '1975-01-09', N'321 Phạm Ngũ Lão, Phường Phạm Ngũ Lão, Quận 1, TP.HCM'),
	('6cb9c7dba65dd3d9e1946c5dd265dbcd', '1993-06-12', N'654 Nguyễn Công Trứ, Phường Nguyễn Cư Trinh, Quận 1, TP.HCM'),
	('45b76de8eb0fd35e124955a2ff2473db', '1989-10-27', N'987 Nguyễn Du, Phường Bến Thành, Quận 1, TP.HCM'),
	('ea03ec90c8836f413784ee96e50a4f11', '1996-05-02', N'147 Hồ Tùng Mậu, Phường Bến Nghé, Quận 1, TP.HCM'),
	('bc6c32dbbb8bd0660d158b08d7cad96f', '1983-08-14', N'258 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, TP.HCM'),
	('7e55fcb3a457634cfa78b49bdb774b3a', '1979-12-19', N'369 Lê Thị Riêng, Phường Bến Thành, Quận 1, TP.HCM'),
	('d8869200b4fbde66a3475d6e730e1b6d', '1991-03-23', N'753 Công Trường Mê Linh, Phường Bến Nghé, Quận 1, TP.HCM'),
	('128ce6812392dce1ca5a6919f03a26a2', '1986-09-05', N'753 Đề Thám, Phường 1, Quận 5, TP.HCM'),
	('87ccfc84f4eb846b5aeb0e04f6ea12ea', '1994-02-18', N'951 Trần Phú, Phường 2, Quận 5, TP.HCM'),
	('715c43d86b98da2212d7a9c9ce9d3062', '1977-07-31', N'369 Nguyễn Chí Thanh, Phường 9, Quận 5, TP.HCM'),
	('a69b4087d281cb16efaa6bc91308f64d', '1999-11-11', N'654 Hậu Giang, Phường 12, Quận 6, TP.HCM'),
	('61dd2b9c89fdcc1dce9fb553bf29cd8d', '1984-04-26', N'987 An Dương Vương, Phường 16, Quận 6, TP.HCM'),
	('03b016eef369ef40bba639aa4f04341b', '1997-01-07', N'123 Võ Văn Kiệt, Phường Cầu Ông Lãnh, Quận 8, TP.HCM'),
	('f8b0ed4e38a71924a7d2bca97029778a', '1981-06-16', N'456 Lê Đại Hành, Phường 15, Quận 8, TP.HCM'),
	('5cbae581d99c1c3d17b8c09b07c54892', '1976-11-29', N'789 Phạm Hùng, Phường 14, Quận 8, TP.HCM'),
	('20e843f249d75ada67c1a2eef0dac92e', '1992-03-03', N'321 Tỉnh Lộ 10, Phường Bình Hưng Hòa, Quận 8, TP.HCM'),
	('712da4f1096f6ae70d0f3c091b84ae7c', '1988-08-08', N'123/4 Nguyễn Văn A, Phường Bến Nghé, Quận 1, TP.HCM'),
	('b03c6f5a51ee06d3dbd17d0e38507ede', '1995-12-13', N'456/7 Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM'),
	('b83bb75b898592b75232c4816842d824', '1980-05-25', N'987/6 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP.HCM'),
	('a68757602ea7419f0e2313a842be9abf', '1993-10-09', N'753/1 Trần Quang Khải, Phường Tân Định, Quận 1, TP.HCM'),
	('2b1850783245c06d0b782a4c9cd6a0a0', '1987-02-22', N'147/9 Lý Tự Trọng, Phường Bến Thành, Quận 1, TP.HCM'),
	('eb70ed9c4c32afea8f482dc873be4f6a', '1999-07-05', N'5 Trần Khắc Chân, Phường Tân Định, Quận 1, TP.HCM');

INSERT INTO Speciality (specialityID, specialityName)
VALUES
    ('e6157a31d2c5e20dc446f4f42fc0d40f', 'general'),
    ('52f6743e4719de9a35e1e2e1c09d6d52', 'surgery'),
    ('8c15dfb7f4f3d4789ed0c043b1512e34', 'resuscitation'),
    ('4a30b3f33f96b639ab20dce9f0b8b8db', 'image analysation'),
    ('7e2dc1364e2e1bdc9efc1669a17a9e45', 'beautify'),
	('bfiwafjnbeaffaiuwhfa9fhawfa56565', 'genetics');
	
INSERT INTO Doctor (doctorID,specialityID, docAge, academicTitle,degree,yearsOfExperience)
VALUES
	('ae114dac5897fbcfd25797bf4be08fd3' , 'e6157a31d2c5e20dc446f4f42fc0d40f' , 35 ,'','',10),
	('9eae70b054be6eba305323d8c9106cfb' , 'e6157a31d2c5e20dc446f4f42fc0d40f' , 37 ,'',N'thạc sĩ',12),
	('c8aa14ffb7da0912c84635aa2ee0bb62' , '52f6743e4719de9a35e1e2e1c09d6d52' , 50 ,N'giáo sư',N'tiến sĩ',25),
	('dd0e3f50648088bfecc501f809a06ca8' , '4a30b3f33f96b639ab20dce9f0b8b8db' , 30 , '' , '' , 5 ),
	('62fe46dae9470f311d52973a6eeb6a1a' , '4a30b3f33f96b639ab20dce9f0b8b8db' , 35 , '' , '' , 10 ),
	('9c6189a20beb35a93df963e3b48eb9b0' , '7e2dc1364e2e1bdc9efc1669a17a9e45' , 40 , '' , N'thạc sĩ' , 15 ),
	('1c38dd30f9e415b3a34879be077381ce' , '8c15dfb7f4f3d4789ed0c043b1512e34' , 45 , N'phó giáo sư' , N'thạc sĩ' , 20 ),
	('21fc9daf44e2637d7972bd248c83577d' , 'e6157a31d2c5e20dc446f4f42fc0d40f' , 50 , N'phó giáo sư' , N'thạc sĩ' , 25 ),
	('01c1fa1b81297a2de21056f35303ad84' , '52f6743e4719de9a35e1e2e1c09d6d52' , 55 , N'giáo sư' , N'tiến sĩ' , 30 ),
	('fe30e1ff175e10b1c538613084ab2417' , '52f6743e4719de9a35e1e2e1c09d6d52' , 46 , '' , N'tiến sĩ' , 19 ),
	('0fe30e184ab12417ff175eb1c5386130' , 'bfiwafjnbeaffaiuwhfa9fhawfa56565' , 56 , N'giáo sư' , N'tiến sĩ' , 31 );

INSERT INTO TimeSlot (timeSlotID, timeSlot, day_)
VALUES
    ('7274b557467ff107537ffe6f642cde39', '07:00:00', 'Monday'),
    ('a54060a06aa0e97217726362a5b580d3', '08:00:00', 'Monday'),
    ('e2283b7f6695530a79793e3fe172155c', '09:00:00', 'Monday'),
    ('4e4b39473c2dfc3e918ee79b1c28fc6f', '10:00:00', 'Monday'),
    ('0f34a633c6767c1e46e90dad2700ce76', '13:00:00', 'Monday'),
    ('6ba12b34e7c18eff6380f8b22ae6211e', '14:00:00', 'Monday'),
    ('1468c48caf3c8acd45c13732fa1c7797', '15:00:00', 'Monday'),
    ('5c9ba69a58918129f033a2c25e250584', '16:00:00', 'Monday'),
    ('0d5408947d23dd60557de6b616352275', '07:00:00', 'Tuesday'),
    ('3deb11e87f2a937320bc503ceff3bda0', '08:00:00', 'Tuesday'),
    ('657be9bfb1eed80938b24e3b154863cb', '09:00:00', 'Tuesday'),
    ('7b84cc4412f9e9a4213a9f979be42063', '10:00:00', 'Tuesday'),
    ('b57c1f7068f9c8220f290b95b7183fc9', '13:00:00', 'Tuesday'),
    ('c397d73df0a2ad5dcb930bd8d26cc2f6', '14:00:00', 'Tuesday'),
    ('b312f680c0e4eac9c2a3bd9bf2260267', '15:00:00', 'Tuesday'),
    ('58ceaa7c941c896dcea4d42bbd40b463', '16:00:00', 'Tuesday'),
    ('b798d08ebebbcabf9315bcef98e8263b', '07:00:00', 'Wednesday'),
    ('9436e53cce52225010e09858fc287123', '08:00:00', 'Wednesday'),
    ('c789ff5a8a615b3cbd55b12d431c1a51', '09:00:00', 'Wednesday'),
    ('0227321c75909512447393796f173788', '10:00:00', 'Wednesday'),
    ('86fc882bb1aadc489464a8ecb5f43a30', '13:00:00', 'Wednesday'),
    ('b82fece225c99d7b1faa427866745620', '14:00:00', 'Wednesday'),
    ('3e895d7bd28f3f7687197d2dd2c5558e', '15:00:00', 'Wednesday'),
    ('0b0ac0d3db2f67dd2626c726e51b0612', '16:00:00', 'Wednesday'),
    ('0f6c341110df21c899097b659454e1ab', '07:00:00', 'Thursday'),
    ('71071e13d9c8cd2902737b7e39f32a5a', '08:00:00', 'Thursday'),
    ('3cd774fd522ed4a7b81dc2e3ed0373bd', '09:00:00', 'Thursday'),
    ('516ab8138f50bbbb0be18ceed38b6ad3', '10:00:00', 'Thursday'),
    ('9eea7e14fbd37b455d69e7114399aa0a', '13:00:00', 'Thursday'),
    ('4db7ce38baceaddfc93e9bdcfe0a7f57', '14:00:00', 'Thursday'),
    ('8d84a3d75c4f560729956e1fd9886ded', '15:00:00', 'Thursday'),
    ('4aec19307175805430f2cccde15d88a3', '16:00:00', 'Thursday'),
    ('4940cc64f161f2caf8fb70416d0c41cc', '07:00:00', 'Friday'),
    ('68e185b8d481c5652842b42ef66b3210', '08:00:00', 'Friday'),
    ('9d35c51b03f46f6edd9aaa81c4cfc3c4', '09:00:00', 'Friday'),
    ('8accf3a256bcc4e7335afe49531eaac6', '10:00:00', 'Friday'),
    ('13c16787a7506cfefc1f38586a793196', '13:00:00', 'Friday'),
    ('7be65563411c5ce7cd508f04c8a54ecb', '14:00:00', 'Friday'),
    ('8e397cbb235075a9cb231b2c3b316011', '15:00:00', 'Friday'),
    ('e5bf5358b106ba77625e21497cb2a446', '16:00:00', 'Friday'),
    ('7146c2b1971837ea3045d243802bd8a2', '07:00:00', 'Saturday'),
    ('88549bf6059c27cd9bf49508373f6dad', '08:00:00', 'Saturday'),
    ('14efd87c0e8f2e3d045efc1cda0ccba0', '09:00:00', 'Saturday'),
    ('92d969030097f06af642a4577606afe0', '10:00:00', 'Saturday'),
    ('b02c69a820861a57ac38b4282399335c', '13:00:00', 'Saturday'),
    ('7fc51e03321ce0adc4413168f12a8eb1', '14:00:00', 'Saturday'),
    ('02a3908fe51e3235f7a535358c5c8730', '15:00:00', 'Saturday'),
    ('718838b54bc5450a76c6a75576021dc3', '16:00:00', 'Saturday'),
    ('85688ffa8d935b9da96e2a680aaa4e34', '07:00:00', 'Sunday'),
    ('35214a23d76865f60f6d837db69f87fd', '08:00:00', 'Sunday'),
    ('ce26b41ff7120b6f14c47596d9cb96b0', '09:00:00', 'Sunday'),
    ('12bc604e930e56d53915a09b61bc459a', '10:00:00', 'Sunday'),
    ('5a71a95534bbd12150558baa83f945de', '13:00:00', 'Sunday'),
    ('5c4960d3243606ca79b7692f8a4c9957', '14:00:00', 'Sunday'),
    ('966de85e9140af61d6ee26c11feb6f78', '15:00:00', 'Sunday'),
    ('a2855125bdc9e06b5313b3f827f07705', '16:00:00', 'Sunday');

INSERT INTO DoctorTimeSlot (doctorID, timeSlotID)
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT 'ae114dac5897fbcfd25797bf4be08fd3' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT 'ae114dac5897fbcfd25797bf4be08fd3' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT 'ae114dac5897fbcfd25797bf4be08fd3' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT 'ae114dac5897fbcfd25797bf4be08fd3' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT 'ae114dac5897fbcfd25797bf4be08fd3' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL






SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Wednesday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '9eae70b054be6eba305323d8c9106cfb' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID





FROM
(
    -- Monday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT 'c8aa14ffb7da0912c84635aa2ee0bb62' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(



    -- Monday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT 'dd0e3f50648088bfecc501f809a06ca8' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8



UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '62fe46dae9470f311d52973a6eeb6a1a' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '9c6189a20beb35a93df963e3b48eb9b0' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '1c38dd30f9e415b3a34879be077381ce' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '21fc9daf44e2637d7972bd248c83577d' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Saturday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Saturday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Sunday
    SELECT '01c1fa1b81297a2de21056f35303ad84' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Sunday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT 'fe30e1ff175e10b1c538613084ab2417' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT 'fe30e1ff175e10b1c538613084ab2417' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT 'fe30e1ff175e10b1c538613084ab2417' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT 'fe30e1ff175e10b1c538613084ab2417' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT 'fe30e1ff175e10b1c538613084ab2417' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8





UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Monday
    SELECT '0fe30e184ab12417ff175eb1c5386130' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Monday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Tuesday
    SELECT '0fe30e184ab12417ff175eb1c5386130' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Tuesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(    -- Wednesday
    SELECT '0fe30e184ab12417ff175eb1c5386130' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Wednesday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Thursday
    SELECT '0fe30e184ab12417ff175eb1c5386130' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Thursday'
) AS subquery
WHERE row_num <= 8
UNION ALL
SELECT doctorID, timeSlotID
FROM
(
    -- Friday
    SELECT '0fe30e184ab12417ff175eb1c5386130' AS doctorID, timeSlotID, ROW_NUMBER() OVER (ORDER BY timeSlotID) AS row_num
    FROM TimeSlot
    WHERE day_ = 'Friday'
) AS subquery
WHERE row_num <= 8;

INSERT INTO Medicine (medicineID,medicineName,medicinePrice, unit)
VALUES
	('1a27a82eb264532c271baf05c7a6e10d','Penicillin','53.01', 'pill packet'),
	('c93c634859e543a562441ca36f9bd9f0','AMTYL','18.99', 'pill'),
	('d0141bd1067e2f534fd908b54a72a1ff','Aureomycin','16.35', 'tube'),
	('c69f4b52c792233f31e11393012e5e19','Antibiotics','42.67', 'pill packet'),
	('5f7fb0d98491f5efdf52623a7d4839aa','Enrofloxacin','16.69', 'vial'),
	('8e89704ade7f8e48da32ce2d6bb15054','Coccivet','23.55', 'vial'),
	('7c7f0e401b7926cb956e1e798e7d6664','Aureomycin','16.35', 'tube'),
	('2b1937a02cb1cc8255ecfeb8dc38c5d2','Cough','14.99', 'pill packet'),
	('589ff60828e99f431d7f07d8ef62baff','4 in 1 powder Generic','27.00', 'pill packet'),
	('f9a7dfe69faaaf1f0c2dc348c0254d50','Medistatin','21.73', 'vial'),
	('e365252333bf5bd19b86b828e64b0eb0','Psittavet','15.99', 'pill packet'),
	('9dc94408c0e9b062a5cdd03830011d72','Ronidazole','10.49', 'vial'),
	('7c6164ddf235787f5d1e2d8f4540c838','Ronivet-S','30.95', 'pill packet'),
	('124b0999a2e3a37b30f8b4d4196d5666','SCATT','28.00', 'pill'),
	('5587ecc8c67f1ba9f77488eedc2d1164','Spectovet powder','45.95', 'pill'),
	('9e9af1d637a369cdaf6bac028b8bd813','Terramycin Ointment','14.95', 'pill packet'),
	('9faeec1795e05223ab80bf4d06971616','Tetrasol','13.95', 'pill'),
	('976f58180ccfd7c80f492b1665fd003a','Triple C','28.00', 'pill');

INSERT INTO Service_ (serviceID,specialityID,serviceName,servicePrice)
VALUES
	('f8c17d469d7dfd4fa84eae659923536b','e6157a31d2c5e20dc446f4f42fc0d40f','Health check and check',100.00),
	('c739c1e62319f52411908f874c0698bf','e6157a31d2c5e20dc446f4f42fc0d40f','diagnostic test',101.00),
	('a074614583162a3d58b89c13699d70a1','52f6743e4719de9a35e1e2e1c09d6d52','surgery',102.00),
	('cd9bfc9d6bb22a47f6dcdc2a5c99b2fd','e6157a31d2c5e20dc446f4f42fc0d40f','Nutrition advice and advice',103.00),
	('744722e0fb1eb8e7f4fc5c4682159800','e6157a31d2c5e20dc446f4f42fc0d40f','boarding service',104.00),
	('84fbf5e32cfdb21cf48721cf849b0c20','8c15dfb7f4f3d4789ed0c043b1512e34','Urgent care and after-hours support',105.00),
	('517d8993ec9bcdb8c33fc50ea7ec5da8','52f6743e4719de9a35e1e2e1c09d6d52','Microchip service and identification',106.00),
	('291129122c3e6bbbd76a76b428f2809a','4a30b3f33f96b639ab20dce9f0b8b8db','Endoscopy and X-ray',107.00),
	('52b7bedca394c621f40a99d03a564341','7e2dc1364e2e1bdc9efc1669a17a9e45','Poultry care service',108.00),
	('e41d8b0c31b65cc94f5eb4bbb7b76907','bfiwafjnbeaffaiuwhfa9fhawfa56565','DNA sex and disease testing',109.00),
	('507e4c66da1ccd4fcf621069065494bc','e6157a31d2c5e20dc446f4f42fc0d40f','vaccinated',110.00);

INSERT INTO Bird(birdID, customerID,imageID, medicalHistory, birdGender, breed, band_chip, birdWeight, sexingMethod, birdFullname, hatchingDate, featherColor)
VALUES
	('2bbb77362ead86434fd59f94b282eae1' , '2c9320b8639fc9e1c784880bbecfdfa1' , 'fafnbuhfauhfweoufha8hfa9hfa48hf8', N'cảm cúm' ,'male','Apodidae', 'qwerty', 0.02,N'Observe shapes and colors', N'tom', '2019-01-01', N'đen'),
	('507c2afab061a1c2cf1dee7142e557be' , '3ff56e23cc31e9c9a85bc037341a65ee' , 'avewifbaiuwefnwajenfhiuahenf998f', N'Bệnh viêm tuyến nhờn' ,'','Phasianidae', 'wertyu', 0.02, N'Check behavior', N'jerry', '2019-02-01', N'lam-lục'),
	('15d35bb9396992d02127345380e38d73' , '3ff5njfnijhfdsf8845bc037341a65ee' , 'fewabf9qb439fufh9h438q9h34fq34t4', '' ,'female','Én', 'ertyui', 0.03, N'Observe shapes and colors', N'Yến', '2019-03-01', N'đen'),
	('e9e0f3bcddc65940e089972ce4088e59' , '82d5cf38dc655bd1722ac5d4d350bce3' , 'frheafiuewhf9hf983h3f4ha438f94f4', N'Bệnh cầu trùng' , 'rtyuio' , 'Phasianidae' , 'no' , 0.02 , N'Check behavior' , N'mít' , '2019-04-01' , N'vàng-đỏ-lam'),
	('2e4076dd7f277dc8f29b4cdb922052c0' , '1c4f04058f291642c159e27e1554ddf8' , '4rt43t5y56y465t4r3e24r435y65u76i', '' , 'male' , N'Sẻ', 'tyuiop' , 0.02 , N'Observe shapes and colors' , N'Leo' , '2019-05-01' , N'nâu'),
	('27009754484e5b64300b05706c954565' , 'c0637bb4f3d7531d936f2686b9672a66' , 'efrgtrytuiykjhmngfbvdfewr4567898', 'Bệnh tiêu chảy' , 'male' , 'Finches', 'no' , 0.2 , N'Check behavior' , N'kitty' , '2019-06-01' , N'đỏ'),
	('49f34170b6590fea6bce454059764c12' , '11eee90acf45377f4cc3ca0758f2bf30' , '48c967910f7eb39ea5f7b7602a3df9ea', '' , 'male' , 'Ciconiidae', 'uiopas' , 15 , N'Checking the spawning zone' , N'Milo' , '2019-07-01' , N'trắng-đen'),
	('2e9d61c3330f9e10e3a0bc3fb8a4b4a2' , '48b31829bc7599f232d06a1e686534bd' , '3b94ace86063b245916a6e906221e6a8', N'Bệnh cảm cúm' , 'female' , 'Canidae', 'iopasd' , 3 , N'Checking the spawning zone' , N'Mỹ Diệu' , '2019-08-01' , N'vàng-trắng'),
	('e939af928268bda5f11f7bf215d452eb' , '4e192dacb208ceb2413376e2ad3b3db8' , '249fb9cb11171ae6ab41794bee070a8f', '' , 'male' , N'Vẹt', 'opasdf' , 0.2 , N'Observe shapes and colors' , 'Oscar' , '2019-09-01' , N'lục-vàng-đen'),
	('43e02d9e3ce088b73229155e462e32d9' , '6cb9c7dba65dd3d9e1946c5dd265dbcd' , 'b3b9752ec51a5433b44e27b8d9b81c76', N'Bệnh cảm cúm' , 'female' , N'Bồ câu', 'pasdfg' , 0.4 , N'DNA analysis' , N'Meo MEo' , '2019-10-01' , N'xám'),
	('00c38b52d5cdedc2667af4a83e346a85' , '45b76de8eb0fd35e124955a2ff2473db' , 'ee38603c9cfdb54fb0a0ab4a197f92a3', '' , 'male' , N'Vẹt', 'asdfgh' , 0.02 , N'Check behavior' , N'Hổ Báo' , '2019-11-01' , N'đỏ-lam-vàng'),
	('1587900aee161437134c2e2479de5b64' , 'ea03ec90c8836f413784ee96e50a4f11' , 'ef94fe9d57eed266b24c3fc1203c1e17', N'Bệnh viêm tuyến nhờn' , 'female' , N'Sẻ thông', 'sdfghj' , 0.02 , N'DNA analysis' , 'Oliver' , '2019-12-01' , N'vàng'),
	('277dd0cf43f2cc494be796373fd7bf2b' , 'bc6c32dbbb8bd0660d158b08d7cad96f' , 'a8cf052632950deb5ab9c1f5ec36334d', N'Bệnh cảm cúm' , 'male' , 'Muscicapidae', 'dfghjk' , 0.03 , N'Checking the spawning zone' , N'Phượng Hoàng' , '2020-01-01' , N'đen-nâu'),
	('08605ccab7ad051603412533c59e46c7' , '7e55fcb3a457634cfa78b49bdb774b3a' , '7b1bc65da7abbaceaaadc0ea9564c175', '' , 'female' , N'Chào mào', 'fghjkl' , 0.05 , N'Observe shapes and colors' , 'Rocky' , '2020-02-01' , N'trắng-nâu'),
	('acdbf948aa576959e791abe5ec2f124d' , 'd8869200b4fbde66a3475d6e730e1b6d' , '95f7e5a8c051e6b60905912bd8aedf7d', '' , 'male' , N'Đớp ruồi', 'ghjklz' , 0.03 , N'Check behavior' , N'Cơm' , '2020-03-01' , N'xám-trắng-đỏ'),
	('4b4c133439471c8d694b5c3e47edb446' , '128ce6812392dce1ca5a6919f03a26a2' , '365c43bd856cf86e0e0b4cd4b7bc0462', N'Bệnh cầu trùng' , 'female' , N'Sẻ', 'hjklzx' , 0.03 , N'Observe shapes and colors' , N'Mỹ Linh' , '2020-04-01' , N'trắng-đen-xám'),
	('0d0dd3c14756ae8316e7054b205896c9' , '87ccfc84f4eb846b5aeb0e04f6ea12ea' , 'b51f1bb2e54d243e60e32563b2b1a7ed', '' , 'female' , N'Chiền chiện', 'jklzxc' , 0.03 , N'DNA analysis' , N'Lan' , '2020-05-01' , N'vàng-đen'),
	('861c51821e55ecad053b072323fac994' , '715c43d86b98da2212d7a9c9ce9d3062' , '08eed66a05827e8dc02d6ff1392f9bf6', '' , 'female' , N'Diệc', 'klzxcv' , 0.2 , N'DNA analysis' , N'Hồng Nhung' , '2020-06-01' , N'đen'),
	('380965fe9f1584559ea8a90b9c8d680c' , 'a69b4087d281cb16efaa6bc91308f64d' , 'ddfff0e1f9009fe5d621e2ed07348a51', N'Bệnh cầu trùng' , 'female' , N'Cu cu', 'lzxcvb' , 0.08 , N'Checking the spawning zone' , N'Chôm Chôm' , '2020-07-01' , N'xám'),
	('17787dd14e0fda883a36016cada64123' , '61dd2b9c89fdcc1dce9fb553bf29cd8d' , 'cbe26c3a3f34407ed023e3f02399d2fa', '' , 'male' , N'Nhạn', 'zxcvbn' , 0.5 , N'Observe shapes and colors' , N'Đại ca' , '2020-08-01' , N'đen'),
	('d5ea83ec7f100a6803bd39e14c619299' , '03b016eef369ef40bba639aa4f04341b' , '05b5b4345d8ac2f73ece3df15be03230', N'Bệnh cầu trùng' , 'female' , N'Kim oanh', 'xcvbnm' , 0.1 , N'DNA analysis' , N'Xuân Mai' , '2020-09-01' , N'nâu đất'),
	('25c448b0241244364f7653f08cb8aff6' , 'f8b0ed4e38a71924a7d2bca97029778a' , '2bda592b2aada870747dd4366a3dff18', '' , 'male' , N'Nhạn', 'cvbnmq' , 3 , N'Check behavior' , N'Thạch đậu' , '2020-10-01' , N'trắng'),
	('bc0b9fe1f4df72fa1289f4437e6a3953' , '5cbae581d99c1c3d17b8c09b07c54892' , 'e28e1458f599f2391b91bfd61338483e', '' , 'male' , N'Cu cu', 'vbnmqw' , 0.08 , N'Observe shapes and colors' , 'Buddy' , '2020-11-01' , N'đen-cam'),
	('43aaf0240284fd15416b429bed0ef321' , '20e843f249d75ada67c1a2eef0dac92e' , '84cb52eda2e4f0b66f8509c37e857e8c', '' , 'female' , N'Sáo', 'bnmqwe' , 0.015 , N'DNA analysis' , N'Polly' , '2020-12-01' , N'đen'),
	('ca8406790940dec227193cc7dca16212' , '712da4f1096f6ae70d0f3c091b84ae7c' , '8721d5a5f3f44bd01529d24dcf519239', N'Bệnh cầu trùng' , 'male' , N'Chìa vôi', 'nmqwer' , 0.04 , N'DNA analysis' , N'Anh chàng đẹp trai' , '2021-01-01' , N'đen-trắng'),
	('752ee3ce65129a7bd54292accb28983e' , 'b03c6f5a51ee06d3dbd17d0e38507ede' , '66a5473e01debb47bff7f215d6c4a228', '' , 'male' , N'Cắt', 'mqwert' , 0.15 , N'DNA analysis' , 'Max' , '2021-02-01' , N'nâu'),
	('c91f8b119029caa4ec2046bcc5c69bb5' , 'b83bb75b898592b75232c4816842d824' , '6d47ad177fb45c2d87e1b54fc363676b', N'Bệnh viêm tuyến nhờn' , 'female' , N'Đớp ruồi', 'mnbvcx' , 0.05 , N'Observe shapes and colors' , 'Daisy' , '2021-03-01' , N'lam-vàng'),
	('16c5bd4d79c66e16042bee6bbf128c6f' , 'a68757602ea7419f0e2313a842be9abf' , '25abf9603856427e295b7bd1137fd04a', '' , 'male' , N'Vẹt', 'nbvcxz' , 6 , N'DNA analysis' , N'Cạp cạp' , '2021-04-01' , N'xanh lá-xanh nước biển-vàng'),
	('56a7207dd933fe09f539083edb711548' , '2b1850783245c06d0b782a4c9cd6a0a0' , 'ed1ed3634186fc66ee692da3ba98272f', N'Bệnh cầu trùng' , 'male' , N'sơn ca', 'bvcxzl' , 0.01 , N'DNA analysis' , N'Bầu trời' , '2021-05-01' , N'trắng-đen-vàng-đỏ'),
	('6a045cdabdccb76073091f263cbf3e52' , 'eb70ed9c4c32afea8f482dc873be4f6a' , 'e47ccaddaa9e2cd4c25e84cae624b077', '' , 'female' , N'vàng Anh', 'vcxzlk' , 0.04 , N'Check behavior' , 'Stella' , '2021-06-01' , N'vàng-đen');

INSERT INTO Appointment(appointmentID, birdID, doctorID, timeSlotID, serviceID, appTime, notes, payment, appStatus)
VALUES
	('a6a837e5d05e57e160dea29c335f30d0' , '2bbb77362ead86434fd59f94b282eae1' , 'ae114dac5897fbcfd25797bf4be08fd3', '85688ffa8d935b9da96e2a680aaa4e34' , 'f8c17d469d7dfd4fa84eae659923536b' , '2023-01-01' , '', 'banking account', 'complete'),
	('95b579fe61c622b5c50def9dccb66bdc' , '507c2afab061a1c2cf1dee7142e557be' , '9eae70b054be6eba305323d8c9106cfb', 'e2283b7f6695530a79793e3fe172155c' , 'c739c1e62319f52411908f874c0698bf' , '2023-01-02' , '',  'banking account', 'complete'),
	('86ae960dc44eba248c481d76520846c3' , '15d35bb9396992d02127345380e38d73' , 'c8aa14ffb7da0912c84635aa2ee0bb62', '657be9bfb1eed80938b24e3b154863cb' , 'a074614583162a3d58b89c13699d70a1' , '2023-01-03' , '',  'cash', 'complete'),
	('801b58e3d0b00f7f9f9eac80058f99f0' , 'e9e0f3bcddc65940e089972ce4088e59' , '21fc9daf44e2637d7972bd248c83577d', 'c789ff5a8a615b3cbd55b12d431c1a51' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' , '2023-01-04' , '' , 'banking account' , 'complete'),
	('ca768c1b1876a2f286496e62666dfada' , '2e4076dd7f277dc8f29b4cdb922052c0' , 'ae114dac5897fbcfd25797bf4be08fd3', '3cd774fd522ed4a7b81dc2e3ed0373bd' , '744722e0fb1eb8e7f4fc5c4682159800' , '2023-01-05' , '' , 'banking account' , 'complete'),
	('0a7a30124b6b4f266459a6b69677152c' , '27009754484e5b64300b05706c954565' , '1c38dd30f9e415b3a34879be077381ce', '8accf3a256bcc4e7335afe49531eaac6' , '84fbf5e32cfdb21cf48721cf849b0c20' , '2023-01-06' , '' , 'banking account' , 'complete'),
	('ebcf025d47ee19d929f6707029df09d0' , '49f34170b6590fea6bce454059764c12' , 'c8aa14ffb7da0912c84635aa2ee0bb62', 'b02c69a820861a57ac38b4282399335c' , '517d8993ec9bcdb8c33fc50ea7ec5da8' , '2023-01-07' , '' , 'banking account' , 'complete'),
	('b7e4621ca7d7273ea67ba0b40992d189' , '2e9d61c3330f9e10e3a0bc3fb8a4b4a2' , 'dd0e3f50648088bfecc501f809a06ca8', '5c4960d3243606ca79b7692f8a4c9957' , '291129122c3e6bbbd76a76b428f2809a' , '2023-01-08' , '' , 'cash' , 'complete'),
	('35847b5a3a8de7e0af06281b1d889bcf' , 'e939af928268bda5f11f7bf215d452eb' , '9c6189a20beb35a93df963e3b48eb9b0', '71071e13d9c8cd2902737b7e39f32a5a' , '52b7bedca394c621f40a99d03a564341' , '2023-02-09' , '' , 'banking account' , 'complete'),
	('ca05b981160139795fbf616bfd5d491b' , '43e02d9e3ce088b73229155e462e32d9' , '0fe30e184ab12417ff175eb1c5386130', '68e185b8d481c5652842b42ef66b3210' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' , '2023-02-10' , '' , 'cash' , 'complete'),
	('3967200752865b1bb65a63f386925d14' , '00c38b52d5cdedc2667af4a83e346a85' , 'ae114dac5897fbcfd25797bf4be08fd3', 'b02c69a820861a57ac38b4282399335c' , '507e4c66da1ccd4fcf621069065494bc' , '2023-02-11' , '' , 'banking account' , 'cancelled'),
	('943b4c67a61164d245ea5af7f3848a37' , '1587900aee161437134c2e2479de5b64' , '9eae70b054be6eba305323d8c9106cfb', '12bc604e930e56d53915a09b61bc459a' , 'f8c17d469d7dfd4fa84eae659923536b' , '2023-03-12' , '' , 'banking account' , 'complete'),
	('040c93cff9c0cc5cd6d008fb02e17b69' , '277dd0cf43f2cc494be796373fd7bf2b' , '21fc9daf44e2637d7972bd248c83577d', '5c9ba69a58918129f033a2c25e250584' , 'c739c1e62319f52411908f874c0698bf' , '2023-03-13' , '' , 'cash' , 'complete'),
	('3841cd8942a581d2092ff1d3739fcebc' , '08605ccab7ad051603412533c59e46c7' , '01c1fa1b81297a2de21056f35303ad84', '7b84cc4412f9e9a4213a9f979be42063' , 'a074614583162a3d58b89c13699d70a1' , '2023-03-14' , '' , 'banking account' , 'complete'),
	('4a160bb951e81bb14485ab90391d0c58' , 'acdbf948aa576959e791abe5ec2f124d' , '9eae70b054be6eba305323d8c9106cfb', '86fc882bb1aadc489464a8ecb5f43a30' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' , '2023-03-15' , '' , 'banking account' , 'complete'),
	('0bb8e03d00ecc7642c5142de8f12a335' , '4b4c133439471c8d694b5c3e47edb446' , '21fc9daf44e2637d7972bd248c83577d', '85688ffa8d935b9da96e2a680aaa4e34' , '744722e0fb1eb8e7f4fc5c4682159800' , '2023-04-16' , '' , 'banking account' , 'cancelled'),
	('aeed52468a0d9880fa013c611816e897' , '0d0dd3c14756ae8316e7054b205896c9' , '1c38dd30f9e415b3a34879be077381ce', 'a54060a06aa0e97217726362a5b580d3' , '84fbf5e32cfdb21cf48721cf849b0c20' , '2023-04-17' , '' , 'cash' , 'complete'),
	('cde92de8a056398e6a281dba87bdffb1' , '861c51821e55ecad053b072323fac994' , 'fe30e1ff175e10b1c538613084ab2417', '657be9bfb1eed80938b24e3b154863cb' , '517d8993ec9bcdb8c33fc50ea7ec5da8' , '2023-04-18' , '' , 'banking account' , 'complete'),
	('6c3b331b0cde4d503944f2f16f979c93' , '380965fe9f1584559ea8a90b9c8d680c' , '62fe46dae9470f311d52973a6eeb6a1a', '0227321c75909512447393796f173788' , '291129122c3e6bbbd76a76b428f2809a' , '2023-04-19' , '' , 'cash' , 'complete'),
	('b6b447b56dbe005a626c4b5e3fdb97be' , '17787dd14e0fda883a36016cada64123' , '9c6189a20beb35a93df963e3b48eb9b0', '4db7ce38baceaddfc93e9bdcfe0a7f57' , '52b7bedca394c621f40a99d03a564341' , '2023-04-20' , '' , 'banking account' , 'complete'),
	('a61de36f81c0f699a8653863ea9e3d2f' , 'd5ea83ec7f100a6803bd39e14c619299' , '0fe30e184ab12417ff175eb1c5386130', 'a2855125bdc9e06b5313b3f827f07705' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' , '2023-05-21' , '' , 'cash' , 'complete'),
	('47b601885ddc891de11eb62451a97b43' , '25c448b0241244364f7653f08cb8aff6' , 'ae114dac5897fbcfd25797bf4be08fd3', '1468c48caf3c8acd45c13732fa1c7797' , '507e4c66da1ccd4fcf621069065494bc' , '2023-05-22' , '' , 'banking account' , 'complete'),
	('2f7294ec43136a43ca696ad6f06e1635' , 'bc0b9fe1f4df72fa1289f4437e6a3953' , '9eae70b054be6eba305323d8c9106cfb', 'c397d73df0a2ad5dcb930bd8d26cc2f6' , 'f8c17d469d7dfd4fa84eae659923536b' , '2023-05-23' , '' , 'cash' , 'complete'),
	('090f345a844fedfb9ca86ff69b59d969' , '43aaf0240284fd15416b429bed0ef321' , '21fc9daf44e2637d7972bd248c83577d', '86fc882bb1aadc489464a8ecb5f43a30' , 'c739c1e62319f52411908f874c0698bf' , '2023-05-24' , '' , 'cash' , 'complete'),
	('d2601ee48263e69982e4dbd809c0358a' , 'ca8406790940dec227193cc7dca16212' , 'c8aa14ffb7da0912c84635aa2ee0bb62', '516ab8138f50bbbb0be18ceed38b6ad3' , 'a074614583162a3d58b89c13699d70a1' , '2023-05-25' , '' , 'banking account' , 'complete'),
	('e221bebf131b7773da0045982e018fba' , '752ee3ce65129a7bd54292accb28983e' , '21fc9daf44e2637d7972bd248c83577d', 'a54060a06aa0e97217726362a5b580d3' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' , '2023-06-26' , '' , 'cash' , 'complete'),
	('85c10fd22fe836139fd76fbaee831673' , 'c91f8b119029caa4ec2046bcc5c69bb5' , 'ae114dac5897fbcfd25797bf4be08fd3', '657be9bfb1eed80938b24e3b154863cb' , '744722e0fb1eb8e7f4fc5c4682159800' , '2023-06-27' , '' , 'banking account' , 'complete'),
	('7caa694dda6e1cf8c0993cf301c84bba' , '16c5bd4d79c66e16042bee6bbf128c6f' , '1c38dd30f9e415b3a34879be077381ce', '0227321c75909512447393796f173788' , '84fbf5e32cfdb21cf48721cf849b0c20' , '2023-06-28' , '' , 'banking account' , 'cancelled'),
	('b7ad6a62013acd21497265b6f7ff74eb' , '56a7207dd933fe09f539083edb711548' , '01c1fa1b81297a2de21056f35303ad84', '9eea7e14fbd37b455d69e7114399aa0a' , '517d8993ec9bcdb8c33fc50ea7ec5da8' , '2023-06-29' , '' , 'banking account' , 'complete'),
	('3427f117121dd0789b94a37ef63b64dc' , '6a045cdabdccb76073091f263cbf3e52' , 'dd0e3f50648088bfecc501f809a06ca8', '8e397cbb235075a9cb231b2c3b316011' , '291129122c3e6bbbd76a76b428f2809a' , '2023-06-30' , '' , 'banking account' , 'complete'),
	('b7ad6137ff75b214972a6acd6206f4eb' , '16c5bd4d79c66e16042bee6bbf128c6f' , '0fe30e184ab12417ff175eb1c5386130', 'b82fece225c99d7b1faa427866745620' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' , '2023-07-02' , '' , 'banking account' , 'complete'),
	('f1174d213346307894a92d177efbb6dc' , '752ee3ce65129a7bd54292accb28983e' , '0fe30e184ab12417ff175eb1c5386130', '9eea7e14fbd37b455d69e7114399aa0a' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' , '2023-07-03' , '' , 'banking account' , 'complete'),
	('81c0f699a861de36fea9e653863a3d2f' , '25c448b0241244364f7653f08cb8aff6' , 'ae114dac5897fbcfd25797bf4be08fd3', '0d5408947d23dd60557de6b616352275' , '507e4c66da1ccd4fcf621069065494bc' , '2023-08-01' , '' , 'cash' , 'confirm'),
	('985ddc8a97245147b60181de11eb6b43' , 'd5ea83ec7f100a6803bd39e14c619299' , '9eae70b054be6eba305323d8c9106cfb', '9436e53cce52225010e09858fc287123' , '507e4c66da1ccd4fcf621069065494bc' , '2023-08-02' , '' , 'banking account' , 'confirm'),
	('ec436f0ca64396ad2f6e16136a437295' , 'ca8406790940dec227193cc7dca16212' , '9c6189a20beb35a93df963e3b48eb9b0', '4db7ce38baceaddfc93e9bdcfe0a7f57' , '52b7bedca394c621f40a99d03a564341' , '2023-08-03' , '' , 'cash' , 'confirm'),
	('edf345a8f69ca86f0fb90944fb59d969' , 'c91f8b119029caa4ec2046bcc5c69bb5' , 'fe30e1ff175e10b1c538613084ab2417', '7be65563411c5ce7cd508f04c8a54ecb' , '517d8993ec9bcdb8c33fc50ea7ec5da8' , '2023-08-04' , '' , 'cash' , 'check-in'),
	('e4c03e6998de4826309bd8d2601e258a' , 'bc0b9fe1f4df72fa1289f4437e6a3953' , '21fc9daf44e2637d7972bd248c83577d', 'b02c69a820861a57ac38b4282399335c' , 'c739c1e62319f52411908f874c0698bf' , '2023-08-05' , '' , 'banking account' , 'check-in'),
	('13e25982e018f21bda01bebf077734ba' , '6a045cdabdccb76073091f263cbf3e52' , 'ae114dac5897fbcfd25797bf4be08fd3', '5a71a95534bbd12150558baa83f945de' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' , '2023-08-06' , '' , 'cash' , 'check-in'),
	('d76836859ffbaee831c10fd22fe13673' , '43aaf0240284fd15416b429bed0ef321' , '9eae70b054be6eba305323d8c9106cfb', '4e4b39473c2dfc3e918ee79b1c28fc6f' , '744722e0fb1eb8e7f4fc5c4682159800' , '2023-08-07' , '' , 'banking account' , 'processing'),
	('e199d87ca6943ccf8cdac4bbaa6f3010' , '56a7207dd933fe09f539083edb711548' , '1c38dd30f9e415b3a34879be077381ce', '8e397cbb235075a9cb231b2c3b316011' , '84fbf5e32cfdb21cf48721cf849b0c20' , '2023-09-01' , '' , 'banking account' , 'processing'),
	('13acd6206f7ff75bb7ad6214972a64eb' , '16c5bd4d79c66e16042bee6bbf128c6f' , '01c1fa1b81297a2de21056f35303ad84', '92d969030097f06af642a4577606afe0' , '517d8993ec9bcdb8c33fc50ea7ec5da8' , '2023-09-02' , '' , 'banking account' , 'processing'),
	('3346307894a7f1171217efbb64d92ddc' , '752ee3ce65129a7bd54292accb28983e' , '62fe46dae9470f311d52973a6eeb6a1a', 'a2855125bdc9e06b5313b3f827f07705' , '291129122c3e6bbbd76a76b428f2809a' , '2023-09-03' , '' , 'banking account' , 'processing');

INSERT INTO MedicalRecord (medicalRecordID, appointmentID, recordTime, diagnosis, treatmentDays, doctorNotes)
VALUES
	('3b153a85daab45c693cdd0e1f02631c9' , 'a6a837e5d05e57e160dea29c335f30d0', '2023-01-02', N'không phát hiện bất thường', 3, ''),
	('87599195136fd0440b341eed32d36c84' , '95b579fe61c622b5c50def9dccb66bdc', '2023-01-03', N'Thiếu hụt dinh dưỡng', 4, ''),
	('4d0ac1b5e6f8e2e4ee256c4c2031b1d2' , '86ae960dc44eba248c481d76520846c3', '2023-01-04', N'chấn thương chân', 2 , ''),
	('b356f8672801e4820bd72b17dbda7764' , '801b58e3d0b00f7f9f9eac80058f99f0' , '2023-01-05' , N'thiếu vitamin A' , 3, ''),
	('a0540a74c856251ad819d931fee6b078' , 'ca768c1b1876a2f286496e62666dfada' , '2023-01-06' , N'nội trú', 1 , ''),
	('32fe2542e25434a1acde0f6edff2f0b4' , '0a7a30124b6b4f266459a6b69677152c' , '2023-01-07' , N'gãy cánh', 2, ''),
	('2f6c8e2ec915f490a91c6c7e888126f6' , 'ebcf025d47ee19d929f6707029df09d0' , '2023-01-08', N'gắn chip', 3, ''),
	('21def0e373e1e8d57d1ab5f339726167' , 'b7e4621ca7d7273ea67ba0b40992d189' , '2023-01-09' , N'dị vật trong dạ dày', 1, ''),
	('ff398a2c8cdd28c7c9e31446c0e2a629' , '35847b5a3a8de7e0af06281b1d889bcf' , '2023-02-10' , N'chăm sóc', 0 , '' ),
	('753906196d6e7bdd8f8d874efaacfa8d' , 'ca05b981160139795fbf616bfd5d491b' , '2023-02-11' , N'xác định giới tính', 3, '' ),
	('4aa48bfce29088db4424a1b921e2be55' , '943b4c67a61164d245ea5af7f3848a37' , '2023-03-13' , N'Bệnh cảm cúm', 0 , '' ),
	('154aa8864b0445239a1c8cf636ce8164' , '040c93cff9c0cc5cd6d008fb02e17b69' , '2023-03-14' , N'Bệnh cầu trùng', 2, '' ),
	('b72e56f3705781fdfaa652dabbefd8b4' , '3841cd8942a581d2092ff1d3739fcebc' , '2023-03-15' , N'chấn thương phần đầu', 3, '' ),
	('96f71fd09596eeda17b234c2a87b783f' , '4a160bb951e81bb14485ab90391d0c58' , '2023-03-16' , N'thiếu vitamin D', 3, '' ),
	('de9aa8254527b52b336a60f9373740ea' , 'aeed52468a0d9880fa013c611816e897' , '2023-04-18' , N'mỏ bị gãy', 2, '' ),
	('737cebac25159c2b8e46f50881a7abcb' , 'cde92de8a056398e6a281dba87bdffb1' , '2023-04-19' , N'gắn chip', 3, '' ),
	('1450707c9e9a8ea70f8d341e19e5a9bb' , '6c3b331b0cde4d503944f2f16f979c93' , '2023-04-20' , N'dị vật ở ngực', 2, ''),
	('321d5d0f522e1ba28bbb2243b6b18de8' , 'b6b447b56dbe005a626c4b5e3fdb97be' , '2023-04-21' , N'chăm sóc', 3, '' ),
	('008be4115afd1511f4cc2ae97c9834f0' , 'a61de36f81c0f699a8653863ea9e3d2f' , '2023-05-22' , N'xác định giới tính', 3, '' ),
	('3ff90b1c47898c6e576e8f109eba0bef' , '47b601885ddc891de11eb62451a97b43' , '2023-05-23' , N'chích vaccine', 1 , '' ),
	('21879306649bc1429b0f6d9d57217356' , '2f7294ec43136a43ca696ad6f06e1635' , '2023-05-24' , N'Bệnh béo phì', 3, '' ),
	('56e00973cbc998b7ddce6cdc45b3cd25' , '090f345a844fedfb9ca86ff69b59d969' , '2023-05-25' , N'Bệnh mổ lông', 2 , '' ),
	('8c6abf5a30122f683a29871b67190785' , 'd2601ee48263e69982e4dbd809c0358a' , '2023-05-26' , N'khối u ở chân', 5, '' ),
	('65a4f559051183b9a50cda6876422baa' , 'e221bebf131b7773da0045982e018fba' , '2023-06-27' , N'thiếu vitamin E', 3, '' ),
	('5fe272ab8622289deb002353518c8941' , '85c10fd22fe836139fd76fbaee831673' , '2023-06-28' , N'nội trú', 1, '' ),
	('5e6c49d4fffd4d10de12dc2de829029e' , 'b7ad6a62013acd21497265b6f7ff74eb' , '2023-06-30' , N'xác định giới tính', 2 , '' ),
	('52f50c616b0653a3fab725e6c2421692' , '3427f117121dd0789b94a37ef63b64dc' , '2023-07-01' , N'không phát hiện dị vật', 2, '' ),
	('6b0653af50c61fe6c3ab725522421692' , 'b7ad6137ff75b214972a6acd6206f4eb' , '2023-07-06' , N'xác định giới tính', 2, '' ),
	('ffd4d1092d5e6de12dc9d4fe82c4029e' , 'f1174d213346307894a92d177efbb6dc' , '2023-07-07' , N'xác định giới tính', 2 , '' );

INSERT INTO RecordServices (medicalRecordID, serviceID)
VALUES
	( '3b153a85daab45c693cdd0e1f02631c9', 'f8c17d469d7dfd4fa84eae659923536b'),
	( '87599195136fd0440b341eed32d36c84', 'c739c1e62319f52411908f874c0698bf'),
	( '4d0ac1b5e6f8e2e4ee256c4c2031b1d2', 'a074614583162a3d58b89c13699d70a1'),
	( 'b356f8672801e4820bd72b17dbda7764' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' ),
	( 'a0540a74c856251ad819d931fee6b078' , '744722e0fb1eb8e7f4fc5c4682159800' ),
	( '32fe2542e25434a1acde0f6edff2f0b4' , '84fbf5e32cfdb21cf48721cf849b0c20' ),
	( '2f6c8e2ec915f490a91c6c7e888126f6' , '517d8993ec9bcdb8c33fc50ea7ec5da8' ),
	( '21def0e373e1e8d57d1ab5f339726167' , '291129122c3e6bbbd76a76b428f2809a' ),
	( 'ff398a2c8cdd28c7c9e31446c0e2a629' , '52b7bedca394c621f40a99d03a564341' ),
	( '753906196d6e7bdd8f8d874efaacfa8d' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' ),
	( '4aa48bfce29088db4424a1b921e2be55' , 'f8c17d469d7dfd4fa84eae659923536b' ),
	( '154aa8864b0445239a1c8cf636ce8164' , 'c739c1e62319f52411908f874c0698bf' ),
	( 'b72e56f3705781fdfaa652dabbefd8b4' , 'a074614583162a3d58b89c13699d70a1' ),
	( '96f71fd09596eeda17b234c2a87b783f' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' ),
	( 'de9aa8254527b52b336a60f9373740ea' , '84fbf5e32cfdb21cf48721cf849b0c20' ),
	( '737cebac25159c2b8e46f50881a7abcb' , '517d8993ec9bcdb8c33fc50ea7ec5da8' ),
	( '1450707c9e9a8ea70f8d341e19e5a9bb' , '291129122c3e6bbbd76a76b428f2809a' ),
	( '321d5d0f522e1ba28bbb2243b6b18de8' , '52b7bedca394c621f40a99d03a564341' ),
	( '008be4115afd1511f4cc2ae97c9834f0' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' ),
	( '3ff90b1c47898c6e576e8f109eba0bef' , '507e4c66da1ccd4fcf621069065494bc' ),
	( '21879306649bc1429b0f6d9d57217356' , 'f8c17d469d7dfd4fa84eae659923536b' ),
	( '56e00973cbc998b7ddce6cdc45b3cd25' , 'c739c1e62319f52411908f874c0698bf' ),
	( '8c6abf5a30122f683a29871b67190785' , 'a074614583162a3d58b89c13699d70a1' ),
	( '65a4f559051183b9a50cda6876422baa' , 'cd9bfc9d6bb22a47f6dcdc2a5c99b2fd' ),
	( '5fe272ab8622289deb002353518c8941' , '744722e0fb1eb8e7f4fc5c4682159800' ),
	( '5e6c49d4fffd4d10de12dc2de829029e' , '517d8993ec9bcdb8c33fc50ea7ec5da8' ),
	( '52f50c616b0653a3fab725e6c2421692' , '291129122c3e6bbbd76a76b428f2809a' ),
	( 'ffd4d1092d5e6de12dc9d4fe82c4029e' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' ),
	( '6b0653af50c61fe6c3ab725522421692' , 'e41d8b0c31b65cc94f5eb4bbb7b76907' );

INSERT INTO RecordMedicine (medicalRecordID, medicineID, quantity, description_)
VALUES
('87599195136fd0440b341eed32d36c84', '1a27a82eb264532c271baf05c7a6e10d', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('87599195136fd0440b341eed32d36c84', 'c93c634859e543a562441ca36f9bd9f0', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('87599195136fd0440b341eed32d36c84', 'd0141bd1067e2f534fd908b54a72a1ff', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('4d0ac1b5e6f8e2e4ee256c4c2031b1d2', '7c7f0e401b7926cb956e1e798e7d6664', 12 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('4d0ac1b5e6f8e2e4ee256c4c2031b1d2', '2b1937a02cb1cc8255ecfeb8dc38c5d2', 6 , N'sáng: 1, trưa: 0, chiều: 1, tối: 0'),
('4d0ac1b5e6f8e2e4ee256c4c2031b1d2', '589ff60828e99f431d7f07d8ef62baff', 12 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('4d0ac1b5e6f8e2e4ee256c4c2031b1d2', 'f9a7dfe69faaaf1f0c2dc348c0254d50', 9 , N'sáng: 0, trưa: 1, chiều: 1, tối: 1'),
('b356f8672801e4820bd72b17dbda7764', '5f7fb0d98491f5efdf52623a7d4839aa', 12 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('b356f8672801e4820bd72b17dbda7764', '8e89704ade7f8e48da32ce2d6bb15054', 9 , N'sáng: 1, trưa: 0, chiều: 1, tối: 0'),
('b356f8672801e4820bd72b17dbda7764', '7c7f0e401b7926cb956e1e798e7d6664', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('b356f8672801e4820bd72b17dbda7764', 'e365252333bf5bd19b86b828e64b0eb0', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('b356f8672801e4820bd72b17dbda7764', '7c6164ddf235787f5d1e2d8f4540c838', 4 , N'sáng: 1, trưa: 0, chiều: 1, tối: 1'),
('32fe2542e25434a1acde0f6edff2f0b4', '9faeec1795e05223ab80bf4d06971616', 4 , N'sáng: 1, trưa: 0, chiều: 1, tối: 1'),
('21def0e373e1e8d57d1ab5f339726167', '9e9af1d637a369cdaf6bac028b8bd813', 3 , N'sáng: 1, trưa: 0, chiều: 0, tối: 0'),
('21def0e373e1e8d57d1ab5f339726167', '9faeec1795e05223ab80bf4d06971616', 3 , N'sáng: 1, trưa: 0, chiều: 0, tối: 0'),
('4aa48bfce29088db4424a1b921e2be55', '9dc94408c0e9b062a5cdd03830011d72', 4 , N'sáng: 0, trưa: 1, chiều: 1, tối: 0'),
('4aa48bfce29088db4424a1b921e2be55', '7c6164ddf235787f5d1e2d8f4540c838', 6 , N'sáng: 0, trưa: 1, chiều: 1, tối: 1'),
('4aa48bfce29088db4424a1b921e2be55', '124b0999a2e3a37b30f8b4d4196d5666', 4 , N'sáng: 0, trưa: 1, chiều: 1, tối: 0'),
('154aa8864b0445239a1c8cf636ce8164', '124b0999a2e3a37b30f8b4d4196d5666', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('154aa8864b0445239a1c8cf636ce8164', '9dc94408c0e9b062a5cdd03830011d72', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('154aa8864b0445239a1c8cf636ce8164', 'f9a7dfe69faaaf1f0c2dc348c0254d50', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('154aa8864b0445239a1c8cf636ce8164', '8e89704ade7f8e48da32ce2d6bb15054', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('b72e56f3705781fdfaa652dabbefd8b4', 'd0141bd1067e2f534fd908b54a72a1ff', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('b72e56f3705781fdfaa652dabbefd8b4', 'c69f4b52c792233f31e11393012e5e19', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('96f71fd09596eeda17b234c2a87b783f', '9dc94408c0e9b062a5cdd03830011d72', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 1'),
('de9aa8254527b52b336a60f9373740ea', '9faeec1795e05223ab80bf4d06971616', 9 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('de9aa8254527b52b336a60f9373740ea', 'f9a7dfe69faaaf1f0c2dc348c0254d50', 3 , N'sáng: 0, trưa: 0, chiều: 1, tối: 0'),
('de9aa8254527b52b336a60f9373740ea', '5f7fb0d98491f5efdf52623a7d4839aa', 3 , N'sáng: 0, trưa: 0, chiều: 1, tối: 0'),
('de9aa8254527b52b336a60f9373740ea', 'e365252333bf5bd19b86b828e64b0eb0', 3 , N'sáng: 0, trưa: 0, chiều: 1, tối: 0'),
('de9aa8254527b52b336a60f9373740ea', '8e89704ade7f8e48da32ce2d6bb15054', 3 , N'sáng: 0, trưa: 0, chiều: 1, tối: 0'),
('21879306649bc1429b0f6d9d57217356', '1a27a82eb264532c271baf05c7a6e10d', 10 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('21879306649bc1429b0f6d9d57217356', 'c93c634859e543a562441ca36f9bd9f0', 10 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('21879306649bc1429b0f6d9d57217356', '2b1937a02cb1cc8255ecfeb8dc38c5d2', 12 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('56e00973cbc998b7ddce6cdc45b3cd25', '589ff60828e99f431d7f07d8ef62baff', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('56e00973cbc998b7ddce6cdc45b3cd25', '7c7f0e401b7926cb956e1e798e7d6664', 6 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('56e00973cbc998b7ddce6cdc45b3cd25', 'd0141bd1067e2f534fd908b54a72a1ff', 4 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('8c6abf5a30122f683a29871b67190785', '976f58180ccfd7c80f492b1665fd003a', 8 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('8c6abf5a30122f683a29871b67190785', '9faeec1795e05223ab80bf4d06971616', 8 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('8c6abf5a30122f683a29871b67190785', '9e9af1d637a369cdaf6bac028b8bd813', 8 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0'),
('65a4f559051183b9a50cda6876422baa', '2b1937a02cb1cc8255ecfeb8dc38c5d2', 6 , N'sáng: 1, trưa: 0, chiều: 1, tối: 0'),
('65a4f559051183b9a50cda6876422baa', '5f7fb0d98491f5efdf52623a7d4839aa', 8 , N'sáng: 1, trưa: 1, chiều: 1, tối: 0');

INSERT INTO Feedback (feedbackID, appointmentID, feedbackContent, title, feedbackTime, rating)	
VALUES
	( 'a4e6c35adb5663181253e2c610ceb080' , 'a6a837e5d05e57e160dea29c335f30d0', N'Các nhân viên phòng khám đã vượt lên trên tất cả để đảm bảo sự thoải mái và hài lòng cho tôi. Từ sự chào đón nồng nhiệt tại quầy lễ tân đến các y tá và bác sĩ tận tình, dịch vụ khách hàng đặc biệt của họ thực sự nổi bật.', N'Dịch vụ khách hàng rất tốt', GETDATE(), 5),
	( '1926f20e0d3c56f9a5e4d9dea3a1ca23' , '95b579fe61c622b5c50def9dccb66bdc', N'Cơ sở vật chất hiện đại của phòng khám đã gây ấn tượng với tôi. Các thiết bị hiện đại và môi trường thoải mái đã góp phần tạo nên trải nghiệm tích cực và không căng thẳng trong chuyến thăm của tôi.', N'Cơ sở vật chất hiện đại', GETDATE(), 4.5),
	( 'c7c84d9b4f86cab7091dfc674da2d233' , '86ae960dc44eba248c481d76520846c3', N'Các bác sĩ tại phòng khám này có kiến ​​thức cao trong lĩnh vực tương ứng của họ. Họ đã dành thời gian để giải thích cặn kẽ về tình trạng cho chim của tôi, giải đáp mọi lo lắng của tôi và đưa ra các phương án điều trị thích hợp.', N'Bác sĩ chuyên nghiệp', GETDATE(), 4),
	( 'b85f8bf4eef0d6343a8ac49e824fdb77' , '801b58e3d0b00f7f9f9eac80058f99f0' , N'Hệ thống đặt lịch hẹn phòng khám là hiệu quả và thuận tiện. Tôi đánh giá cao việc đặt lịch hẹn dễ dàng như thế nào và nhân viên đảm bảo giảm thiểu thời gian chờ đợi, cho phép tôi quản lý lịch trình của mình một cách hiệu quả.' , N'Lên lịch hẹn hiệu quả' , GETDATE(), 4.5 ),
	( '3871a21957320daf0208624dea20b3db' , 'ca768c1b1876a2f286496e62666dfada' , N'Các nhân viên phòng khám có vẻ coi thường tôi, họ nói chuyện với tôi một cách cẩu thả và qua loa nhưng may là vẫn được các bác sĩ nói chuyện thân thiện và nhiệt tình' , N'Nhân viên không thân thiện' , GETDATE(), 2.5 ),
	( 'c3f1ad462249f3d02191d1a9a872e881' , '0a7a30124b6b4f266459a6b69677152c' , N'Phòng khám duy trì một môi trường sạch sẽ và hợp vệ sinh, điều cần thiết cho bất kỳ cơ sở y tế nào. Tôi cảm thấy yên tâm khi biết rằng các biện pháp vệ sinh phù hợp đã được áp dụng.' , N'Môi trường sạch sẽ và hợp vệ sinh' , GETDATE(), 4),
	( 'b529c5b6c02436d52646b251135a8580' , 'ebcf025d47ee19d929f6707029df09d0' , N'Các bác sĩ tại phòng khám này đã đưa ra chẩn đoán kịp thời và chính xác, cho phép điều trị kịp thời. Chuyên môn và sự chú ý của họ đến từng chi tiết rất đáng khen ngợi.' , N'Chẩn đoán kịp thời và chính xác' , GETDATE(), 4.5 ),
	( '6b608c52effdd5d149613fd5ebf4c55c' , 'b7e4621ca7d7273ea67ba0b40992d189' , N'Phòng khám này cung cấp các dịch vụ y tế tạm được, chỉ phục vụ cho các nhu cầu y tế, không có quá nhiều dịch vụ.' , N'Dịch vụ Y tế tạm được' , GETDATE(), 3 ),
	( 'e4da29dfa2d7f2e893b7068eba2f2665' , '35847b5a3a8de7e0af06281b1d889bcf' , N'Phòng khám vượt trội trong giao tiếp. Các bác sĩ và nhân viên chăm chú lắng nghe những lo lắng của tôi và truyền đạt rõ ràng, đảm bảo rằng tôi hiểu rõ quá trình điều trị và bất kỳ bước tiếp theo cần thiết nào.' , N'Giao tiếp xuất sắc' , GETDATE(), 5 ),
	( 'c208fe80be67e0ac443894edf9048959' , 'ca05b981160139795fbf616bfd5d491b' , N'Phòng khám cung cấp dịch vụ chăm sóc cá nhân phù hợp với từng nhu cầu của bệnh nhân. Họ đã dành thời gian để hiểu hoàn cảnh đặc biệt của chim tôi, đảm bảo một kế hoạch điều trị cá nhân và hiệu quả.' , N'Chăm sóc cá nhân' , GETDATE(), 5 ),
	( '95e8fffd6181170d848151e13d25c397' , '943b4c67a61164d245ea5af7f3848a37' , N'Phòng khám có một bầu không khí tích cực và chào đón khiến tôi cảm thấy thoải mái ngay lập tức. Những nụ cười thân thiện và môi trường hỗ trợ đã góp phần tạo nên trải nghiệm không căng thẳng.' , N'bầu không khí tích cực' , GETDATE(), 5 ),
	( 'bfbc8861190e55a089b0c4afc1c41a07' , '040c93cff9c0cc5cd6d008fb02e17b69' , N'Phòng khám duy trì thực hành giá cả minh bạch. Họ cung cấp giải thích chi tiết về các chi phí liên quan, đảm bảo không có bất ngờ hoặc phí ẩn.' , 'Định giá minh bạch' , GETDATE(), 5 ),
	( '4dcb301699e281d9eda42ee915f8c91d' , '3841cd8942a581d2092ff1d3739fcebc' , N'Các quy trình theo dõi hiệu quả của phòng khám đã gây ấn tượng với tôi. Họ nhanh chóng lên lịch cho bất kỳ cuộc hẹn tiếp theo cần thiết nào và đảm bảo sự chăm sóc liên tục.' , N'Quy trình theo dõi hiệu quả' , GETDATE(), 5 ),
	( '3f8c2d5acfcad832c564afe05fdc4dd2' , '4a160bb951e81bb14485ab90391d0c58' , N'Phòng khám này tích hợp công nghệ hiện đại vào thực hành của họ. Từ hồ sơ y tế điện tử đến các công cụ chẩn đoán tiên tiến, cam kết đổi mới của họ là điều hiển nhiên.' , N'Tích Hợp Công Nghệ Hiện Đại' , GETDATE(), 5 ),
	( '02025191b401a33ee5d5dbf672b0d9cd' , 'aeed52468a0d9880fa013c611816e897' , N'Phòng khám đặt trọng tâm mạnh mẽ vào lời khuyên dành cho chim. Họ cung cấp cho tôi những thông tin có giá trị về tình trạng của chim, giúp tôi đưa ra những quyết định sáng suốt về sức khỏe của chim.' , N'Chú trọng vào lời khuyên chăm sóc chim' , GETDATE(), 5),
	( 'f31300a92d53523f7c9e63f082429559' , 'cde92de8a056398e6a281dba87bdffb1' , N'Vị trí thuận tiện của phòng khám làm cho nó dễ dàng tiếp cận. Vị trí gần với phương tiện giao thông công cộng và nhiều lựa chọn đỗ xe là một sự thuận tiện tuyệt vời.' , N'Vị trí thuận tiện' , GETDATE(), 5 ),
	( '021c8752a33aa45ffaabbc24b9718c65' , '6c3b331b0cde4d503944f2f16f979c93' , N'Phòng khám nuôi dưỡng một môi trường tôn trọng và không phán xét. Các nhân viên đối xử với mọi người một cách đàng hoàng và tôn trọng, tạo ra một không gian an toàn cho chim.' , N'Môi trường tôn trọng và không phán xét' , GETDATE(), 4.5 ),
	( '2b72c3de10429d9be2c5b7f6fb799eb7' , 'b6b447b56dbe005a626c4b5e3fdb97be' , N'Phòng khám cung cấp hỗ trợ theo dõi toàn diện. Họ đã chủ động trong việc đảm bảo sự tiến bộ của chim và giải quyết mọi vấn đề sau điều trị.' , N'Hỗ trợ theo dõi toàn diện' , GETDATE(), 5),
	( 'b3ce71cf9331b8139a30efa95f01af8a' , 'a61de36f81c0f699a8653863ea9e3d2f' , N'Các dịch vụ theo toa của phòng khám rất hiệu quả và không rắc rối. Các nhân viên đã nhanh chóng xử lý đơn thuốc cho chim, giảm thiểu bất kỳ sự bất tiện nào.' , N'Dịch vụ kê đơn hiệu quả' , GETDATE(), 5 ),
	( 'c83755957ea168197e2362912cd8ebdc' , '47b601885ddc891de11eb62451a97b43' , N'Cách tiếp cận đồng cảm của phòng khám đối với bệnh nhân là đáng khen ngợi. Họ thực sự quan tâm đến sức khỏe của chim và thể hiện sự thấu hiểu trong suốt quá trình điều trị cho chim.' , N' Cách tiếp cận đồng cảm' , GETDATE(), 4.5 ),
	( 'a413ed3e5df4149bb41c5a55ab70cca8' , '2f7294ec43136a43ca696ad6f06e1635' , N'Đội ngũ nhân viên đa ngôn ngữ của phòng khám là một lợi thế lớn cho bệnh nhân đến từ nhiều nguồn gốc khác nhau. Khả năng giao tiếp bằng các ngôn ngữ khác nhau tạo điều kiện cho các tương tác hiệu quả giữa bác sĩ và chim của khách hàng.' , N'Bác sĩ giỏi ngoại ngữ' , GETDATE(), 5 ),
	( 'b2e26005217a74208df092883606602e' , '090f345a844fedfb9ca86ff69b59d969' , N'Phòng khám này cung cấp các đánh giá sức khỏe toàn diện nhằm cung cấp sự hiểu biết thấu đáo về sức khỏe tổng thể của chim. Những đánh giá chuyên sâu của họ vượt xa các cuộc kiểm tra thông thường.' , N'Đánh giá sức khỏe toàn diện' , GETDATE(), 5 ),
	( '288269426198f8724d0da8a362f7cc2d' , 'd2601ee48263e69982e4dbd809c0358a' , N'Phòng khám vượt trội trong quản lý đau. Họ cung cấp các phương pháp điều trị và trị liệu hiệu quả làm giảm đáng kể sự khó chịu của chim.' , 'Quản lý cơn đau hiệu quả' , GETDATE(), 5 ),
	( '6d8e4dfa0f9a9938e767039bba8c43b4' , 'e221bebf131b7773da0045982e018fba' , N'Khu vực chờ của phòng khám được chào đón và thoải mái. Bầu không khí dễ chịu và các tiện nghi chu đáo đã giúp tạo ra một bầu không khí thoải mái.' , N'Khu vực chờ thoải mái' , GETDATE(), 5 ),
	( 'af5013fa896bf00600b23c7a8b4995d4' , '85c10fd22fe836139fd76fbaee831673' , N'Tôi rất ấn tượng bởi hiệu quả của phòng khám trong việc cung cấp kết quả xét nghiệm. Họ cung cấp thông tin cập nhật nhanh chóng, đảm bảo các quyết định kịp thời liên quan đến điều trị tiếp theo, nếu cần.' , N'Kết quả kiểm tra nhanh chóng' , GETDATE(), 5 ),
	( 'd968f7543b03fafc1e2c306edbe73cd5' , 'b7ad6a62013acd21497265b6f7ff74eb' , N'Tôi đánh giá cao cách tiếp cận toàn diện của phòng khám đối với sức khỏe. Họ nhấn mạnh các biện pháp phòng ngừa, khuyến nghị về lối sống và các liệu pháp bổ sung bên cạnh các phương pháp điều trị y tế truyền thống.' , N'Phương pháp tiếp cận toàn diện đối với sức khỏe' , GETDATE(), 5 ),
	( 'bc049c5b9cc23a7252cd02aaef7d6571' , '3427f117121dd0789b94a37ef63b64dc' , N'Phòng khám này thể hiện cam kết cải tiến liên tục. Họ tích cực tìm kiếm phản hồi từ khách hàng để nâng cao dịch vụ của họ và trải nghiệm tổng thể của khách hàng và chim.' , N'Cam kết cải tiến liên tục' , GETDATE(), 4.5),
	( '1c693b7b7f4f3967d56242710d4a6925' , 'b7ad6137ff75b214972a6acd6206f4eb' , N'Các nhân viên điều dưỡng tại phòng khám này được đào tạo bài bản và chu đáo. Họ đã cung cấp dịch vụ chăm sóc tuyệt vời và luôn sẵn sàng giải quyết bất kỳ mối lo ngại nào.' , N'Nhân viên điều dưỡng được đào tạo bài bản' , GETDATE(), 4 ),
	( '4b9e4136b9380ce6264eba99e7cbecaa' , 'f1174d213346307894a92d177efbb6dc' , N'Dịch vụ chăm sóc hậu phẫu của phòng khám thật đặc biệt. Các nhân viên cung cấp các hướng dẫn rõ ràng về chăm sóc sau điều trị và sẵn sàng giải đáp mọi thắc mắc hoặc lo lắng.' , N'Chăm sóc hỗ trợ sau thủ thuật' , GETDATE(), 4.5 );

INSERT INTO Blog (blogID, title, uploadDatetime, category, blogContent)
VALUES
	( '36c8417c829ea8b07014eb3ca7946fb0', N'Những kinh nghiệm quý báu khi nuôi chim sâu xanh', GETDATE(), N'kinh nghiệm nuôi chim', N'Ngoài việc được biết đến là một loài chim
	có ích cho cuộc sống con người. Chim sâu xanh còn được biết đến là một loại chim cảnh. Mặc dù việc nuôi chim sâu xanh không phải là khó nhưng cũng đòi hỏi ở người nuôi sự tỉ 
	mỉ kì công.
	Nhưng nếu bạn là một người có tình cảm đặc biệt với những chú chim này thì đó không phải là vấn đề gì quá khó khăn. Để giúp bạn có thêm kinh nghiệm trong việc chăm sóc 
	những chú chim đáng yêu này mời bạn theo dõi bài viết của chúng tôi dưới đây.
	1. Những kinh nghiệm quý giá khi nuôi chim sâu xanh
1.1 Chim sâu xanh ăn gì
Nghe tên gọi thôi là chúng ta có thể đoán được loài chim cảnh nhỏ nhắn đáng yêu này thích ăn gì rồi phải không nào. Chúng có thể ăn được các loại sâu tồn tại trong thiên nhiên vì đây là một loại thức ăn chính để chúng tồn tại. Tuy nhiên trong điều kiện nuôi nhốt ở trong lồng ngoài việc cho ăn các loài sâu trong tự nhiên ra. Thì bạn cần phải bổ sung cho chúng thêm một số thức ăn khác như trứng kiến, hoặc cám. Những loại thức ăn này đều có thể mang tới cho chúng được một chế độ dinh dưỡng hợp lý để chúng có thể phát triển toàn diện nhất.

1.2. Lồng nuôi cho chim sâu xanh
Lồng nuôi cho chi sâu xanh tốt nhất là nên chọn lông tre có chiều cao vừa phải vì như chúng ta đã biết thì kích thước của chim sâu xanh khá nhỏ nên nếu không lựa chọn được lồng hợp lý sẽ khó có thể mang tới cho chúng môt cuộc sống thoải mái nhất. Bên trong lồng nên để 1 khay đựng cám ( loại cám mà bạn hay mua ở những của hàng chim) một khay đựng sâu khô để đảm bảo được lượng thức ăn cho chúng. Ngoài ra một điều kiện bắt buộc phải có đó chính là nước nước, nếu bạn ở thành thị nước máy thì bạn nên xử lý qua để bớt clo. Mặc dù món ăn khoái khẩu của loài chim này là sâu tuy nhiên sâu mà chúng ta mua tại các cửa hàng không thể chất lượng bằng sâu mà chúng tự kiếm trong thiên nhiên được nên phải hạn chế và cho chúng ăn một số lượng cụ thể đừng lạm dụng sẽ khiến cho sức khỏe của chúng không được ổn định

1.3 Cách nuôi chim sâu đầu xanh con
Khi bạn bắt được chim sâu đầu xanh non thì đỏi hỏi quá trình chăm sóc phức tạp hơn một chút. Bạn phải giành thời gian để đút cho chúng ăn vì lúc này chúng chưa thể tự ăn được như những chú chim trưởng thành khác. Nhưng đây cũng được coi là một trong những giai đoạn tuyệt vời nhất của người chơi chim. Bởi nó sẽ là một chất keo kết dính để khiến cho tình cảm của bạn và những chú chim này được kết nối. Giai đoạn này thức ăn tốt nhất cho chim sâu non là cào cào. Bạn cũng đừng quên cho chúng uống nước. Những chú chim non 1 ngày ăn rất nhiều lần nên bạn hãy để ý nếu không muốn chúng lả đi vì đói.

Sau khoảng thời gian hơn 1 tháng là những chú chim này đã đủ lông đủ cánh, việc ăn uống và bay nhảy chúng đều có thể chủ động được rồi. Việc chăm sóc của bạn cũng không còn quá vất cả như trước nữa. Chính vì vậy lúc này bạn chỉ cần chuẩn bị đầy đủ thức ăn cho chúng, nhớ là phải thường xuyên tiếp xúc với chúng để chúng không nhát người nhé

1.4 cách nuôi chim sâu xanh khi mới bẫy được
Nhiều người chia sẻ rằng họ không thể nuôi được những chú chim sâu mà họ bẫy được. Thật ra cũng không có gì quá khó. Đầu tiên bạn cần trùm 1 chiếc áo lồng và để  trong khoảng thời gian 2 ngày Nhớ là trong đó bạn phải chuẩn bị đầy đủ thức ăn cho chúng đầy đủ. Hãy để ý đến lượng thức ăn nếu như bạn thấy thức ăn mà bạn chuẩn bị trong lông bị vơi đi chứng tỏ là chúng đã chịu ăn và chắn chắn chúng sẽ sống. Cứ để đó trong khoảng 2 ngày rồi từ từ tháo áo lồng ra nhớ là giai đoạn này.

Bạn nên chỉ hé một chút để chúng tập làm quen dần, thậm chí nhiều con sẽ phá phách, bay nhảy lung tung dẫn đến chảy máu nhưng bạn đừng lo. Tiếu đến vài ngày sau bạn lại hé áo lồng thêm 1 chút nữa sau đó quay cho áo lồng đi mọi hướng. Thỉnh thoảng hướng đến nơi có nhiều người qua lại. Chúng sẽ sợ hãi mà nhảy nhót lung tung thậm chí là phá phách, nhưng chắc chắn là một thời gian chúng sẽ quen và sẽ trở lại là một chú chim hiền lành ngoan ngoãn.

Bước tiếp theo là bạn vào cám cho chim ăn. Bạn cần chuẩn bị 3 cóng. 1 cái để dựng nước cong lại  2 cóng cong lại chia để tỉ lệ sâu và cám trộn lẫn với nhau. Đầu tiên chúng sẽ ko hót nhưng khoảng 1 vài tuần khi đã quen với cuộc sống trong lồng thì bạn hoàn toàn có thể lắng nghe tiếng chim sâu xanh hót đấy

2. Kinh nghiệm nuôi chim sâu xanh đẻ
Để có thể giúp bạn tự mình cho ra đời được những chú chim sâu non để phục vụ một cách tối đa cho thú vui của mình. Chúng tôi cũng mang đến cho bạn cách nuôi chim sâu xanh để đây là một trong những kỹ thuật mà nhiều người đã sử dụng và rất thành công. 

2.1 Lồng và vị trí đặt cho chim sâu xanh đẻ
- Về cơ bản về việc chọn lồng chim nuôi chim sâu xanh đẻ cũng không khác quá nhiều so với việc bạn nuôi chim sâu xanh đấu cội. Khi lựa chọn lồng thì bạn cũng chỉ nên lựa chọn một loại lồng có khoảng cách nan vừa phải kích thước lồng cũng không cần quá cao đủ để chúng có thể hoạt động được ột cách thoải mái nhất mà lại không thoái được ra ngoài.

Tuy nhiên bạn đặc biệt phải lưu ý rằng khi nuôi chim sâu xanh đẻ việc lựa chọn vị trí đặt lồng cũng như việc che chắn lòng là một trong những yếu tố vô cùng quan trọng. Với bản năng của mình chúng sẽ rất nhạy cảm với môi trường xung quanh.  Về cơ bản thì bạn phải che đậy một cách tỉ mỉ để chúng cảm thấy an tâm nhất. Các vị trí để che lồng gần như là tất cả bạn chỉ bỏ trốn phần cửa để tiện việc cho ăn cũng như tiện cho việc chúng tắm và sưởi năng, đỉnh lồng thì bạn cũng nên che lại 50%

- Về vị trí đặt lồng bạn cần phải cân nhắc trong thời gian chúng ghép cặp và đẻ chỉ khi nào chúng cảm thấy đó là một vị trí an toàn chúng mới bắt đầu sinh sản. Vì vậy trong cách nuôi chim sâu xanh đẻ không ngoa khi nói rằng đây là một trong những tiêu chí quyết định đến sự thành công trong việc nuôi chim sâu xanh đẻ nếu vị trí lồng được bài trí một cách khoa học nhất việc đón những chú chim nhỏ ra đời sẽ không còn quá xa.

2.2 Cách bài trí lồng cho chim sâu xanh đẻ
Vì là lồng thiết kế dành riêng cho loại chim sâu đẻ chính vì vậy mà trong lồng ngoài cóng nước cũng như máng đựng thức thức ăn thì trong cách bài trí trong lòng cũng có một chút khác biệt đó chính là việc bạn nên để một chiếc rổ để cho chim sâu có thể làm tổ. Và bạn cũng đừng quên để cho chúng chút rơm dạ để chúng có thể xây và lót tổ. Ngoài ra trong cách treo lồng chim dành cho chim sâu làm tổ thì vị trí lý tưởng nhất phải khuất gió không được để gió mạnh quá mà không được treo nghiêng như vậy vì nếu như bạn theo nghĩa sẽ có thể khiến cho trứng chim bị rơi ra ngoài.



Theo như những người nuôi chim sâu xanh sinh sản lâu năm cho biết rằng nếu như ở tại vị trí treo lồng chim là những vị trí có cây cối lúc này sẽ rất thích hợp để giúp cho những chú chim có thể tự tin hơn trong việc sinh sản.

2.3 Cách lựa chọn chim sâu xanh ghép cặp
Về cách lựa chọn chim sâu xanh để ghép cặp và sinh sản thì bạn cũng cần phải cân nhắc nên. Ưu tiên để lựa chọn những chú chim sâu xanh đã có thờ một thời gian nuôi nhốt ở trong lồng vì lúc này chúng đã quen với môi trường nuôi nhốt nên cũng không quá khó khăn nếu như bắt cặp thành công thì cũng là lúc mà chúng sẽ tiến hành sinh sản.

Ngoài ra để có thể ghép cặp cho chim sâu xanh sinh sản thì người nuôi chim hoàn toàn có thể sử dụng một chú chim được bẫy ở ngoài rừng. Những chú chim được bẫy ở ngoài rừng vệ sẽ mang đến những tố chất cực kỳ tuyệt vời. Tuy nhiên thời gian để nuôi chim sâu xanh sinh sản đối với những chú chim này được đánh giá là khá lâu vậy đòi hỏi người nuôi chim để có được một sự kiên trì.

Một cách ghép cặp chim sâu xanh sinh sản khác đi rất nhiều người áp dụng đó chính là việc bắt cả một cặp ở ngoài thiên nhiên đối với những cặp chim này chỉ mất thời gian để cho chúng quen với môi trường mới có việc ghép cặp và sinh sản của chúng chắc chắn sẽ thành công.

2.4 Thức ăn cho chim sâu xanh sinh sản
Về cơ bản thức ăn để nuôi chim sâu xanh sinh sản cũng bao gồm môi tươi và các loại cám. Trước tiên về mồi tươi thì là điều rõ ràng rồi đây chắc chắn là một trong những loại thức ăn cần thiết để giúp cho những chú chim có đủ chất dinh dưỡng nhất. Còn đối với các loại cám chim thì bạ nên lựa chọn những loại cám chim dành riêng cho chim sinh sản. Các thành phần dinh dưỡng trong các loại cám này cũng sẽ đảm bảo cho những chú chim có thể cho ra đời từ những quả trứng tốt  Ngoài ra nếu bạn có được một công thức nào riêng biệt bạn hoàn toàn có thể tự tay làm cám để cho chúng được đầy đủ nhất.

Trong quá trình chim ấp bạn đừng nên làm phiền chúng. Lúc này bạn cũng nên chuẩn bị cho chúng một lượng thức ăn dồi dào vì khi chúng thấy lượng thức ăn là đủ để chúng nuôi dưỡng con. Chúng sẽ tự tin hơn để có thể tập trung vào việc ấp trứng. Tuyệt đối đừng để cho bất kỳ một loại vật nào nguy hiểm đến gần tổ chim của chúng nếu không sẽ làm chúng hoảng loạn và sẵn sàng bỏ tổ.

2.5 Tách chim sâu non
Thời gian đầu bạn gần như không cần phải lo lắng bất cứ một điều gì ngoài việc nạn cung cấp cho chúng đầy đủ dinh dưỡng và thức ăn để cho chúng nuôi con vì ở trong giai đoạn nuôi con của chim sâu xanh là một trong những giai đoạn khiến cho chúng cảm thấy mệt mỏi cũng như cạn kệt rất nhiều sinh lực. Vì vậy là lượng thức ăn trong thời điểm này cũng phải được tăng cũng như nên bổ sung thêm nhiều các loại thức ăn tươi để cho chúng có thể hồi phục được năng lượng.

Trong khoảng thời gian từ 2 tuần bạn nên tách chim sau con và có thể tự chăm sóc cho chúng ăn được rồi. Khi bạn chăm sóc những chú chim sâu nhỏ thì bố mẹ của chúng phục hồi lại sức khỏe để chuẩn bị cho một sinh sản kế tiếp. Như vậy đến đây về cơ bản là cách nuôi chim sâu xanh sinh sản đã thành công và bạn chắc chắn sẽ cảm thấy rất vui với những thành quả mà mình có thể đạt được

Hi vọng rằng với những kinh nghiệm nuôi chim sâu đầu xanh mà chúng tôi mang đến cho các bạn sẽ góp phần mang đến cho các bạn những kinh nghiệm quý giá nhất. Ngoài ra chúng tôi cũng man tới cho bạn những kinh nghiệm để nuôi chi sâu xanh đẻ. Đừng quên ghé thăm Chú Gióng mỗi ngày để cập nhật nhiều thông tin cũng như kinh nghiệm nuôi chim sâu xanh. Chúc các bạn thành công trong việc chăm sóc chú chim sâu xanh để đạt được chất lượng cao nhất. Hẹn gặp lại các bạn ở bài viết tới.'),
	( '40f3cc38ef656d749d2e2a368b59711e', N'Cách phân biệt chim sâu xanh trống mái chính xác nhất',  GETDATE(), N'phân biệt chim',
	N'Việc phân biệt chim sâu xanh đối khó vì chúng khá giống nhau, vì bộ long chúng chưa hoàn thiện nên các bạn chỉ nhìn đảo qua một vài lần và so sánh. Không nên nhìn chằm chằm vào 1 con, nhìn lâu sinh ra hiện tượng hoa mắt, cuối cùng là con nào cũng như nhau, nên không phân biệt được. Mời bạn theo giỏi bài viết sau đây để nhận biết chim sâu xanh trống mái một cách chính xác nhất.

Cách phân biệt chim sâu xanh trống mái chuẩn nhất
1. Phân biệt sâu đầu xanh chuyền trống, mái.

Với những chú chim sâu đang bay chuyển thì việc phân biệt chim không phải là điều đơn giản nhất là đối với những người không có quá nhiều kinh nghiệm. Sở dĩ việc này rất khó bởi lúc chim đang chuyển là lúc chúng đang hoàn thiện về bộ lông. Bạn có thể phân biệt chim sâu xanh trông mái bằng cách nhìn viền lông trước ngực. Nếu chú chim nào có ngực đen đậm cùng với đó 2 sợi lông đuôi dài hơn so với lông ở những chỗ khác thì đó là chú chim trống. Còn ngược lại những chú chim sâu xanh thì lông ở viền ngực sẽ nhạt hơn rất nhiều không có 2 sợi như chú chim trống.

Theo những người có kinh nghiệm trong việc lựa chọn chim sâu chuyền trông mái để lại rằng. Khi nhìn thì không nên nhìn quá chăm chú vào một con sẽ mất đi cảm giác và khi mất đi cảm giác rồi thì sẽ chẳng thể phân biệt được một cách chính xác nhất
2. Phân biệt sâu đầu xanh bổi trống, mái

Việc phân biệt chim sâu xanh trống mái bổi thì không quá khó khăn vì chúng đã có được một bộ lông hoàn chỉnh nhất. Khi này việc phân biệt chim trống mái không còn làm khó được bạn. Cho dù bạn là tay chơi chim chuyên nghiệp lão làng hay những người mới bắt đầu vào nghề cũng có thể nhận biết dễ dàng hơn bao giờ hết. Có 2 đặc điểm rất quan trọng và nếu muốn nhận biết chính xác được thì bạn phải để ý.



- Lông kiềng: Bạn để ý đến 2 viền lông ở trước cổ chim nếu những chú chim có màu đen đậm thì chắc chắn nó là một chú chim trống. Còn những chú chim mái thì bộ lông của chúng có màu rất nhạt. Không quá khó khăn phải không nào

- Đuôi lau : Đây là một đặc điểm có thể cho tỉ lệ chính xác đến 99,9%. Bởi những chú chim sở hữu đuôi lau thì hoàn toàn là trống. Bạn để ý kĩ phần duôi của chim những chú chim trống thường có 2 sợi lông đuôi ở giữa, và đặc điểm của những sợi lông này luôn dài hơn rất nhiều so với những chiếc lông còn lại khác. Những chú chim sâu xanh mái thì khác chúng không có 2 sợi này nếu mà có thì tỉ lệ tồn tại cũng rất thấp

Bạn có tin không những chú chim sâu xanh cũng có chim ái nam ái nữ đấy. Những chú chim này sở hữu một bộ đuôi không khác gì chim mái nhưng lại có 2 viền rất đậm giống như đặc điểm nhận dạng của chim trống. Đây là một loại chim sâu mà người ta cực kì ưa chuộng nếu như không muốn nói là săn lùng. Những chú chim này có nết chơi cực kì dữ, nó có thể hót đấu không biết mệt mỏi. Tỉ lệ những chú chim sở hữu nết chơi này là 9/10. Nên những chú chim này thường được những người sành chim sử dụng làm chim mồi. 

Ngoài ra để phân biệt chim sâu đầu xanh trống mai cũng còn một cách nữa. Nhưng cách này có một nhược điểm là không thể phân biệt được những chú chim khi chưa cất giọng hót. Nhưng dù trống hay mái những chú chim này bắt buộc phải sở hữu được một ngoại hình cân đối với dáng chuẩn, lông phải mượt không bị xoắn vào nhau. Đôi mắt có hồn và phải có chiều sâu, toàn thân không được có bất cứ một tật lỗi nào.

Hi vọng rằng với những kinh nghiệm trên giúp bạn có thể lựa chọn một chú chim sâu xanh trông mái như ý. Nếu bạn nào biết thêm những kinh nghiệm hay hơn nữa thì có thể chia sẻ để mọi người cùng tham khảo. Mong rằng loài chim sâu nhỏ nhắn xinh đẹp hót hay này sẽ mang đến cho những người yêu chim cảnh những giây phút bình an sảng khoái và tĩnh lặng nhất trong tâm hồn. Cảm ơn các bạn đả đọc bài viết và đừng quên hãy luôn ghé thăm wedsite Chú Gióng để cập nhật thêm nhiều thông tin về loài chim sâu nhé.'),
	( 'ff9086582c62af630123c568ca5db776', N'Top những loài chim cảnh biết nói thông minh nhất thế giới', GETDATE(), N'Top loài chim',
N'1. Chim Yến Phụng.
	Yến Phụng là một loài chim cực kì thông minh và có khả năng bất bước tiếng người cực kì giỏi. Chỉ cần chủ nhân của chúng dành nhiều thời gian để dạy dỗ chúng có thể nhớ 
	được rất nhiều từ. 
	Chúng cũng rất hiền lành và thân thiện với con người đặc biệt sở hữu một bộ lông sặc sỡ rất bắt mắt nên thường được lựa chọn để làm chim cảnh trong nhà. 
	Theo những người có kinh nghiệm nhận xét rằng một chú Vẹt Yến Phụng đực có khả năng bắt chước và phát âm chuẩn xác hơn so với những chú Vẹt Cái
2. Yểng.
	Trong số những loại chim cảnh biết nối thì Yểng được đánh giá cao nhất về khả năng phát âm chính xác và chuẩn về ngữ điều đến bất ngờ. Loài chim này cũng rất mau mồm mau 
	miêng lúc hứng lên
	chúng có thể nói cả ngày không chán. 
	Chúng sở hữu một màu lông xanh đen với chiếc mở màu được tô điểm bới lông sọc vàng. Thức ăn yêu thích của loài Yểng này là côn trùng và trái cây. 
	Đây cũng là một loại chim cảnh rất được ưa chuộng tại Việt Nam'),
	( '9b5aefbcffbf716f526dda302be5cdef' , N'Nuôi chim họa mi quan trọng nhất điều gì' , GETDATE() , N'kinh nghiệm nuôi chim' ,
N'Thật sự thiếu sót nếu bạn đang nuôi chim họa mi mà không biết đến những điều cần đặc biệt lưu ý trong quá trình nuôi dưỡng chúng. Trong việc chuẩn bị, chọn lựa thức ăn đến vệ sinh lồng nhốt, chăm sóc chim non, vv… đều cần có những kinh nghiệm riêng, không phải ai cũng nắm rõ, cũng xuất phát từ tình cảm đặc biệt mà chúng tôi dành cho họa mi và với mong muốn sẽ mang đến cho mọi người những bí quyết nuôi chim họa mi quan trọng nhất. Tất tần tất những điều quan trọng nhất về việc nuôi chim này sẽ được chúng tôi gửi đến trong bài viết dưới đây

Những lưu ý quan trọng trong việc nuôi chim họa mi. 
1. Về thức ăn dành cho chim họa mi.

Đúc kết kinh nghiệm từ những người nuôi chim họa mi trên khắp cả nước thức ăn dành cho chim họa mi đóng một vai trò không hề nhỏ quyết định đến ngoại hình, tính cách và giọng hót của chim. Vốn dĩ là một loài chim ở rừng núi họa mi tự nhiên ăn khá tạp chúng thích ăn côn trùng. Khi được thuần hóa và trở thành chim cảnh trong nhà thì chim được người nuôi cho ăn cám và giới chơi chim nói rằng nếu đã cho chim ăn cám thì mãi mãi chỉ cho chim ăn cám. Lượng thức ăn bên ngoài khác như thịt, trừng kiến...bổ xung khi chim cần đến dinh dưỡng cao hơn trong các giai đoạn phát triển. Ngoài ra chất lượng thức ăn dành cho họa mi cũng có những yêu cầu khắt khe. Gạo cho họa i ăn phải trắng, phải thơm ngon tuyệt đối không được mốc. Có như thế chim mới luôn khỏe mạnh. 

2. Lồng nhốt cho chim họa mi :

Khi nhốt chi họa mi trong lồng phải lựa chọn được lồng có độ cao cần thiết để phù hợp với dáng chim. Vì họa mi có kích thước cũng tương đối lớn so với những loài chim cảnh khác. Treo lồng cũng cần phải có những mẹo để chim mau chóng thích nghi được môi trường. Nên thay đổi vị trí treo lồng ở những nơi khác nhau để chị mạnh dạn hơn. Phải sử dụng áo lồng cho chim để tránh việc chim bị hoảng sợ. Chim họa mi là một loài chim rất dễ bị dị ứng nếu như lồng nuôi không đảm bảo được vệ sinh. Vị trí treo lồng cũng phải được lựa chọn chu đáo vì nếu như treo ở những nơi ẩm thấp có khói bụi, hay những nơi có nhiệt độ cao sẽ ảnh hưởng đến sức khỏe của chim. 
3. Lưu ý đến việc tắm cho chim.

Chim rất cần được tắm nắng để bổ xung những vitamin thiết yếu cho bộ lông. Việc tắm nắng cho chim cũng đòi hỏi những kĩ thuật tỉ mỉ. Không nên để chim ở những nơi có ánh nắng quá gắt nên tắm nắng cho chim 1 ngày 1 lần. Tắm nước cũng vậy cũng rất cần thiết để chim vệ sinh bộ lông của mình giúp cho lông chim luôn được óng mượt. 

4. Lưu ý đến cách phòng bệnh cho họa mi. 
Y học thú y phát triển cũng đồng nghĩa với việc bạn sẽ dễ dàng hơn trong việc tìm thuốc cho chim họa mi. Nếu bạn lo ngại những bệnh thường gặp đe dọa đến sức khỏe của chim thì nên tìm những loại thuốc phòng bệnh để chim luôn có được tình trạng sức khỏe tốt nhất 

5. Nếu bạn là người mới chơi họa mi.

Lời khuyên mà chúng tôi dành cho bạn chính là nên lựa chọn những chú chim đã được nuôi dưỡng qua để trải nghiệm. Bởi nếu bạn chưa có 1 chút kinh nghiệm nào mà nuôi họa mi con ngay thì chắc chắn sẽ gặp rất nhiều khó khăn. Chim họa mi khi được thuần thân thiện là vậy nhưng mới thì rất sợ tiếp xúc với con người. Nó sẽ chẳng có được một tâm lý tốt nhất nếu như bạn chưa có nhiều kinh nghiệm. Hơn nữa việc nuôi chim từ nhỏ phải trải qua một quá trình dài. Nếu không được chăm sóc kĩ càng sẽ có rất nhiều tật lỗi và giọng ca cũng chẳng thể nào xếp vào hàng danh ca được.

Hi vọng rằng những bí quyết nuôi chim hoạ mi mà chúng tôi sưu tầm từ những cao nhân chim cảnh sẽ phần nào giúp ích cho mọi người. Nhất là với những người đang mong muốn trở thành nghệ nhân, chỉ cần với tình yêu và phương pháo nuôi đúng kỹ thuật việc sỡ hữu một chú chim khỏe mạnh sẽ chẳng còn là vấn đề với các bạn. Hi vọng bài viết này sẽ giúp các bạn thành công trong việc nuôi một chú chim họa mi mà bạn yêu mến. Chúc các bạn may mắn'),
	( 'b1fa395c5fa8c10d20990274f0e57a85' , N'Những điều thú vị về tiếng chim hoạ mi hót' , GETDATE() , N'Những điều thú vị' ,
	N'Bất kì một người nuôi chim nào cũng mong muốn được nghe thứ âm thanh tuyệt vời ấy nhất là vào mỗi buổi sáng. Thứ âm thanh mà loại chim này mang lại cho người nghe cảm giác thoải mái, thư giản sau một ngày làm việc. Ẩn sâu trong tiếng hót mê hoặc ấy là những câu chuyện được giới chơi chim truyền lại. Vậy câu chuyện đó là gì? Hãy cùng tìm hiểu những điều thú vị trong tiếng hót của chim hoạ mi.

Nguồn gốc tiếng hót chim hoa mi qua câu truyện đầy thú vị.
Từ thuở xa xưa, mọi loài trên thế gian đều được thượng đế ban tặng cho một đặc điểm riêng biệt. Với hoa hồng thì chẳng gì hấp dẫn hơn với vẻ đẹp hương sắc. Đại bàng thì được ưu ái với ngoại hình dũng mãnh, sự mạnh mẽ xé tan bầu trời, đến cây cỏ thôi cũng có những sức hút ma mị làm vương vấn xuyến sao loài người… Chỉ duy nhất chim họa mi là chẳng có gì cả. Loài chim này vốn dĩ rất tự tin khi phải khoác trên mình bộ lông nâu xám tẻ nhat. Càng tự ti hơn nữa khi giọng hót của chúng chỉ là những tiếng kêu khàn khàn chẳng mang nổi 1 âm sắc. Dù rất cố gắng bắt chước giọng hót của những loại chim khác nhưng kết quả chỉ là sự bất lực. Nó rất khao khát để có được một giọng hót hay, nó mong muốn điều đó một cách tha thiết và sẵn sàng đổi bằng chính mạng sống của bản thân mình.

Quá xấu hổ về bản thân, nó cất cánh bay đi trong sự vô vọng, càng bay nó càng thấy mọi thứ trên thế gian này đều đẹp ngoại trừ nó. Cứ như vậy nó mang theo nỗi lòng nặng trĩu nhưng rồi từ trên cao nó nhìn thấy một bông hoa rực rỡ nằm sâu trong thân cây xấu xí đầy gai. Vẻ đẹp cảu bông hoa đó đã khơi dậy cho nó một sức sống diệu kì. Chim họa mi lao xuống như một mũi tên bất chấp nguy hiểm chỉ với mong ước được chiêm ngưỡng vẻ đẹp đó. Những chiếc gái sắc nhọn đã khiến cho lồng ngực của nó bắt đầu rỉ máu. Dường như thời điểm đó đã lay động đến trái tim của nó, trong lúc đau đớn nhất chim họa mi cất tiếng hót. Tiếng hót ấy trong như nước chảy, ngân nga vút lên lan tỏa khắp đất trời, nó hót như chưa bao giờ được hót, hót đến khi những giọt máu cuối cùng rỉ xuống khiến nó chết vì kiệt sức. Và từ đó chim họa mi được biết tới là loài chim có chất giọng hay nhất trần gian.

Những điều thú vị khác về tiếng hót chim họa mi
Câu truyện thú vị đó dường như đã ăn sâu vào tiềm thức của những người đam mê chim chân chính và cũng 1 phần có thể lý giải được tại sao người ta lại yêu họa mi đến như thế.  Vốn dĩ là một loài chim rụt rè nhút nhát, chim họa mi chỉ cất cao tiếng hát khi nó cảm thấy có cảm hứng cảm thấy mọi thứ xung quanh nó đều tốt đẹp.

điều thú vị về chim hoạ mi hót.

Chim hoạ mi hót dường như còn chất chứa bao nỗi niềm, những buổi trưa hè nắng chói chang hay những lúc oi bức khi trời dần chuyển về sáng. Phải tính tế lắm mới cảm nhận được tiếng hót sâu lắng trầm buồn của chúng, phải đồng cảm với loài chim này lắ mới có thể cảm nhận được giọng hót nho nhỏ, thình thoảng lại bọn ben chút vội vã, chút sôi nổi như những người tri kỉ đang tâm sự chuyện thế thái nhân tình. 

Chim hoạ mi hót cũng là một dấu hiệu để con người có thể nhận biết về thời tiết. Nếu giữa đêm khoảng 3 giờ sáng bạn bị đánh thức bởi tiếng to vang thì chắc chắn ngày hôm đó sẽ có thay đổi về thời tiết. Còn khoảng 6,7 giờ sáng thấy chim hoa mi hót hay, hót nhiều thì chẳng còn gì tuyệt vời hơn bởi hôm ấy là một ngày đẹp trời. Thú vị hơn mỗi khi chăm bẵm chúng cho chúng ăn rồi lại được nghe chúng hót lúc bầy giờ người nuôi chim mới có thể cảm nhận hết được cái ân cái tình của loài chim này.

Nhìn chung, chim họa my có lối sống khá tình cảm, tuy khó nuôi nhưng nuôi chim hoạ mi hót và hót hay thì lại càng khó. Chính vì vậy hãy chỉ nuôi khi bạn có tình yêu bất tận với chúng, có sự thấu hiểu với chúng. '),
	( 'db635b18aeddd06818d3eaee86183bab' , N'Top 5 loài chim chào mào hót hay được các đại gia săn lùng hiện nay' , GETDATE() , N'Top loài chim' , 
	N'Hiện nay thú vui sưu tầm và chăm sóc chim đang được các bạn trẻ và những doanh nhân thành đạt để mắt tới trong đó phải nói đến chim chào mào. Những chú chim chào mào hót hay thuộc hàng độc nhất vô nhị luôn được các đại gia săn đón và sẵn sàng chi với số tiền kết xù để sở hữu. Sở hữu chim hiếm còn thể hiện đẳng cấp của mình trong thú vui chơi chim và trong cuộc sống, góp phần không nhỏ giúp các doanh nhân thành đạt trong công việc.

Cho dù đang ở giữa thời buổi kinh tế khó khăn nhưng chẳng thể ngăn nổi cách mà các đại gia bạo chi, thậm chí có những người còn sẵn sàng bỏ ra số tiền lên đến cả trăm triệu cho những sự độc lạ của những chú chào mào quý hiếm này. Chắc chắn rằng quý độc giả cũng đang rất nóng lòng muốn biết tại sao những chú chim này lại trở thành niềm ao ước thầm của nhiều đại gia đến vậy. Cùng chúng tôi theo dõi trong bài viết dưới đây nhé.

1.Top những chú chim chào mào hót hay được yêu thích nhất
1.1: Chào mào Huế

Đến từ xứ Huế mộng mơ, mang trong mình giọng hót đặc trưng bởi vậy những chú chim xuất sắc luôn được các đại gia những người sành sỏi đi tìm. Đặc biệt giống chim này sở hữu một chất giọng cực độc theo giới chuyên môn gọi là giọng thổ to. Khi cất tiếng hót thì tiếng nào ra tiếng đó mỗi lần cất giọng lên là ra liền 6, 7 âm. Chính vì sự đặc biệt của giống chim chào mào quý này đòi hỏi người chơi phải rất sành sỏi, lồng phải được thiết kế tỉ mỉ hơn so với lồng chim thông thường. Sở dĩ rất nhiều người yêu thích loài chào mào này bởi khả năng thi đấu của nó rất tốt, nếu tuyển được một chú chào mào Huế chất lượng và được chăm sóc bởi những người sảnh sỏi nó có thể mang về cho chủ nhận những chiến thằng đầy thuyết phục trong các cuộc thi lớn.

1.2: Chào mào Trung Mang
Bất kì một người chơi chim sành sỏi nào cũng mong muốn sở hữu được một em Trung Mang, sở hữu cái độc đáo không đụng hàng của giống chim này. Thật may mắn khi những chú chim chào mào Trung mang được trời phú cho một chất giọng riêng biệt mà không một loài nào có thể có được. Mỗi khi những chú chào mào hay cất giọng vừa nhanh vừa uy lực trong giọng hót. Sau những giờ làm việc căng thẳng được thả hồn vào trong tiếng chim và nhâm nhi tách trà thư giãn chắc chắn rằng sẽ mang đến những giây phút yên bình và một sự bình an tĩnh lặng trong tâm hồn để nạp lại năng lượng cho những ngày làm việc mệt mỏi tiếp theo. Chính vì sự hiếm có, sự uy vũ trong ngoài hình, và tiếng hót độc lạ tất cả những điều trên có thể lý giải được tại sao đây cũng là giống chào mào được đại gia săn lùng và mong muốn được bổ xung 1 chú vào trong bộ sưu tập chim cảnh của mình.

1.3: Chào mào bạch tạng
Không thể bàn cãi về sự hiếm có khó tìm của nhưng chú chim chào mào biến đổi gien này được liệt vào hàng cực phẩm trong số các loài chim chào mào đắt tiền. Xét về khoa học mà nói những chú chim mang trên mình bộ lông trắng muốt là do cơ thể bị biến đổi gien hoặc chúng thiếu đi những sắc tố màu quan trọng nên toàn thân trở thành màu trắng. Tuy nhiên điều thú vị để những chú chim này xếp vào hàng đắt tiền là bởi trào lưu săn chào mào bạch tạng của giới chơi chim và đặc biệt là các đại gia lắm tiền nhiều của. Con nào lông càng trắng con nào ngoại hình càng độc cộng với dáng dấp chuẩn và giọng hát hay thì càng được tìm mua với giá trị khủng. Những đại gia sành sỏi về chim rất yêu thích những chú chim này. Một phần để chứng tỏ đẳng cấp, một phần là để thỏa mãn niềm đam mê của mình.

1.4: Chào mào hồng y giáo chủ (chào mào lửa).
Không biết giống chim chào mào đắt tiền này đến với chúng ta tự khi nào. Chỉ biết rằng đây là một loại chim được đại gia săn lùng và sẵn sàng bỏ ra một số tiền khổng lồ để mua nó. Có lẽ vẻ đẹp hoàn hảo đến từ những bộ cánh màu đỏ rực rỡ, bởi những chiếc mào đỏ trên đầu đã khiến cho những kẻ say chìm mê mệt. Những chú chim chào mào đắt đỏ này được ví như biểu tượng của sự may mắn, biểu tượng của sự tài lộc cho những ai sở hữu. Có lẽ cũng chính vì điều đó mà chúng được săn lùng với mong muốn mọi việc đều thuận lợi suôn sẻ. Chào mào hồng y giáo chủ cũng chính là một trong những món quà ý nghĩa được dùng để làm quà biếu.

11.5: Chào mào nữ hoàng

Chim chào mào nữ hoàng được coi là chú chim nghìn năm mới gặp 1 lần

Cũng giống như chào mào bạch tạng nhưng chim chào mào nữ hoàng được giới chơi chim rỉ tai nhau là loài chim trăm năm mới gặp 1 lần. Những chú chim này được ông trời khéo léo ban cho sự sắp xếp hài hòa trên cơ thể với bộ lông trắng từ từ yếm đến đầu, được tô điểm thêm một khoanh đỏ ở bên mắt tạo nên sự sang trọng đẳng cấp và quý phái. Tuy được các đại gia săn lùng những không phải ai cũng có duyên để mua được chú chim quý hiếm này đắt tiền này, thậm chí cũng có rất nhiều người có tiền nhưng cũng không thể mua được. Theo thông tin mà chúng tôi được biết thì hiện tại những chú chim chào mào nữ hoàng này có giá đến cả trăm triệu, thậm chí vài trăm triệu cũng có. Được sở hữu một chú chim hoàn hảo của tạo hóa chính là niềm ngưỡng mộ của chủ nhân sở hữu nó và là niềm ao ước thầm của bất kì một người đam mê chim cảnh nào

Ngoài những loài chim chào mào trên những chú chim đạt đến sự hoàn mỹ về chất giọng, đạt đến độ xuất sắc trong dáng dấp cũng được các đại gia hết sức quan tâm chi số tiền lớn mua để thỏa mãn niềm đam mê chim cảnh để bổ xung vào bộ sưu tập trong thú chơi ngông của chính bản thân mình.

2. Cách lựa chọn và nuôi chào mào hót hay
Nếu bạn không phải là một người mạnh về tài chính bạn vẫn hoàn toàn có thể tự nuôi dưỡng được một chú chào mào hót hay để phục vụ cho thú chơi của mình với đầy đủ cảm giác và đẩy đủ sự phấn khích nhất. Nhưng chắc chắn rằng để có thể sở hữu được một chú chim chào mào hót hay thì trong quá trình nuôi dưỡng cũng như chọn lựa cũng phải trải qua những công đoạn vô cùng cầu kì phức tạp.

Chúng tôi tin rằng với tình yêu đặc biệt với loài chim này với những thao tác chăm chút tỉ mỉ cẩn trọng cùng với những kinh nghiệm nuôi chim chào mào hót hay mà chúng tôi sẽ cùng bạn khám phá ở dưới đây. Chắc chắn bạn sẽ giúp cho những chú chim yêu quý của mình có thể phát huy được tất cả khả năng để có được một giọng ca đặc biệt

2.1. Kinh nghiệm lựa chọn chào mào hót hay
Ngoại hình cũng là một trong những tiêu chí quan trọng để người chơi chim có thể lựa chọn ra được một chú chim chào mào hót hay. Theo kinh nghiệm của những tay chơi lão luyện trong nghề chia sẻ lại thì tất cả những tiêu chí về ngoại hình đều ảnh hưởng trực tiếp đến chất giọng của một chú chim. Chính vì vậy việc lựa chọn những chú chim đáp ứng về tiêu chuẩn ngoại hình chắc chắn sẽ là yếu tố tiên quyết mà bạn cần phải chỉnh chu. Để lựa chọn được một chú chim chào mào hót hay bạn cần phải tỉ mỉ với rất nhiều những tiêu chí khác nhau:

- Trong cách chọn chim chào mào hót hay thì có lẽ đầu và mào là một trong những yếu tố quan trọng mà những người chơi chim phải cực kỳ chú trọng. Thậm chí nó còn được đánh giá là một trong những tiêu chí không thể thiếu được đối với một chú chim chào mào hót hay.

Khi bắt đầu lựa chọn chim bạn phải chú ý quan sát thật tỉ mỉ và chọn ra những chú chim sở hữu một cái đầu to. Thông thường những chú chim chào mào sở hữu một cái đầu to đa phần là những chú chim rất có bản lĩnh rất gan dạ. 

Tiếp đến bạn cần lựa chọn ra những chú chim sở hữu một trong 3 loại mào với độ ưu tiên là mào đinh, mào lân và mào cui. Đây đều là những loại mào được đánh giá rất cao không chỉ mang tới cho những chú chim chào mào một ngoài hình đẹp mà nó còn là biểu hiện của những yếu tố cần thiết khi chơi chim như bền bỉ, siêng hót. Và bạn cũng cần ưu tiên lựa chọn những chú chào mào sở hữu một gốc mào dày còn những chú mào có gốc mào mỏng vì nó ảnh hưởng tới ngoại hình và thường không bền chim.

- Những yếu tố khác cũng ảnh hưởng đến tố chất của một chú chim chào mào hót hay đó chính trông chúng lúc nào cũng phải thật nhanh nhẹn lanh lợi thường xuyên nhảy nhót và hoạt bát. Ngoài ra bạn cũng nên lựa chọn những chú chim sở hữu cho mình một thân hình vừa phải không quá dài và cũng không quá ngắn. 

- Những chú chim sở hữu một cặp ngực nở năng thì chắc chắn đó chính là những chú chim có phổi cực khỏe để từ đó có thể phát ra được những giọng hót to chắc khỏe và đanh thép. 

- Một chú chim chào mào hót hay thôi là chưa đủ mà một chú chim chào mào vừa hay vừa mau mỏ mới là một trong những tiêu chí được những người chơi chim yêu thích nhất. Chính vì vậy bạn nên lựa chọn một chú sở hữu được một cặp mỏ mỏng và ngắn chúng sẽ rất mau mồm và hót thường xuyên

- Ngoài ra những tiêu chí khác mà bạn cũng cần phải đặc biệt quan tâm đó chính là bộ lông mà chúng sở hữu phải thật mượt mà ép gọn vào thân không bị xù và tuyệt đối không bị chéo cánh. Tương tự như vậy phần lông đuôi cũng phải đảm bảo được tiêu chí gọn gàng dài, và xếp thành 1 cọng

2.2: Kinh nghiệm nuôi chào mào hót hay
2.2.1. Cách nuôi dưỡng

Sau khi bạn đã lựa chọn được những chú chào mào đáp ứng đủ tiêu chuẩn về ngoại hình. Lúc này việc nuôi dưỡng cũng là một trong những yếu tố cực kì quan trọng để giúp cho những chú chào mào của bạn có thể  phát huy được hết khả năng của mình và cũng là một trong những yếu tố cần thiết để giúp cho những chú chim của bạn có đủ sức khỏe để có thể mang tới những giọng hót tuyệt vời. Nếu như cách lựa chọn một chú chim chào mào hót hay ở phân trên là dựa trên kinh nghiệm của bạn. Thì đối với cách nuôi dưỡng ngoài kinh nghiệm bạn cũng phải gửi gắm vào trong đó tất cả những tình cảm, phải đầu tư thời gian công sức cũng như có một tình yêu đặc biệt. Như vậy mới chính là một trong những yếu tố quan trọng nhất để bạn có cơ hội sở hữu được một chú chim chào mào hót hay.

Thông thường những chú chim chào mào mà những người chơi chim bắt về đa phần là những chú chim chào mào bổi được bẫy ở ngoài thiên nhiên. Vì vậy đây là một trong những mốc thời gian vô cùng quan trọng đòi hỏi bạn phải có được những kinh nghiệm quý báu. Thời gian đầu khi chưa quen với cuộc sống gò bó trong lồng hẹp chúng sẽ rất dễ bị kích động thậm chí là tổn thương nếu như bạn không sử dụng áo lồng. Sau một thời gian khi chúng đã thích nghi được với môi trường bạn từ từ hé áo lồng để chúng quen dần với môi trường nuôi nhốt. Và từ từ mở áo lồng dần dần để chúng quen hơn. Mặc dù đó có là một chú chim xuất sắc nhưng đừng quá hiếu kì và tò mò mà lại gần nếu không bạn sẽ mất thêm rất nhiều thời gian để có thể thuần dưỡng được chúng. 

Khoảng một thời gian, thông thường là từ 3 đến 5 tháng lúc này những chú chim đã bắt đầu quen dần với việc bị nhốt ở trong lồng hãy mở áo lồng ra để cho chúng có thể thích nghi dần với chỗ ở mới. Việc lại gần của bạn lúc này cũng phải cần thận và chỉ xuất hiện khi cần thiết. Hãy xuất hiện lúc chúng cảm thấy đói nhất vì lúc này sau khi thấy bạn mang thức ăn và nước uống nó sẽ cảm nhận được sự an toàn và cảm nhận được sự xuất hiện của bạn là để bổ xung thức ăn. Như vậy việc thuần dưỡng chim của bạn cũng đã bắt đầu có được sự thành công. Kiên trì thêm một khoảng thời gian nữa là bạn đã hoàn toàn thuần phục được.

2.2.2 Chế độ dinh dưỡng

Về dinh dưỡng để nuôi dưỡng được một chú chim chào mào hót hay không phải là một trong những vấn đề gì đó quá khó khăn.

Là một trong những loại chim sống hoàn toàn trong tự nhiên chính vì vậy mà thức ăn của chúng đến từ các loại trái cây và hoa quả. Và đây cũng là một trong những loại thức ăn chính mà bạn cần phải nuôi dưỡng ngay cả trong điều kiện nuôi nhốt. Hãy cố gắng lựa chọn những loại quả vừa mang lại dinh dưỡng và ổn định cho hệ tiêu hóa của chim mà lại giúp trình có thể hấp thụ được sắc tố màu tự nhiên nhất để giúp cho bộ lông của chúng có được một màu sắc hoàn hảo. Các loại trái cây bạn nên dừng ở thời điểm này đó chính là chuối, đu đủ, dâu tây, cam... bạn nên cho chúng ăn 1 tuần khoảng 3 lần và thay đổi để tránh nhàm chán.

Ngoài ra bạn cũng nên kết hợp thêm cho chúng ăn thêm các loại sâu khô, cào cào và châu chấu. Đây là những loại thức ăn được đánh giá rất cao với hàm lượng dinh dưỡng cao sẽ khiến cho những chú chim của bạn được sung nhất. Cào cào thì bạn cho ăn 1 tuần 3 - 4 lần mỗi lần một vài cong, và tuyệt đối không nên cho chúng ăn sâu khô vào trong giai đoạn trứng thay lông. Vì như vậy sẽ ảnh hưởng rất và khiến cho bộ lông của chúng mất đi sự thậm mĩ.

Cam chim là một trong những loại thức ăn vô cùng quan trọng để giúp cho những chú chào mào của bạn khỏe mạnh và hót hay nhất. Bạn hoàn toàn có thể lựa chọn các loài cảm được bán sẵn trên thị trường. Ngoài ra bạn cũng như cũng có thể học hỏi các công thức được chia sẻ để giúp cho những chú chim của mình có được một chế độ dinh dưỡng đầy đủ vào ổn định cho hệ tiêu hóa nhất.

2.2.3. Chế độ tập luyện

Ngoài ra chế độ tập luyện để giúp cho chào mào hót hay cũng là một trong những yếu tố vô cùng quan trọng. Để có thể tập giọng cho những chú chào mào của mình lúc này bạn tìm những người cùng đam mê để cho chú chim của mình được giao lưu. Hay cứ mạnh dạn để mang những chú chi của mình đến các trường chim để cho chú chim chào mào yêu quý của bạn có thể thỏa sức thể hiện. Lúc này chú chi của bạn không chỉ trình phát huy được tối đa trong giọng hót mà còn có thể có cơ hội học hỏi được những âm điệu mới giúp đa dạng và hoàn thiện hơn giọng hót của mình.

Việc đem chim đi tập luyện thường xuyên không chỉ giúp cho chào mào hót hay mà còn giúp cho nó phấn khích và mau miệng nhất. Đây sẽ là một trong những yếu tố để giúp cho bạn có thể có được những giây phút bình an tĩnh lặng nhất để cân bằng lại cuộc sống sau những giờ học tập và làm việc mệt mỏi.

Chúng tôi tin chắc rằng tất cả những điều này sẽ chẳng còn là vấn đề khi bạn sở hữu được một chú chim chào mào với giọng hót hay. Vào mỗi sớm mai thức dậy, bạn được nghe những âm thanh thánh thót được phát ra từ chính những chú chim mà mình dày công chăm bẵm thì còn gì tuyệt vời hơn nữa. Chúc bạn luôn vui và thành công với niềm đam mê của mình.
'),
	( 'a66a0292d3af450e99bd42136898c36b' , N'Chế độ dinh dưỡng cho chim chào mào đấu hót' , GETDATE() , N'kinh nghiệm nuôi chim' , 
N'Như chúng ta đã biết, hiện nay thú vui chơi chim chào mào đặc biệt nở rộ trong những năm gần đây. Đây là dòng chim dễ nuôi, thức ăn chủ yếu là hoa quả, trái cây, đôi lúc là một ít cám thôi cũng đủ sống rồi. Thế nhưng để chăm ra một em chào mào căng lửa thì đã khó, nuôi ra một chú chào mào để đấu hót còn khó hơn bội phần. Thông qua bài viết này, Chú Gióng sẽ gửi đến bạn đọc cách nuôi chào mào thi đấu một cách đơn giản và dễ dàng nhất.

1. Thức ăn chính
Đối với chào mào, đây là loại chim không quá cầu kì trong nhu cầu dinh dưỡng, tuy nhiên chúng ta cũng cần phải đảm bảo nguồn cung cấp bổ sung vi chất dinh dưỡng mỗi ngày. Cám chim là một trong số các loại thực phẩm chính cho chim chào mào hiện nay đang được nhiều người sử dụng, phần vì tính cơ động và đảm bảo được nguồn cung cấp dinh dưỡng hằng ngày của chúng. Mặt khác, ta có thể trộn cám với một số thành phần bên ngoài để tăng lượng dinh dưỡng và khẩu vị như: trứng vịt, trứng gà, thịt rắn mối, thịt bò, tôm tươi…

2. Thức ăn bổ sung
Đối với chim chào mào, đây là nguồn năng lượng, nguồn thức ăn bổ sung không kém phần quan trọng. Chúng ta có thể kể đến như là trái cây,côn trùng, sâu quy…Đặc biệt trái cây chín là thức ăn ưa thích của chào mào, vì vậy người nào muốn học cách nuôi chim chào mào đấu thì không nên bỏ qua các bước tìm hiểu về loại thức ăn thơm ngon và giàu dinh dưỡng này. Có thể kể đến như là chuối, khoai lang, ổi, cà rốt… nói chung là các loại trái cây chín có vị ngọt. Tuy nhiên có ưu điểm là thế nhưng cũng phải hạn chế liều lượng thức ăn trong 1 tuần, bạn không muốn chú chim của mình ăn quá nhiều mà bị tiêu chảy đâu.

3. Nước uống
Nước uống sạch là đủ rồi, không cần phải đun sôi để nguội gì cả, tuy nhiên nên sử dụng nước để trong lu hoặc chum, tránh sử dụng trực tiếp nước máy nhiều Clorua như hiện nay.

Ngoài ra để chú chim của bạn khỏe mạnh mỗi ngày thì cần phải bổ sung chất vi chất dinh dưỡng - vô thuốc nữa. Tuy nhiên đây là con dao hai lưỡi, khi sử dụng thuốc phải hết sức cẩn thận và theo dõi sát sao bầy chim, phải hiểu thật rõ thì mới làm tránh những trường hợp đáng tiếc xảy ra.

Như vậy là chúng ta vừa điểm qua chế độ dinh dưỡng cho chim chào mào đấu hót, thiết nghĩ đây là những điều căn bản và cần thiết cho độc giả để tìm hiểu về cách nuôi chào mào thi đấu. Nuôi chim cảnh không chỉ giúp không gian gia đình thêm vui vẻ rộn ràng, khiến người nuôi chim giải tỏa căng thẳng sau những giờ làm việc mệt mỏi mà còn là một thú chơi hái ra tiền. Chúc các bạn thành công.'),
	( '0aa6e189009d5d7cf2a981e8387fff4d' , N'Kỹ thuật nuôi chim chào mào sinh sản và chăm sóc chào mào đẻ tốt nhất' , GETDATE() , N'kinh nghiệm nuôi chim' , 
N'Để phục vụ cho mục đích kinh doanh chim cảnh từ thú vui của chính bản thân mình và đã thành công, đó là áp dụng kỹ thuật nuôi chim chào mào sinh sản . Nếu như bạn muốn nuôi chim để sinh sản không phải để kinh doanh mà chị để phục vụ cho thú chơi của mình thì cũng hoàn toàn có thể. Nuôi chim chào mào sinh sản cũng không phải là điều gì đó quá khó nhưng cũng cần phải tuân theo một số những bước cơ bản để giúp những bạn đang có ý định có thể nắm bắt được những bước tốt nhất thì ở trong bài viết ngày hôm nay Chú Gióng sẽ giới thiệu đến các bạn những kỹ thuật nuôi chim chào mào đẻ tốt nhất.

Kỹ thuật nuôi chim chào mào sinh sản 
1. Cần phải chọn và nuôi chim bố mẹ tốt 

Trong cách chọn lựa một chú chim chào mào đẹp thì chúng tôi đã có rất nhiều bài viết bạn có thể tham khảo các bài viết này ở trên chuyên mục khác đây là một trong những bước quan trọng trong Kỹ thuật nuôi chim chào mào sinh sản. Điều quan trọng không kém trong việc nuôi chào mào sinh sản là chế độ dinh dưỡng cho bố mẹ của chúng. Điều này rất quan trọng điều này sẽ giúp cho những chú chim khỏe mạnh và chuẩn bị được cho quá trình giao phối của chim được tốt nhất. Còn những chú chim mẹ thì ngoài thức ăn bình thường bạn bổ xung thêm cám chuyên dụng cho chào mào sinh sản được bán trên thị trường. Nói chúng chế độ dinh dưỡng thì không có nhiều điều phải bàn cãi. 
2. Chuẩn bị lồng cho chào mào

Lông chào mào sinh sản không giống như nuôi làm cảnh cần phải có không gian rộng rãi thông thường nên tối thiểu là từ 180 cm (chiều dài), 120 cm (chiều rộng), 150 cm (chiều cao). Có trang bị thêm cho chúng vật liệu để chúng có thể làm ổ. Thức ăn và nước uống cũng không được thiếu ở trong lồng nếu như chào mào thấy dinh dưỡng không đủ chúng sẽ thôi đẻ hoặc ăn trứng của mình 

Khi chim chào mào trưởng thành thì bạn cho chúng bắt cặp với nhau bạn lựa chọn một con trông và 1 con mái nhốt chung. Bạn nên để ý đến hành động của chúng nếu như bạn thấy một trong haichú chim  này không đồng ý với việc bắt cặp với những chú chim còn lại thì có thể tách ra kẻ chúng có thể khác nhau đến chết. Còn nếu như chúng có biểu hiện hòa hợp thì chứng tỏ chúng bắt gặp đã thành công bạn có thể chuyển sang bước tiếp theo. Những lúc mà chim chào mào  đã bắt gặp thành công thì trong lồng bắt buộc phải có những vật liệu để cho chúng làm tổ bạn đừng có qua lại nhiều kẻo trúng sợ ảnh hưởng đến tâm lý. Khi chim đã giao phối thành công thì chào mào cái bắt đầu đẻ trứng thông thường những chú chim chào mào sẽ để từ 2 đến 4 quả. Cả chim trống và mái lúc này sẽ thay nhau ấp trứng
3. Giai đoạn chim đã nở con

Thông thường một chú chim con được ấp và nở ra trong khoảng từ 12 đến 14 ngày. Lúc này những chú chim mẹ sẽ thường xuyên khỏi tổ. Chúng sẽ đi tìm thức ăn vào những giờ buổi chiều hoặc là buổi sáng bạn phải đảm bảo thức ăn cho chúng lúc này trong lồng đầy đủ nhất sau khoảng thời gian thì những chú chim non đã bắt đầu mở và ra ngoài muốn những chú chim chào mào con có thể phát triển một cách nhanh chóng nhất thì ngoài  hoa quả gia bạn có thể bổ sung cho chúng thêm một số lượng côn trùng.  Bạn có thể đi mua sâu khô sau đó để vào lồng mẹ của chúng sẽ bón cho chúng. Lúc này bố mẹ chim chào mào đã trải qua một quá trình ấp trừng dài cho nên chúng tỏ ra yếu sức. Việc của bạn lúc này là sẽ phải bổ sung cho chúng một lượng thức ăn để chim hồi phục được nhanh nhất. Chim chào mào nuôi con chủ yếu phụ thuộc vào nước dãi cho nên càng cho ăn nhiều trái cây càng tốt sẽ giúp cho những chú chim non có thể có sức sức đề kháng từ nước dãi của bố mẹ. Đừng vì quá vui và háo hức  mà đến lồng chim của chúng xem thường xuyên nếu không chúng sẽ chẳng nuôi con nữa thậm chí sẽ cảm thấy lo lắng và khiến nên chúng con của chúng bị chết.
4. Giai đoạn chào mào con chuyền cành :
Khi giai đoạn những chú chim chào mào non bắt đầu học hót và truyền cành thì bạn phải bố trí trong lồng cầu để cho chim chào mào con có thể học được di chuyển một cách tốt nhất. Ở giai đoạn này bạn đừng nên cầm nắm hay xem sinh con quá nhiều nếu không sẽ  khiế chúng bị yếu xương. Lúc này thì chúng đã vận động tự học ăn cho nên thức ăn của bạn cũng phải tăng đầy đủ làm sao cho đủ cho cả đàn. 

Trên đây là tất cả những kỹ thuật nuôi chim chào mào sinh sản mà chúng tôi mang đến cho bạn. Hi vọng rằng bạn sẽ tuân thủ theo những kỹ thuật này để cho những chú chim của bạn có thể phát triển một cách đầy đủ nhất chúc bạn sẽ thuận lợi hơn cho việc kinh doanh hoặc là có thể sở hữu được cho mình những chú chim chào mào chất lượng phục vụ cho thú chơi của bạn sau này. Nếu như bạn thành công thì đừng quên chia sẻ với chúng tôi để những người khác có thể áp dụng bạn nhé. Hãy ghé thăm Chú Gióng thường xuyên để cập nhật cho mình những thông tin bổ ích nhé.
'),
	( '3f37126f037169bb080a309c88524d38' , N'Cách lựa chọn chim chào mào đẹp nhất hiện nay' , GETDATE() , N'cách chọn chim' , 
N'Khi việc chơi chào mào đã trở nên quá phổ biến thì người chơi lại muốn hướng đến một yêu cầu mới, khắt khe hơn. Do đó cách chọn chim chào mào đẹp nhất là một trong những tiêu chí hàng đầu mà những người yệu chim cảnh quan tâm nhất. Để giúp bạn có được một chú chim chào mào đẹp, thì hôm nay Chú Gióng xin chia sẻ với các bạn những cách lựa chọn chim chào mào đẹp nhất:

Cách lựa chọn chim chào mào đẹp nhất hiện nay
Để có thể lựa được một chú chim chào mào đẹp là điều mà bất cứ ai cũng có thể làm được. Tuy nhiên việc này lại đòi hỏi một sự tỉ mỉ và cẩn trọng một chú chào mào đẹp là phải kết hợp được tất cả các yếu tố khác nhau trên ngoại hình

1: Đầu và mào

 Tất nhiên rồi nhưng chú chim chào mào được lựa chọn thì phải theo tiêu đầu điên là chiếc mào. Về cách lựa chọn mào  thì không ai giống ai nhưng heo ý kiến đánh giá của một số người đã có kinh nghiệm chơi chim lâu nắm thì bạn nên lựa chon những chú chim có gốc mào dày. Những chú chim này thường tỏ ra rất bản lĩnh và bền bỉ. Đầu chào mào thì cũng nên lựa chọn những con có chiếc đầu to, như vậy thì chúng sẽ khỏe mạnh và dữ dằn 



2: Tách chim

Tách chim chào mào chính là những chấm đỏ mặc dù điều này không ảnh hưởng quá nhiều đến khả năng hót của chim tuy nhiên phải là một điểm nhấn để giúp những chú chim của bạn trong bắt mắt hơn về ngoại hình. Một chú chim hót hay mà lại sở hữu tách đỏ đẹp nữa thì lại là điều tuyệt vời

3: Mỏ chim
Về tiêu chí này thì cũng không có một quy chuẩn chung nào cả bởi vì có những người thích những chú chim sở hữu những chất giọng uy lực đanh thép thì thường lựa chọn chi có mỏ dày nhưng có nhưng người khác thì lại lựa chọn những chú chim có mỏ mỏng với mong muốn lựa chọn được một chú chào mào mau miệng hót suốt ngày. Tuy nhiên không phải là những chú chim nào có đặc điểm nêu trên thì cũng sở hữu chất giọng như thế. Nhưng đa phân những chú chim này 80% là như vậy nên những người chơi chim đến lấy những tiêu chuẩn đó để làm thước đo tương đối

4:  Cổ chim

Về cổ chim  thì cũng khó để xác định rằng như thế nào là một chiếc cổ đẹp có những người yêu thích những chú chim có chiếc cổ gọn gàng nhưng có những người lại yêu thích những chú chim có cổ phình to hót. Những lúc này nhìn chúng rất da dáng. Về cách chọn này là tùy thuộc ở mỗi người nhưng bạn cũng cần phải lựa chọn những chú chim có chiếc cổ của cân đối với người. Để  khi nhìn tổng thể thì trông chúng sẽ được thanh thoát nhất. Điều này cũng tương tự khi chọn cổ chim bạn có thể lựa chọn chú chimnào có chiếc cổ với màu sắc trang nhã liền mạch với đầu là đẹp.



6: Mình chim
Về mình chim thì bạn lựa chọn những chú chim nào không quá to cũng không quá bé, chỉ cần chúng trông thon gọn và thanh thoát thì sẽ giúp cho những chú chim có thể di chuyển thanh thoát nhất.

7: Cánh chim
Khi lựa chọn một chú chào mào đẹp theo cánh chim không được chồng chéo lên nhau phải ôm gọn vào cơ thể nhưng lại không được dài quá đuôi. Những chú chim nào có sải cánh rộng nữa thì lại đẹp hơn nữa

8: Đuôi chim

 Về tiêu chí này đã có rất nhiều tranh cãi có những người lại thích những chú chim có đuôi nhỏ nhưng có những người lại thích những chú chim có một chiếc đuôi to. Nhưng theo quan điểm của bản thân tôi rút ra từ những chú chim hay trong trường đấu thì nên lựa chọn những chú chim nào có đuôi ngắn thì càng tốt. Những chiếc lông đuôi phải xếp vào nhau đúng tuần tự chứ không phải là cái cụp cái xòe như vậy trông rất xấu

9: Chân chim

Cũng giống như bất kỳ loại động vật nào khác mà ngay cả con người chúng ta cũng vậy nếu như muốn di chuyển nhanh nhẹn thanh thoát được thì bắt buộc phải có một đôi chân khỏe. Còn về tiêu chí lựa chọn chào mào đẹp theo chân những chú chim chào mào nào sở hữu một đôi chân cao thì rất nhanh nhẹn và linh hoạt .Tuy nhiên những chú chim sở hữu được một đôi chân cao cao này thì không phải lúc nào chúng ta có thể tìm được. Chưa kể đến những chú chào mào bổi thì việc huấn luyện những chú chim này cũng rất khó khăn bởi như bạn biết để nuôi được một chú chim bổi cho đến khi chúng thuần và có thể đưa ra trường thi đấu được cũng phải mất 3 đến 4 năm

Vậy ở trong bài viết trên Chúng tôi đã mách cho bạn cách chọn chim chào mào đẹp theo đúng tiêu chí của những người am hiểu về chim cảnh. Với những cách lựa chọn trên, Chú Gióng hi vọng sẽ giúp bạn chọn được một chú chim chào mào thật đẹp, bên cạnh đó giúp các bạn có thêm kinh nghiệm chăm sóc chúng. Cảm ơn các bạn đã quam tâm theo dõi bài viết.'),
	( '0251849dac885e1123e573388a937b6d' , N'Cách chăm chào mào bổi tốt nhất' , GETDATE() , N'kinh nghiệm nuôi chim' , 
	N'Cách chăm chào mào bổi luôn được sự quan tâm rất lớn từ thế giới những người yêu chim. Bởi đơn giản đây là dòng chim khó nuôi, cần sự tinh tế và kinh nghiệm lâu năm của người chăm sóc. Chim chào mào bổi sau khi huấn luyện xong nếu thành công bạn sẽ có những chú chim tuyệt vời nhất, vời hình thế vóc dáng lực lượng, oai phong và giọng hót hàng ngày cực nịnh người.
	Nhưng ngược lại nếu bạn bỏ qua và không quan tâm đến khoảng thời gian này chúng sẽ nhanh chóng xuống dốc, thậm chí là chết dễ dàng. Hãy cùng chúng tôi tìm hiểu Cách chăm chào mào bổi tốt nhất dưới đây và rút ra bài học cho bản thân mình nhé!

Chào mào bổi là gì?
Những chú chim chào mào này đã khá già và đã sống ở ngoài thiên nhiên một khoảng thời gian dài, thậm chí là có con lớn rồi nhưng được con người bắt về thuần dưỡng, chăm sóc nó thành công được gọi là chim chào mào bổi. Các loại chim chào mào bổi này cần khá nhiều công sức của người nuôi vì cần thời gian chăm sóc,huấ luyện chúng hàng ngày mới cho kết quả cao. Loài này cực kì khó thuần dưỡng, nhưng khi đã thuần hóa được chúng để mang đi thi cực kì tuyệt vời vì chúng đã được thiên nhiên khắc nghiệt đào tạo để có được một tinh thần thép.

Cách chăm chào mào bổi 
Vì chim chào mào thường có cuộc sống khá thoải mái, chúng được sống trong môi trường cực phong phú với đủ cung bậc, có thể nhảy nhót, bay lượn hay làm bất gì mà chúng thích. Nhưng khi về với chủ nhân, phải sống trong lồng chật hẹp nên việc tinh tế trong cách nuôi chào mào bổi là rất cần thiết. Đầu tiên sau một khoảng thời gian tách lồng bạn nên treo lồng chim ở một nơi có nhiều người qua lại  để chim dạn dĩ hơn với con người nhưng không nên treo quá cao, hoặc khi trùm lồng bạn cũng đừng trùm kín quá phải để hé ra. 

Chim chào mào cần lượng thức ăn khôn nhiều nhưng liên tục. Bạn nên để sắn chút đồ ăn, hòa quả trong lồng chim để chúng tùy thích nạp năng lượng cho mình mỗi khi cần. Hãy để chút hoa quả như chuối, đu đủ, xoài… trong lồng hoặc chút cám chim. Đặc biệt là nước rất quan trọng, lúc nào trong lồng chim cũng nên chó chút nước sạch để sẵn.

Thời gian đầu chim chào mào bổi hơi nhát nên bạn đừng quá lo lắng nếu chúng khôn hót, hoặc không nhanh nhẹn như bình thường. Sau khoảng 1 tháng chim sẽ bắt đầu dạn dĩ dần.
Cách chăm chào mào bổi  cần người chủ rất khéo léo vì cần nâng niu, cất lồng chim khi nào. vì vậy bạn hãy nhớ một vài quy tắc đơn giản trên nhé. Ngoài ra, khi chim đã dạn hãy để chim nơi yên tĩnh, it người qua lại để chúng tự do hót. Chúc bạn có những phút giây thoải mái nhất.'),
	( 'b17fbe0d73b2ebacedfb6ac1b284767c' , N'Tổng hợp các loài chim cảnh đẹp mà dân chơi yêu thích' , GETDATE() , N'Top loài chim' , 
N'Trong giới chim cảnh người ta thường đồn đại và chia sẽ với nhau một số loại chim cảnh đẹp, hót hay và phổ biến tại Việt Nam. Nếu không sở hữu ngoại hình bắt mắt thì chắc hẵn loài chim này sẽ có giọng hót thanh thót, làm say đắm lòng người . Bạn đã biết những loài chim được yêu thích nhất là những loài nào chưa? nếu chưa thì hãy theo dõi cùng chúng tôi trong bài Viết dưới đây nhé.

Những loài chim cảnh quý mà dân chơi yêu thích
1. Chim Sơn Ca

Được giới sành chim ưu ái dành cho cái tên danh ca trong rừng thẳm  người ta yêu thích loài chim cảnh hót hay này bởi giọng ca cao vút và trong trẻo của chúng. Ngoài ra chúng cũng sở hữu một thân hình nhỏ nhắn đáng yêu với màu nâu đặc trưng. Nhưng nếu những chú chim này được nuôi dưỡng một cách cẩn thận và khoa học nhất chúng sẽ có được màu lông vàng óng rất bắt mắt. Chim sơn ca không đòi hỏi người nuôi có quá nhiều kinh nghiệm bởi chúng không kén ăn. Nếu có một khoảng không gian vừa đủ rộng bạn sẽ được chiêm ngưỡng màn vũ đạo vừa bay vừa nhào lộn và hót rất thú vị 
2. Chim chích chòe 

Sở hữu một giọng ca không thua kém bất kì một loài chim cảnh quý nào. Chúng chinh phục người nuôi bằng giọng hót mượt mà và trong trẻo. Tuy nhiên cũng chính bởi niềm đam mê ca hát của chúng nên thường luyện giọng vào buổi trưa và nửa đêm. Nên đôi khi sẽ gây ra phiền toái cho những người không thích bị phá giấc ngủ. Loài chim này cũng khá phổ biến và được nuôi rất nhiều tại Việt Nam

3. Chim Họa Mi

Mặc dù loài chim này sở hữu một ngoài hình không mấy ấn tượng bởi màu nâu cũ kĩ nhưng n gười ta biết đến giọng hát chim họa mi qua những câu truyện buồn mà người xưa để lại. Với tiếng ca sâu lắng nhưng chất chứa đầy tâm trạng của mình sẽ giúp cho người nghe có thể xua tan đi cảm giác mệt mỏi. Những chú họa mi có giọng hót đặc biệt hay luôn khiến những dân chơi thèm khát và muốn săn lùng

4. Chim yến phụng

Là một loài chim cảnh đẹp với hình dáng như những chú vẹ, đôi mắt tròn to sặc sỡ đầy màu sắc và bản tính hiền lành thân thiện đó là lý do mà những chú chim này đang rất được ưa chuộng và tìm mua. Loài chim này thường được nuôi theo từng cặp và rất thích bay nhảy nên trước khi nuôi bạn nên chuẩn bị một chiếc lộng có kích thước vừa đủ thể chúng có thể tự do bay lượn. 

5. Chim Vàng Anh

Với ngoại hình nhỏ nhắn dễ thương cùng với màu vàng tươi sáng của bộ lông và giọng họt thánh thót của mình, Chim Vàng anh được những người sành chim cảnh khá yêu thích. Chúng cũng rất dễ nuôi khi thức ăn của chúng là côn trùng và hoa quả rất dễ kiếm. 

6. Chim Khướu

Khướu cũng là một loài chim cảnh quý được nhiều người ưa chuộng. Chúng có thể bắt chước được tiếng của rất nhiều loài vật và bắt chước được cả tiếng con người nên những người sảnh chim luôn mong muốn có được một chú khướu thông mình. Chúng sỡ hữu một bộ lông xốp như bông rất đáng yêu

7. Chim Chào Mào

Nói đến những loài chim cảnh đẹp chắc chắn không thể nào không nhắc tới chào mào. Đây là loại chim được nuôi phổ biến nhất ở nước ta. Những chú chi chào mào đặc trưng thường có màu đen nhưng nếu may mắn bạn có thể sở hữu được một chú chim màu trắng hoặc nữ hoàng thì đó lại là cả 1 gia tài. Tiếng hót của chúng rất chắc và thánh thót chúng rất thích ăn hoa quả nên việc nuôi loài chim này cũng không tốn quá nhiều công sức. 

8. Chim Khuyên

Sở hữu ngoại hình không khác là mấy so với chú chi sâu thông thườn. Để nuôi được một chú chim khuyên đẹp không phải là điều dễ dàng gì. Nhưng chính sự khó khăn đòi hỏi đẳng cấp cao của những thợ chim cảnh nên chúng vấn được rất yêu thích và mong muốn chinh phục bằng được. Chim khuyên sở hữu một giọng hót vô cùn ấn tượng, tiếng hót trong trẻo của chúng có thể xua tan đi mệt mỏi mang đễn cho người nghe một khoảng không gian lắng đọng và sâu lắng trong tâm hồn. 

Đối với những loài chim đã nêu trên, mỗi loài đều có điểm riêng biệt của chúng khi có loài mang diện mạo hoàn hảo, thế nhưng lại có loài lại có được giọng hót say đắm. Và cũng chính bởi những đặc điểm này đã khiến cho những chú chim cảnh đẹp luôn được các dân chơi yêu mến và săn lùng. 
'),
	( 'adc8a1de829b5aca8cd6f8a94b4dbf0d' , N'Chia sẻ cách nuôi chim họa mi bổi' , GETDATE() , N'kinh nghiệm nuôi chim' , 
	N'Chim họa mi nổi tiếng là loài chim khó thuần, đặc biệt đối với họa mi bổi thì việc thuần hóa chúng là một việc khó khăn đòi hỏi tính kiên trì và thời gian. Nhưng nếu như bạn thành công thì chắc chắn rằng kết qua sẽ khiến bạn cảm thấy vô cùng hài lòng. Dưới đây xin chia sẻ với bạn cách nuôi chim họa mi bổi, đặc biệt lưu ý với loại chim này bạn cần nhiều thời gian và không thể đốt cháy giai đoạn được. 
	Chim họa mi bổi sống quen với môi trường hoang dã

Trước tiên, chim họa mi bổi là những chú chim mới được đưa từ rừng về, chúng đã có một thời gian dài sinh sống và trưởng thành với môi trường tự do của rừng núi. Chúng chưa bao giờ tiếp xúc với con người, vì vậy khi mới được đưa về, chim họa mi bổi rất hoảng sợ và nhút nhát. Bạn phải rất cẩn thận khi nuôi chim họa mi bổi.

Bước đầu sau khi đưa chim về bạn chuẩn bị chiếc lồng phù hợp để thuần hóa chim họa mi bổi. Chiếc lồng này chỉ nên nhỏ nhắn vừa để cho chim có thể xoay người, có thể sử dụng loại lồng thổ dân tộc hoặc mẫu lồng giả côn minh size 30 -32-34. Vì như đã nói ở trên, chim bổi rất hoảng loạn và sợ hãi, dùng lồng kích thước nhỏ để hạn chế chim nhảy loạn xạ, gây toác mỏ, gãy cánh hoặc có thể tử vong. Kinh nghiệm được chia sẻ là : ở giai đoạn đầu này, người nuôi nên phủ áo lồng và treo chim ở nơi yên tĩnh hạn chế tiếp xúc với con người. Tùy theo tính cách của từng con chim bạn có thể để hé lồng ít hay nhiều.

Thêm vào đó là thức ăn cho chim, với cách nuôi họa mi bổi, bạn nên cho chim ăn những thức ăn tự nhiên vốn quen thuộc mà chúng hay ăn khi sống trong tự nhiên hoang dã như côn trùng, dế, sâu, cào cào.. bởi vì họa mi là giống ương ngạnh, chúng thà chịu đói chịu khát rồi chết chứ không chịu tới cóng để ăn tấm rang trộn trứng. Dần dần sau một thời gian người nuôi nên tập cho chim họa mi ăn cám, gạo hay trứng gà; Chỉ nên hé lồng nhỏ xíu đủ cho chim ăn và tập cho chúng quen với chủ, và thói quen khi chủ tới là chúng có thức ăn. Kiên trì khoảng 6 tháng tới 1 năm thì chim họa mi bổi sẽ dạn hơn.
Tìm nơi vắng vẻ yên tĩnh để treo lồng chim

Ngoài ra, bạn cũng có thể dùng một con chim họa mi mái đã được thuần để “ấp” chim đực hoặc ngược lại, để cho chim bổi bớt hoảng sợ trong giai đoạn đầu. Cách “ốp đực” rất đơn giản, bạn chỉ cần treo chim mái đã được thuần cạnh chim đực hay ngược lại, mở hé lồng chim để chúng nhìn thấy nhau. Theo độ hấp dẫn và thu hút của loài giống, sẽ khiến cho chim họa mi bổi quên hoảng sợ, nhanh được thuần và nhanh quen với cuộc sống trong lồng hơn. Tuy nhiên, bạn tuyệt đối không nên dùng chim họa mi đực đã được thuần với chim họa mi đực bổi bởi vì chim họa mi là loài có tính hiếu thắng, ganh đua và cạnh tranh nhau, phân chia địa bàn trong tự nhiên, vì thế dùng chim họa mi đực thuần bởi đực bổi sẽ bị phản tác dụng.

Nếu như ở giai đoạn ban đầu, người chủ nuôi chỉ tiếp nước và thức ăn cho chim trong lồng nhỏ thì ở giai đoạn kế tiếp , khoảng từ 2 tới 3 tháng sau, bạn phải tập cho chim những thói quen và phản xạ khi chúng sống ở trong lồng lớn hơn. Chăm sóc chim họa mi bổi nên có lịch trình đều dặn hàng ngày, từ việc thay nước, cho ăn, mở áo lồng… sau một thời gian được chăm sóc như vậy sẽ tạo cho chim họa mi bổi những phản xạ có điều kiện phù hợp với môi trường sống mới trong lồng.
Chuẩn bị một chiếc lồng nhỏ xinh khi thuần chim họa mi

Ngoài việc cung cấp thức ăn đủ chất dinh dưỡng và tạo không gian yên tĩnh, người nuôi cũng nên chú ý cho chim tắm nắng và tắm nước.  Tắm nắng để cung cấp vitamin D và tạo bộ lông mượt mà ấp áp. Tắm nước là thói quen của chim họa mi trong tự nhiên, chúng rất cẩn thận và thử nước trước khi tắm, tuy nhiên chim họa mi tắm rất nhanh, chỉ với vài phút. Càng được tắm nhiều, bộ lông chim càng được mướt mát, tươi tắn, và sức khỏe của chim cũng khá hơn.

Trong quá trình chăm sóc chim họa mi bổi, bạn nên hành động nhẹ nhàng, tỉ mỉ và kiên nhẫn. Có thể bạn sẽ thất bại trong những lần đầu thuần chim họa mi bổi nhưng qua một quá trình tự bản thân người nuôi sẽ rút ra được những kinh nghiệm về cách nuôi họa mi bổi.

Trong thời gian sau khi chim đã dạn, người nuôi vẫn nên trùm lồng kín cho chim vào ban đêm. Dù chim họa mi là loại có sức khỏe và đề kháng tốt nhưng chúng vẫn dễ trúng gió lạnh dẫn tới tử vong.

Tóm lại, việc chăm sóc và thuần một chú chim họa mi bổi rất vất vả và người nuôi mất rất nhiều thời gian theo đó là sự tỉ mỉ và kiên trì. Nếu bạn là một người thật tâm huyết với chú chim của mình, nhất định khi trải qua một thời gian chăn sóc thì chú họa mi sẽ cất cao tiếng hót mỗi ngày. Tuy sẽ mất thời gian dài từ 6 – 8 tháng, cũng có thể là một năm tùy từng con chim, nhưng cuối cùng bạn sẽ thực sự cảm nhận được sự thú vị trong quá trình thuần hóa chim họa mi và hạnh phúc khi được thưởng thức tiếng chim hót mỗi ngày.
'),
	( '48981d702b321f55a52652da71155e67' , N'Tuân thủ những cách chăm sóc họa mi căng lửa' , GETDATE() , N'kinh nghiệm nuôi chim' , 
	N'Việc nuôi dưỡng và chăm sóc chim họa mi luôn giữ được phong độ là một điều tuy đơn giản nhưng không phải ai cũng có thể làm được vì đây là công việc nhẹ nhàng nhưng cần sự tỉ mỉ và kiên trì cao. Bài viết này xin bổ xung những cách chăm sóc chim họa mi căng lửa để bạn đọc tham khảo và áp dụng.

	Với những người nuôi chim họa mi, gặp phải trường hợp chim lên lửa, xuống lửa thất thường, ngày thì nghe hót rất nhiều, ngày thì không nghe thấy chim hót lần nào… đó là việc hết sức bình thường khi người nuôi chim họa mi không có các kĩ năng và chưa đủ kinh nghiệm giữ lửa cho họa mi. Những điều ảnh hưởng lớn nhất tới tạo lửa và giữ lửa cho chim mà bạn cần lưu ý như : môi trường sống, chế độ dinh dưỡng, cách chăm sóc..

	Đầu tiên khi mới mang chim họa mi về, nó thường lạ người, lạ môi trường sống, thức ăn và thói quen được chăm sóc nên bao giờ cũng sợ hãi và xuống lửa; dù cho là chim mộc hay chim đã thuần hóa, chúng sẽ thường bỏ hót sau một vài ngày được nuôi dưỡng. Vì thế, bạn cũng không nên sớm bỏ cuộc mà hãy áp dụng những cách nuôi chim họa mi căng lửa sau :

Duy trì chế độ ăn đầy đủ dinh dưỡng và ổn định cho chim : nên tập cho chim họa mi những chế độ ăn dinh dưỡng theo những công thức nhất định và tránh thay đổi thức ăn cho chim quá đột ngột. Công thức thường được áp dụng cho chim họa mi là  : gạo và trứng gà ngon. Nhất thiết phải làm khoáng hoặc mua khoáng chất cho chim ăn để chim có đủ nguyên tố vi lượng trong quá trình sống và hoạt động, chống bênh tật.. Tất nhiên, tùy từng giai đoạn phát triển của chim họa mi mà người nuôi cho ăn những thức ăn phù hợp. Thêm nữa, trong từng giai đoạn và thời điểm, bạn phải biết chim thiếu chất gì (vitamin và khoáng chất) và thừa gì để điều chỉnh và bổ sung cho kịp thời, hợp lý. Điều đặc biệt để nuôi chim họa mi căng lửa là bạn nên bổ sung hàng ngày thức ăn như : cào cào, sâu tươi cho chim, có thể là trứng kiến, cá con, tôm tép, thịt bò vụn...
Chú ý vệ sinh lồng chim thường xuyên : dọn rửa lồng chuồng thật sạch, tuyệt đối không để phân chim, giấy lót lưu cữu trong lồng ngày nọ qua ngày kia rất mất vệ sinh cho cả chim và người. Tuyệt đối không làm cách gọi là “ủ chim” vì động tác này rất mất vệ sinh và phản lại tập tính sinh hoạt của loài chim, về mùa nắng nóng có thể làm chết chim vì ngột ngạt.
Thường xuyên tắm nước và tắm nắng cho chim theo lịch trình đều đặn để loại bỏ kí sinh trùng và làm ấm bộ lông chim : người nuôi có thể áp dụng chế độ tắm nước cho chim họa mi mỗi ngày một lần và vào lúc nhiệt độ môi trường cao nhất trong ngày, thường thì là từ 13h tới 15h hàng ngày. Vào những ngày trời lạnh với nhiệt độ từ 10 độ C bạn vẫn có thể cho chim tắm bình thường, tuy nhiên việc tắm chim phải được tiến hành ở nơi khuất gió pha nước hơi âm ấm cho chim tắm. Những lúc có nắng phải tranh thủ cho chim tắm nắng 30 đến 45 phút trong mùa đông là vừa. Sáng mùa hè tắm nắng cho chim khoảng 20 phút vào lúc 8h00 hoặc 8h30 là tốt nhất.
Bạn nên chọn nơi treo lồng chim là những nơi khuất, yên tĩnh và vắng bóng người qua lại, tuyệt đối không nên để những nơi mèo, chó có thể để ý tới hay tránh những người lớn cầm que gậy, chổi lau nhà, trẻ em.. để gây ồn ào và làm cho chim họa mi sợ hãi, hoảng loạn và xuống lửa. Sau một thời gian khi chim họa mi đã quen dần với môi trường , bạn có thể áp dụng cách thay đổi nơi treo lồng chim, để tập cho chim dạn hơn.
Ngoài ra, khi di chuyển lồng chim, bạn nhất thiết phải có áo trùm lồng, khăn vải trùm lồng.
Thêm vào đó, để chăm sóc cho họa mi căng lửa, người nuôi nên nuôi kèm với chim mái, đặc biệt với chim họa mi, điều này có tác dụng rất lớn. Những chuyên gia nuôi chim họa mi thường dùng chim mái để thúc chim trống căng lửa theo từng thời điểm thích hợp.
Khi chim họa mi giã lồng, bạn có thể mồi cho chim hót bằng các CD thu âm chim trống hoặc chim mái đầu đàn, cách chăm sóc họa mi căng lửa này thường xuyên được sử dụng và mang lại hiệu quả cao.

Một vài điều về những thay đổi theo mùa của chim họa mi bạn nên chú ý như : vào đầu mùa thu chim họa mi thường thay lông nên chúng bị xuống lửa và giảm sút thể lực . Người nuôi thấy họa mi của mình có những dấu hiệu trên khi vào mùa : rụng lông, ít hót .. thì nên bổ xung khoáng chất và dinh dưỡng trong thức ăn của chim. Quá trình thay lông của chim thường kéo dài từ 50 tới 60 ngày vào mùa thu và thêm khoảng 30 ngày vào mùa hè.

Đây là quá trình rất bình thường nên bạn cũng không cần quá bận tâm mà chỉ cần chú ý bổ sung dinh dưỡng đầy đủ cho chúng. Sau khi trải qua quá trình thay lông và chăm sóc kỹ lưỡng, chim họa mi sẽ lên lửa và hót nhiều hơn.

Chúc bạn sẽ đúc rút được nhiều cách chăm sóc họa mi căng lửa trong quá trình nuôi chim đầy thú vị của mình!
'),
	( '309d3c8fc90b2cf25bf851f62e428ec7' , N'Kĩ thuật và những cách nuôi chim họa mi hót nhiều' , GETDATE() , N'kinh nghiệm nuôi chim' , N'
	Hiện nay trào lưu nuôi chim được lan rộng mạnh mẻ, hiển nhiên những kinh nghiệm mà các tay chơi lão luyện làm như thế nào để chim hót nhiều cũng đã được truyền lại. 
	Tuy nhiên, hôm nay hãy để chúng tôi bật mí những “bí kíp” dưới đây để thuần hóa chim họa mi được thành công hơn nhé!
	
	Tiếng hát của chim họa mi được công nhận như những tiếng vang vọng của thiên nhiên. Những danh ca nổi tiếng thường được ví như “họa mi”. Loài họa mi là chim rừng, sống chủ yếu ở các nước khu vực Đông Nam Á, đặc biệt là tại các vùng núi cao của Trung Quốc và Việt Nam như Lạng Sơn, Sơn La, Lai Châu.

Chọn mua chim họa mi
Điều kiện đầu tiên của việc nuôi được một chú chim họa mi hót nhiều là bạn phải chọn được chim họa mi giống tốt , thứ hai là tới cách chăm họa mi hót. Người nuôi có thể đăng kí các đặc điểm sau của chim họa mi :

Mắt :  bạn chọn những chú chim họa mi có đôi mắt long lanh, mắt to nhưng con ngươi nhỏ và có phản ứng nhạy bén với những tác nhân chung quanh, da quanh mắt mỏng, màu sắc của mắt tươi, đuôi mắt có vệt lông nhỏ màu trắng kéo dài ra sau ót. Nên chọn con có chấm đen ở đồng tử nhỏ hơn những con khác. Từ đồng tử lóe ra 4 tia mắt, nên chọn tia càng to, càng rõ, càng dày càng tốt. Nếu có kinh nghiệm, những người chơi chim thường quan sát kĩ xa nhãn (nhãn cầu) của chim họa mi thuộc loại nào : kim xa nhãn, thiết xa nhãn, ngân xa nhãn, huy xa nhãn.
Thử phản ứng của chim : bạn thử bằng cách dùng ngón trỏ nhẹ nhàng vẽ hình tròn hoặc hình chữ thập để đánh giá phản ứng của chim. Có hai trường hợp sau : nếu đó là chim nuôi chưa thuộc thì phản ứng của nó là nhảy loạn xạ trong lồng tìm lối thoát thân. Còn chim thuần thuộc thì nó cứ đứng yên trên cần đậu, đôi mắt và chiếc đầu của nó di chuyễn theo hướng ngón tay vẽ hình của bạn, chứng tỏ chim có cá tính mạnh, bạo dạn, tự tin và phản xạ nhạy bén.
Ngoài ra, bạn cũng phải chọn lồng phù hợp với chim họa mi. Kích cỡ lồng phù hợp  : đường kính đáy lồng khoảng 50 phân và khoảng 70 nan hoa. Lồng tre hay lồng mây đều có thể dùng được. Tạo không gian trong lồng để chim có một môi trường sống lý tưởng giúp phát huy tiếng hát của chúng

2. Cách nuôi chim họa mi hót nhiều
Họa mi là loài chim rất nhát, bởi vậy cách chăm sóc chim họa mi hót hay cũng phải tỉ mỉ và kì công hơn nhiều loài chim cảnh khác. Bước đầu, người nuôi nên để chim tránh tiếp xúc với người lạ trong khoảng một tới hai tuần, trừ lúc cho chúng ăn; cách làm như sau : trùm áo hay vải vào lồng và để nơi ít tiếng ồn, người nuôi cho chim họa mi làm quen và tiếp xúc dần với môi trường xung quanh, nên làm từ từ và kiên trì. Thường thì trong khoảng nửa năm chim sẽ dạn với người.
Dinh dưỡng cho chim họa mi là một trong những yếu tố quan trọng để tạo nên giọng hót của chim. Thức ăn của chúng rất đơn giản : chỉ cần gạo, trứng và cào cào ; chim họa mi ăn rất ít, một  ngày chúng ăn chỉ khoảng một thìa thức ăn. Muốn cho chim hót sung thì bạn nên cho chúng ăn cào cào, vài ba chục con mỗi ngày. Một điều lưu ý là chế độ thức ăn của chim họa mi phải ổn định, bạn không nên thay đổi thức ăn của chúng đột ngột . Khi nuôi nhốt trong lồng ta tập cho chung ăn thức ăn riêng. Và chim đã quen với một loại thức ăn nào đó thì ta nên cho chim ăn mãi thức ăn đó. Tất nhiên tùy vào từng giai đoạn sinh trưởng của chim mà có sự thay đổi thành phần thức ăn. Nhưng nhất thiết không nên thay đổi thức ăn đột ngột, vì họa mi rất dễ “dị ứng” trước mùi vị thức ăn lạ nên dễ bị suy và thường dẫn đến việc thay lông.

Kĩ năng để có một con chim họa mi hót giọng thánh thót và nhiều giọng, bạn nên cho chim họa mi của mình đi dượt, một chú chim già rừng thường có giọng hót rất cao và trong, mang cái hồn của thiên nhiên núi rừng. Dù cho chim họa mi bạn nuôi là chim mộc mới mang từ rừng về, bạn cũng nên mang đi dượt chim, bằng cách trùm áo lồng thật kín để chúng nghe ngóng những con chim khác để bắt giọng. Nếu không đi dượt chim, bạn nên mua các băng đĩa thu âm tiếng hót của họa mi trống hót hay, hót nhiều về để chim bạn nuôi tập giọng. Trong trường hợp muốn tập cho chim hót khỏe và hay cần bỏ hết áo lồng, treo chim lên cao, yên tĩnh chim hót rất hay và nhiều giọng. 
Ngoài ra việc tắm nắng, tắm nước cho chim cũng là một việc quan trọng và không được quên vệ sinh lồng chim sạch sẽ.
Trên đây là những chia sẻ về kinh nghiệm cách chăm sóc chim họa mi hót , bạn tham khảo và làm theo để nuôi chim thành công, lúc nào cũng được thưởng thức tiếng chim họa mi quanh nhà bạn.
	'),
	( 'e9dd9c14ec255e2700d76c05c70d0236' , N'Kỹ thuật thuần hóa chim họa mi mộc' , GETDATE() , N'kinh nghiệm nuôi chim' , N'
	Loài chim họa mi không những hót hay mà nhờ bản tính dữ tợn, hung hăng mà chim họa mi còn dùng để chiến đấu. Vậy việc thuần hóa một con chim họa mi "mộc" mới bắt về từ rừng thật sự không hề dơn giản. 

Sau khi đem chim mộc về phủ kín áo lồng để mở chữ A hoặc rộng hơn cũng không sau, để chỗ tối quay ra chỗ có ánh sáng và có người đi lại, việc này sẽ giúp  cho chú chim nhát thấy tự tin hơn ai khi nhìn không thấy ai. Sau 2,3 ngày cho chim ra chỗ sáng hơn, nếu thấy chim đứng không nhảy lung tung thì bạn đã thành công.

Thức ăn đổi đầy cóng, cho chim ăn cám đừng cho ăn nhiều mồi tươi vì khi cho ăn mồi tươi chim họa mi mộc sẽ không ăn cám, ăn thức ăn tươi sẽ dễ gây bệnh đường ruột. Chú họa mi nào càng dạn bao nhiêu thì dễ dàng thuần bấy nhiêu. Ngoài sự chăm sóc cẩn thận về thức ăn cần phải thay nước và vệ sinh lồng thường xuyên. Muốn tắm cho chim thì phải cẩn thận vì có thể sẽ làm chim bị hoảng nên tốt nhất nếu không chắc rằng chim có hoảng hay không thì không tắm, nó sẽ tự vẫy nước trong cóng để tắm.

Chim mộc thường rất nhút nhát chúng quen với không gian rộng rãi nên khi cho vào lồng chúng sẽ bị tù túng, nhảy loạn xạ chưa quen. Mỗi lần thấy bóng người là chúng nhảy nhót điên loạn, đâm đầu vào nan lồng chảy cả máu đầu, gãy duôi, xã cánh,…Nhiều khi chăm sóc chim là vậy nhưng chúng chẳng chịu ăn thế là chết, thật tội nghiệp và cũng tiếc cho công sức chăm chim. Giai đọan này là một giai đoạn khó khăn, nếu bạn vẫn không thể thuần hóa được họa mi mộc tốt nhất nên chọn chim đã được thuần hóa tương đối, biết ăn cám và cất tiếng hót rồi.

“ chọn mặt gửi vàng” một con chim đá đủ chuẩn
Phần đầu: phải to nhưng to chưa chắc đã tốt nhé , nên chọn đầu hơi bằng, gần ngang với mỏ chim vì chin có cái đầu này thường lanh lẹ, vừa lì lơn là một tuyển thủ né đòn mau lẹ.
Phần mỏ: mỏi dài vừa phải, chót mỏ hơi khum như mỏ sẻ, chiếc mỏ này sẽ mổ đau và cắn mạnh đối thủ.
Phần chân: phải to khỏe, không bị thương tật, bàn chân to
Phần thân: lớn con, dài đòn, vóc dáng oai phong
Đuôi dài và dày, để duy trì cân bằng và khi bay lên đáp xuống lách lái được dễ hơn.

Sau khi chọn ngoại hình xong phải chọn tới tài năng và kỹ thuật thiên bẩm. Mỗi con chim họa mi thường có thế đá khác nhau:

Có con thì đá độc hiểm
Con thì to lớn mà đá địch thủ ko đau
Có con ra đòn nhanh, dứt khoát, có con lại rề rà chậm chạp
Có con lì đòn, đá đến sướt đầu mẻ trán vẫn hung hăng đá tiếp
Có con nhát chưa đá mà đã muốn thua….
Bằng những kỹ năng chuyên môn, kinh nghiệm nuôi và chăm sóc chim  họa mi mộc mà họ biết chim hay hay chim dở. Đôi khi người mua chim tính toán rất kỹ lưỡng mới quyết định mua vì một con chim ngoài vóc dáng theo chuẩn còn phải sử dụng toàn bộ cơ thể kết hợp nhuần nhuyễn đá mới hữu hiệu.

Theo kinh nghiệm của giới chơi chim nên chọn chim ở vùng Lạng Sơn, Móng Cái mới có chim dữ sau khi mua về thì người ta sẽ chăm sóc, huấn luyện chúng. Đối với chim đá cần hạn chế cho chúng hót, chúng không hót mới đá sung.

2.Cách thuần chim  họa mi

Chim mua mang về không bao giờ có được một chú chim ưng ý cả: hoặc chúng không hót, hoặc thân hình tả tơi, hoặc nhảy loạn xạ,… Nếu như kiên nhẫn chăm sóc thì không sớm thì muộn bạn sẽ sở hữu chú chim hót hay đá giỏi và công sức chăm sóc bỏ ra không bị phí hoài. Trong quá trình chăm sóc sự  ân cần, chu đáo, nhẹ nhàng sẽ giúp thuần hóa chim dễ dàng hơn. Nếu bạn thật sự thích loài chim này, vô cùng ngưỡng mộ chúng vậy thì công sức chăm sóc bỏ ra không hề phí hoài bạn sẽ nhận được kết quả tuyệt vời khi chú chim cất cao giọng hót, trổ tài, khoe sắc sẽ khiến bạn hạnh phúc hơn.

3. Huấn luyện chim họa mi chiến đấu
Thông thường áp dụng phương pháp thuần hóa chim họa mi mộc thường mất khoảng từ 4 đến 6 tháng trường hợp chim khó thuần chắc phải tới một năm hoặc hơn. Trong quá trình chăm chim người ta thường đưa chim đi dượt. Người chơi chim cảnh sẽ đem chim họa mi đến để họa mi quen với chim lạ, điều này sẽ rất hay vì chim có thể tập dượt để hót hay hơn, hăng hái hơn, sung độ hơn.

Tại thời điểm thích hợp đem chim đi sổ, chính thức cho chim đá với chim lạ để quen với trận chiến, cho chim học hỏi và có kinh nghiệm đấu đá. Tuần này cho đá với chim này tuần sau lại với chim khác, thời gian sổ chim  nên ngắn lại để dưỡng sức cho thi đấu thực sự, tránh được thương tích không đáng có. Trước khi đưa chim đi đá 1 tuần không tắm cho chim và cũng không nên đưa đi sổ. Chim họa mi đã đá xong dù thắng hay bại đều xơ xơ xác xác thảm hại vô cùng và thời gian phục hồi là rất lâu.

Chim họa mi thay lông xong thường hót suốt ngày, nếu để 2 chú chim gần nhau bạn sẽ có một dàn đồng ca rất hay.

Cách chăm sóc chinh họa mi và thuần hóa chúng cần phải kiên nhẫn , một người nuôi chim có kinh nghiệm sẽ huấn luyện được những chú chim đá hay.

Hy vọng qua bài viết này bạn có thể có thêm kinh nghiệm để chăm sóc chim họa mi và thuần hóa chúng. 

	'),
	( '553acd22fd496a02446c6258b3ba027e' , N'Cách chăm sóc chim chào mào thay lông chuẩn kỹ thuật nhất' , GETDATE() , N'kinh nghiệm nuôi chim' , N'
	Khi những chiếc lông đầu tiên rớt xuống báo hiệu những chú chào mào đáng yêu của bạn sắp trút bỏ một bộ lông cũ kĩ trên người để khoác một bộ lông hoàn hảo hơn trước. Lúc này cách chăm sóc chim chào mào thay lông đòi hỏi phải cầu kì và chính xác hơn rất nhiều. Để giúp các bạn có được những cách chăm sóc chim khoa học nhất mời các bạn theo dõi bài viết dưới đây của chúng tôi

Cách chăm sóc chim chào mào thay lông

1. Chế độ dinh dưỡng

Nhưng chú chim chào mào thay lông có những biểu hiện rất rõ ràng và chắc chắn rằng bất kì một người yêu chim nào cũng có thể nắm được trong lúc này chúng rất cần được bổ xung thêm các loại thức ăn tươi như cào cào, ở giai đoạn này không nên chó chúng ăn sâu khô nhé vì sâu khô sẽ khiến cho bộ lông của chúng quăn và rất xấu. 

Bạn có thể cho chúng ăn thêm lạc rang xay nhỏ ra rồi trộn vào cám để những chất béo này sẽ kích thích lông cho chúng mọc nhanh và mượt. Về trái cây thì lựa chọn những loại có tính mát và có sắc tố màu tự nhiên như cam, dưa hấu hay đủ đủ và thay đổi loại hàng ngày để chim có thể hấp thu được các sắc tố màu này tự nhiên nhất. Đây là cách mà các nghệ nhân thường áp dụng và cho một kết quả khá tốt

2. Cách tắm

Cho những chú chim chào mào tắm nắng hoặc tắm nước là một trong những bước không thể thiếu được trong cách chăm sóc chi chào mào thay lông. Mỗi 1 ngày bạn cho chúng tắm nắng nhẹ để kích thích cho những chiếc lông mới mọc nhanh và tắm nước để những chiếc lông cũ nhanh rụng. 

3. Môi trướng sống

Thông thường 1 chú chim chào mào thay lông hoàn chỉn trong khoảng tối đa 3 tháng thậm chí làcó thể sớm hơn tuy vào đặc điểm từng chú chim. Môi trường sống cũng khá quan trọng đối với chúng. Nếu như bạn không giữ được sự ổn định đôi khi chúng còn đột ngột ngừng việc thay lông. Điều này khiến chúng phải mất thêm 1 khoảng thời gian dài nữa rất bất tiện.

Những chú chim bổi được nuôi dưỡng trong tự nhiên sau khi thuần thì đa phần thay lông rất đúng mùa nhưng đối với những chú chim được nuôi dưỡng trong lồng lâu năm thì việc thay lông phụ thuộc khá nhiều vào chế dinh dưỡng cũng như môi trường sống của chúng. Nên khi chăm sóc loài chim này bạn tuyệt đối hạn chế thay đổi môi trường hoặc hạn chế thay đổi thức ăn đột ngột của chúng. Những chú chim thay lông không đúng mùa thường luôn ở trong thể trạng mệt mỏi, lông mới mọc lên cũng không được đep và chim cũng bớt sung.

Hi vọng rằng với những cách chăm sóc chim chào mào thay lông trong bài viết trên sẽ giúp cho anh em có thể giúp cho những chú chim quý của mình có được một bộ lông tốt nhất. Chúc anh em nghệ nhân thành công và sở hữu được chú chim đẹp nhất
'),
	( 'd6d001e31f4065bbe402bc2eac44ca22' , N'Những kinh nghiệm vàng trong cách nuôi chào mào bổi thành mồi' , GETDATE() , N'kinh nghiệm nuôi chim' , N'
	Một khi chú chào mào bổi chất lượng được huấn luyện thành công thì chắn chắc rằng sẽ là một đối thú đáng gờm và bản lĩnh trong các trường, hội thi chim. Chính vì vậy nhưng chú chim này nhận được rất nhiều sự quan tâm của các cao thủ lão làng cũng như những người chơi mới muốn thử sức. Cách nuôi chào mào bổi thành mồi không khó đòi hỏi chủ nhân của chúng phải thành thục những bước dưới đây

Cách nuôi chào mào bổi thành mồi
Chào mào bổi cũng có con này con nọ không phải con nào cũng có thể sở hữu được một chất giọng hoàn hảo. Nếu bạn may mắn sở hữu được một chú bổi ngon lành chắc chắn rằng khi vào đấu trường chúng sẽ thể hiện được bản lĩnh thực sự của mình. 

1. Cách tập cho chào mào bổi dạn.

Khi bạn đã sở hữu được một chú chào mào bổi chất lượng thì đầu tiên bạn phải huấn luyện chúng để chúng có thể quên đi cuộc sống ngoài thiên nhiên rộng lớn. Để chúng dạn người hơn và làm quen với cuộc sống ở trong lồng. Muốn chào mào dạn nên treo chim ở những nơi có nhiều người qua lại nhưng áo lồng phải được mở từ từ. Không nên vội vàng nếu không những chú chim này sẽ sợ hài.

2. Tập cho chào mào bổi ăn 

Khi mới được bắt những chú chim chào mào bổi sẽ khó làm quen với các loại thức ăn như cám nên giai đoạn đầu bạn nên cho chúng ăn hoa quả + với những chú chào cào. Bạn có thể nhốt chung những chú chào mào bổi cũng với những chú chim mái để chúng được dạn dĩ hơn và cũng học được cách ăn cám tắm rửa của những chú chim này. Khi chim đã dạn hơn thì bạn chuyển chúng đến các vị trí khác nhau để chúng có thể thích nghi với nhiều môi trường. Sau đó khoảng 1 thời gian sau bạn đã có thể cho chim đi dợt rồi.



Bạn cứ tiếp tục cho đến khi chim bổi đã được thuần, thuần đễn mức có người đến chún cũng không sở hãi trổ lồng nữa thì bạn mang chúng đi cùng những chú chim mồi khác để chúng có thể làm quen dần với tiếng hót của những chú chim mồi thành thục.

Ở quá trình luyện tập bạn cần đặt lồng chim gần với chim mồi khác nhưng tuyết đối phủ kín chỉ để chúng và chim mồi thấy nhau, cứ lặp đi lặp lại công việc này rồi sẽ có một ngày chú chim bổi của bạn sẽ dạn dỉ hơn và trở thành chim mồi. Nhưng những lần dầu bạn không nên cho chúng gặp những đối thủ chào mào già đời quá nếu không chúng sẽ sợ vì chưa quen. Cứ lặp đi lặp lại một khoảng thời gian những chú chim bổi này sẽ trở thành những chú chim mồi thuần thục.

Với cách nuôi chào mào bổi thành mồi mà chúng tôi đề cập đến trong bài viết trên hi vọng sẽ giúp ích được cho anh chị em có thể thuần hóa được một chú bổi với tỷ lệ thành công cao nhất.

');





