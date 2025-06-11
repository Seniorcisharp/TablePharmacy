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
    Название_Болезней NVARCHAR(70) NOT NULL,
    Симптомы NVARCHAR(100) NOT NULL,
    Противопоказания NVARCHAR(300)
);


CREATE TABLE Medikament (
    MedikamentId INT PRIMARY KEY,
    Название_Медикаментов NVARCHAR(70) NOT NULL,
    Форма NVARCHAR(100),
    Дозировка NVARCHAR(50),
    Срок DATE,
    Цена DECIMAL(10, 2),
    Надо_Ли_Рецепт BIT
);


CREATE TABLE Рекомендуемые_медикаменты (
    DiseaseId INT NOT NULL,
    MedikamentId INT NOT NULL,
    PRIMARY KEY (DiseaseId, MedikamentId),
    FOREIGN KEY (DiseaseId) REFERENCES Diseases(DiseaseId),
    FOREIGN KEY (MedikamentId) REFERENCES Medikament(MedikamentId)
);


CREATE TABLE Рецепты (
    RecipeId INT PRIMARY KEY,
    Имя_Доктора NVARCHAR(20) NOT NULL,
    Фамилия_Доктора NVARCHAR(20) NOT NULL,
    Имя_пациента NVARCHAR(20) NOT NULL,
    Фамилия_Пациента NVARCHAR(20) NOT NULL,
    Дата_Релиза DATE
);

-- Таблица: Рецепты-Медикаменты
CREATE TABLE Рецепты_Медикаменты (
    Recept_MedikamentId INT PRIMARY KEY,
    MedikamentId INT NOT NULL,
    Количество INT NOT NULL,
    RecipeId INT NOT NULL,
    FOREIGN KEY (MedikamentId) REFERENCES Medikament(MedikamentId),
    FOREIGN KEY (RecipeId) REFERENCES Рецепты(RecipeId)
);


CREATE TABLE Отпуск_Медикаментов (
    OtpuskId INT PRIMARY KEY,
    MedikamentId INT NOT NULL,
    Количество INT NOT NULL,
    Дата_Отпуска DATE,
    RecipeId INT,
    FOREIGN KEY (MedikamentId) REFERENCES Medikament(MedikamentId),
    FOREIGN KEY (RecipeId) REFERENCES Рецепты(RecipeId)
);


CREATE TABLE Поставка_на_Склад (
    NoteId INT PRIMARY KEY,
    Срок_Поставки DATE NOT NULL
);


CREATE TABLE Поставки_Медикамента (
    Note_MedikamentId INT PRIMARY KEY,
    NoteId INT NOT NULL,
    MedikamentId INT NOT NULL,
    Количество INT NOT NULL,
    FOREIGN KEY (NoteId) REFERENCES Поставка_на_Склад(NoteId),
    FOREIGN KEY (MedikamentId) REFERENCES Medikament(MedikamentId)
);






