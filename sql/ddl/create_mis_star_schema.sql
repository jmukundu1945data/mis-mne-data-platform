
/*
MIS Star Schema for M&E Reporting
Designed for indicator-based analytics (e.g. PEPFAR TX_CURR, TX_NEW)

Author: Jonathan Mukundu
*/
-- =========================
-- DIMENSION: Province
-- =========================
CREATE TABLE dbo.Province (
    ProvinceID INT PRIMARY KEY,
    Province NVARCHAR(100) NOT NULL
);

-- =========================
-- DIMENSION: District
-- =========================
CREATE TABLE dbo.District (
    DistrictID INT PRIMARY KEY,
    District NVARCHAR(100) NOT NULL,
    ProvinceID INT NOT NULL,
    CONSTRAINT FK_District_Province
        FOREIGN KEY (ProvinceID) REFERENCES dbo.Province(ProvinceID)
);

-- =========================
-- DIMENSION: Facility
-- =========================
CREATE TABLE dbo.Facility (
    FacilityID INT PRIMARY KEY,
    Facility NVARCHAR(150) NOT NULL,
    DistrictID INT NOT NULL,
    CONSTRAINT FK_Facility_District
        FOREIGN KEY (DistrictID) REFERENCES dbo.District(DistrictID)
);

-- =========================
-- DIMENSION: Program
-- =========================
CREATE TABLE dbo.Program (
    ProgramID INT PRIMARY KEY,
    Program NVARCHAR(100) NOT NULL
);

-- =========================
-- DIMENSION: DataElement (Indicator)
-- =========================
CREATE TABLE dbo.DataElement (
    DataElementID NVARCHAR(50) PRIMARY KEY,
    DataElement NVARCHAR(150) NOT NULL,
    ProgramID INT NOT NULL,
    CONSTRAINT FK_DataElement_Program
        FOREIGN KEY (ProgramID) REFERENCES dbo.Program(ProgramID)
);

-- =========================
-- DIMENSION: Gender
-- =========================
CREATE TABLE dbo.Gender (
    GenderID INT PRIMARY KEY,
    Gender NVARCHAR(50) NOT NULL
);

-- =========================
-- DIMENSION: AgeGroup
-- =========================
CREATE TABLE dbo.AgeGroup (
    AgeGroupID INT PRIMARY KEY,
    AgeGroupName NVARCHAR(50) NOT NULL
);

-- =========================
-- DIMENSION: Time
-- =========================
CREATE TABLE dbo.Time (
    TimeKey INT PRIMARY KEY,
    MonthID INT NOT NULL,
    MonthName NVARCHAR(20),
    YearID INT NOT NULL,
    YearName INT NOT NULL,
    YearMonthName NVARCHAR(20),
    QuarterID INT,
    SemesterID INT,
    PepfarFyID INT
);

-- =========================
-- DIMENSION: TimePEPFAR
-- =========================
CREATE TABLE dbo.TimePEPFAR (
    PepfarFyID INT PRIMARY KEY,
    PepfarFy NVARCHAR(20)
);


-- =========================
-- FACT TABLE: Data
-- =========================
CREATE TABLE dbo.Data (
    ID INT IDENTITY(1,1) PRIMARY KEY,

    FacilityID INT NOT NULL,
    DataElementID NVARCHAR(50) NOT NULL,
    TimeKey INT NOT NULL,
    GenderID INT NOT NULL,
    AgeGroupID INT NOT NULL,

    Value INT NOT NULL CHECK (Value >= 0),

    -- Foreign Keys
    CONSTRAINT FK_Data_Facility
        FOREIGN KEY (FacilityID) REFERENCES dbo.Facility(FacilityID),

    CONSTRAINT FK_Data_DataElement
        FOREIGN KEY (DataElementID) REFERENCES dbo.DataElement(DataElementID),

    CONSTRAINT FK_Data_Time
        FOREIGN KEY (TimeKey) REFERENCES dbo.Time(TimeKey),

    CONSTRAINT FK_Data_Gender
        FOREIGN KEY (GenderID) REFERENCES dbo.Gender(GenderID),

    CONSTRAINT FK_Data_AgeGroup
        FOREIGN KEY (AgeGroupID) REFERENCES dbo.AgeGroup(AgeGroupID)
);


-- =========================
-- INDEXES FOR PERFORMANCE
-- =========================

-- Fact table composite index
CREATE NONCLUSTERED INDEX IX_Data_Main
ON dbo.Data (TimeKey, FacilityID, DataElementID)
INCLUDE (Value);

-- Index for indicator filtering
CREATE NONCLUSTERED INDEX IX_Data_DataElement
ON dbo.Data (DataElementID);

-- Index for time-based queries
CREATE NONCLUSTERED INDEX IX_Data_Time
ON dbo.Data (TimeKey);


