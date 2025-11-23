-- جدول لیدرها
CREATE TABLE TourLeaders (
    TourLeaderID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactInfo VARCHAR(100),
    ExperienceYears INT NOT NULL,
    Languages TEXT NOT NULL,
    Specialization VARCHAR(100)
);

-- جدول تورها
CREATE TABLE Tours (
    TourID SERIAL PRIMARY KEY,
    TourName VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price NUMERIC(10,2) NOT NULL,
    MaxParticipants INT NOT NULL,
    TourLeaderID INT REFERENCES TourLeaders(TourLeaderID) ON DELETE SET NULL,
    DurationDays INT GENERATED ALWAYS AS (EndDate - StartDate) STORED
);

-- جدول هتل‌ها
CREATE TABLE Accommodations (
    AccommodationID SERIAL PRIMARY KEY,
    HotelName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    TourID INT NOT NULL REFERENCES Tours(TourID) ON DELETE CASCADE,
    PricePerNight NUMERIC(10,2) NOT NULL,
    Rating DECIMAL(2,1)
);

-- جدول مسافران
CREATE TABLE Travelers (
    TravelerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    PassportNumber VARCHAR(20) UNIQUE NOT NULL
);

-- جدول رزروها
CREATE TABLE Reservations (
    ReservationID SERIAL PRIMARY KEY,
    TourID INT NOT NULL REFERENCES Tours(TourID) ON DELETE CASCADE,
    ReservationDate DATE DEFAULT CURRENT_DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending' NOT NULL
);

-- جدول میانی مسافران و رزروها
CREATE TABLE TravelerReservations (
    TravelerReservationID SERIAL PRIMARY KEY,
    TravelerID INT NOT NULL REFERENCES Travelers(TravelerID) ON DELETE CASCADE,
    ReservationID INT NOT NULL REFERENCES Reservations(ReservationID) ON DELETE CASCADE,
    UNIQUE (TravelerID, ReservationID)
);

-- جدول پرداخت‌ها
CREATE TABLE Payments (
    PaymentID SERIAL PRIMARY KEY,
    ReservationID INT UNIQUE NOT NULL REFERENCES Reservations(ReservationID) ON DELETE CASCADE,
    PaymentDate DATE NOT NULL,
    Amount NUMERIC(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(20) DEFAULT 'Completed' NOT NULL
);
