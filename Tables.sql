USE master;
GO
DROP DATABASE IF EXISTS Pharmacy;
GO
CREATE DATABASE Pharmacy;
GO
USE Pharmacy;
GO

CREATE TABLE Diseases (
    DiseaseId INT PRIMARY KEY,
    DiseaseName NVARCHAR(70) NOT NULL,
    Symptoms NVARCHAR(100) NOT NULL,
    Contraindications NVARCHAR(300)
);

CREATE TABLE Medications (
    MedicationId INT PRIMARY KEY,
    MedicationName NVARCHAR(70) NOT NULL,
    Form NVARCHAR(100),
    Dosage NVARCHAR(50),
    ExpirationDate DATE,
    Price DECIMAL(10, 2),
    RequiresPrescription BIT
);

CREATE TABLE Recommended_Medications (
    DiseaseId INT NOT NULL,
    MedicationId INT NOT NULL,
    PRIMARY KEY (DiseaseId, MedicationId),
    FOREIGN KEY (DiseaseId) REFERENCES Diseases(DiseaseId),
    FOREIGN KEY (MedicationId) REFERENCES Medications(MedicationId)
);

CREATE TABLE Prescriptions (
    PrescriptionId INT PRIMARY KEY,
    DoctorFirstName NVARCHAR(20) NOT NULL,
    DoctorLastName NVARCHAR(20) NOT NULL,
    PatientFirstName NVARCHAR(20) NOT NULL,
    PatientLastName NVARCHAR(20) NOT NULL,
    ReleaseDate DATE
);

CREATE TABLE Prescription_Medications (
    PrescriptionMedicationId INT PRIMARY KEY,
    MedicationId INT NOT NULL,
    Quantity INT NOT NULL,
    PrescriptionId INT NOT NULL,
    FOREIGN KEY (MedicationId) REFERENCES Medications(MedicationId),
    FOREIGN KEY (PrescriptionId) REFERENCES Prescriptions(PrescriptionId)
);

CREATE TABLE Medication_Issuance (
    IssuanceId INT PRIMARY KEY,
    MedicationId INT NOT NULL,
    Quantity INT NOT NULL,
    IssuanceDate DATE,
    PrescriptionId INT,
    FOREIGN KEY (MedicationId) REFERENCES Medications(MedicationId),
    FOREIGN KEY (PrescriptionId) REFERENCES Prescriptions(PrescriptionId)
);

CREATE TABLE Warehouse_Supply (
    SupplyNoteId INT PRIMARY KEY,
    SupplyDate DATE NOT NULL
);

CREATE TABLE Supply_Medications (
    SupplyMedicationId INT PRIMARY KEY,
    SupplyNoteId INT NOT NULL,
    MedicationId INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (SupplyNoteId) REFERENCES Warehouse_Supply(SupplyNoteId),
    FOREIGN KEY (MedicationId) REFERENCES Medications(MedicationId)
);
