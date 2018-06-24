﻿GO
CREATE DATABASE QLBD

GO
USE QLBD

GO
CREATE TABLE ACCOUNT
(
	USERNAME VARCHAR(100) primary key,
	DISPLAYNAME NVARCHAR(100) NOT NULL,
	PASSWORD VARCHAR(1000) NOT NULL,
	ACCOUNTTYPE INT NOT NULL
)

GO
CREATE TABLE CLUB
(
	CLUBID INT PRIMARY KEY,
	CLUBNAME NVARCHAR(100) NOT NULL,
	CLUBSHORTNAME VARCHAR(6) UNIQUE NOT NULL,
	ESTABLISHEDYEAR INT NOT NULL,
	HOMEFIELD NVARCHAR(100) NOT NULL
)
GO
CREATE TABLE PLAYERTYPE
(
	PLAYERTYPEID INT PRIMARY KEY,
	PLAYERTYPENAME NVARCHAR(100)
)
GO
CREATE TABLE PLAYER
(
	PLAYERID INT PRIMARY KEY,
	CLUBID INT REFERENCES CLUB(CLUBID) ON DELETE CASCADE ON UPDATE CASCADE,
	PLAYERTYPEID INT REFERENCES PLAYERTYPE(PLAYERTYPEID), 
	NAME NVARCHAR(100) NOT NULL,
	POSITION NVARCHAR(100) NOT NULL,
	NATIONALITY NVARCHAR(100) NOT NULL,
	BIRTHDAY DATE NOT NULL,
	AGE INT NOT NULL,
	HEIGHT INT NOT NULL,
	WEIGHT INT NOT NULL
)

GO
CREATE TABLE ROUND
(
	ROUNDID INT PRIMARY KEY,
	ROUNDNAME VARCHAR(100)
)
GO
CREATE TABLE MATCH
(
	MATCHID INT PRIMARY KEY,
	HOMECLUB INT REFERENCES CLUB(CLUBID) NOT NULL,
	AWAYCLUB INT REFERENCES CLUB(CLUBID) NOT NULL,
	HOMESCORE INT DEFAULT NULL,
	AWAYSCORE INT DEFAULT NULL,
	ROUNDID INT REFERENCES ROUND(ROUNDID) NOT NULL,
	MATCHDAY DATE NOT NULL,
	MATCHTIME TIME NOT NULL,
	STADIUM NVARCHAR(100) NOT NULL,
	ISPLAYED BIT DEFAULT 0
)
GO
CREATE TABLE GOALTYPE
(
	GOALTYPEID INT PRIMARY KEY,
	GOALTYPENAME NVARCHAR(100) NOT NULL
)

GO
CREATE TABLE GOAL
(
	GOALID INT PRIMARY KEY,
	MATCHID INT REFERENCES MATCH(MATCHID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	CLUBID INT REFERENCES CLUB(CLUBID) NOT NULL,
	PLAYERID INT REFERENCES PLAYER(PLAYERID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	GOALTYPEID INT REFERENCES GOALTYPE(GOALTYPEID) NOT NULL,
	GOALTIME INT NOT NULL,
	ISOWNGOAL BIT DEFAULT 0
)

GO
CREATE TABLE CHARTS
(
	CHARTID INT PRIMARY KEY,
	CLUBID INT REFERENCES CLUB(CLUBID) NOT NULL,
	MATCHPLAY INT DEFAULT 0,
	WIN INT DEFAULT 0,
	LOSE INT DEFAULT 0,
	DRAW INT DEFAULT 0,
	GOALDIFFERENCE INT DEFAULT 0,
	POINT INT DEFAULT 0,
	GOALTOTAL INT DEFAULT 0
)

GO
CREATE TABLE PARAMETER
(
	PARAID NVARCHAR(100) PRIMARY KEY,
	MINAGE INT, --Tuổi tối đa của cầu thủ
	MAXAGE INT, --Tuổi tối thiểu của cầu thủ
	MINPLAYER INT, --Số lượng cầu thủ tối đa trong 1 đội
	MAXPLAYER INT, --Số lượng cầu thủ tối thiểu trong 1 đội
	MAXFOREIGNPLAYER INT, --Số lượng cầu thủ nước ngoài tối đa
	GOALTYPEKIND INT,  --Số loại bàn thắng
	MAXGOALTIME INT,  --Thời gian ghi bàn tối đa
	WINSCORE INT,  --Điểm thắng
	LOSESCORE INT, --Điểm thua
	DRAWSCORE INT, --Điểm hòa
	PRIORITYCHARTS INT, --Thứ tự ưu tiên xếp hạng
)

GO
CREATE PROC USP_Login
@userName NVARCHAR(1000), @pass VARCHAR(1000)
AS
BEGIN
	SELECT * FROM dbo.ACCOUNT WHERE USERNAME = @userName AND PASSWORD = @pass
END



GO
INSERT [dbo].[ACCOUNT] ([USERNAME], [DISPLAYNAME], [PASSWORD], [ACCOUNTTYPE]) VALUES (N'admin', N'admin', N'59113821474147731767615617822114745333', 1)

--Thêm CLB
GO
CREATE PROC ADD_CLUB
@clubid int, @clubname nvarchar(100), @clubshortname varchar(6), @establishedyear int, @homefield nvarchar(100)
AS
BEGIN
	INSERT dbo.CLUB (CLUBID, CLUBSHORTNAME, CLUBNAME, ESTABLISHEDYEAR, HOMEFIELD) VALUES (@clubid, @clubshortname, @clubname, @establishedyear, @homefield)
END

--Sửa CLB
GO
CREATE PROC UPDATE_CLUB
@clubid int, @clubname nvarchar(100), @clubshortname varchar(6), @establishedyear int, @homefield nvarchar(100)
AS
BEGIN
	UPDATE dbo.CLUB SET CLUBSHORTNAME= @clubshortname, CLUBNAME = @clubname, ESTABLISHEDYEAR = @establishedyear, HOMEFIELD = @homefield
	WHERE CLUBID=@clubid
END

--Thêm cầu thủ
GO
CREATE PROC ADD_PLAYER
@PLAYERID int, @CLUBID INT, @NAME nvarchar(100), @POSITION nvarchar(100), @NATIONALITY NVARCHAR(100), @BIRTHDAY DATETIME, @AGE INT, @HEIGHT INT, @WEIGHT INT
AS
BEGIN
	INSERT dbo.PLAYER(PLAYERID, CLUBID, NAME, POSITION, NATIONALITY, BIRTHDAY, AGE, HEIGHT, WEIGHT ) VALUES (@PLAYERID, @CLUBID, @NAME, @POSITION, @NATIONALITY, @BIRTHDAY, @AGE, @HEIGHT, @WEIGHT)
END

--Sửa cầu thủ
GO
CREATE PROC UPDATE_PLAYER
@PLAYERID int, @CLUBID INT, @NAME nvarchar(100), @POSITION nvarchar(100), @NATIONALITY NVARCHAR(100), @BIRTHDAY DATETIME, @AGE INT, @HEIGHT INT, @WEIGHT INT
AS
BEGIN
	UPDATE dbo.PLAYER SET CLUBID= @CLUBID, NAME=@NAME, POSITION=@POSITION, NATIONALITY=@NATIONALITY, BIRTHDAY=@BIRTHDAY, AGE=@AGE, HEIGHT=@HEIGHT, WEIGHT=@WEIGHT
	WHERE PLAYERID=@PLAYERID
END