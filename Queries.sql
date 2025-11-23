 --دستورات select


SELECT * FROM Tours;

SELECT TourID,TourName,Destination from Tours where Destination='تهران';

SELECT * FROM Payments WHERE Amount<3000000 and PaymentMethod='کارت بانکی';

SELECT FirstName,LastName, Languages,ExperienceYears from TourLeaders 
WHERE ExperienceYears >= 10 ORDER BY ExperienceYears DESC;

SELECT ReservationID, SUM(Amount) AS TotalPaid FROM Payments GROUP BY ReservationID;

SELECT HotelName,location,PricePerNight FROM Accommodations 
WHERE PricePerNight BETWEEN 350000 AND 500000
ORDER BY PricePerNight;

SELECT HotelName,location,PricePerNight,Rating FROM Accommodations 
WHERE Rating in ('4.5','4.2');
SELECT FirstName,LastName FROM TourLeaders 
WHERE Firstname NOT LIKE 'م%';

SELECT ReservationID FROM Reservations
WHERE Status ='confirmed'
UNION
SELECT ReservationID from TravelerReservations
WHERE TravelerID BETWEEN 2 and 5;

SELECT TourLeaderID FROM TourLeaders
WHERE Specialization='تورهای مذهبی'
UNION
SELECT TourLeaderID from Tours 
where Destination='شیراز';



--ضرب دکارتی


SELECT Travelers.*,Tours.* 
FROM Travelers CROSS JOIN Tours;

SELECT DISTINCT tours.Destination,Travelers.LastName
FROM tours CROSS JOIN Travelers
ORDER BY Destination;

SELECT TourLeaders.FirstName,tours.TourName
FROM tours CROSS JOIN TourLeaders


--پیوند طبیعی دو جدول


--هتل‌هایی نمایش داده می‌شوند که مکان آن‌ها با مقصد تورها یکسان باشد
SELECT Accommodations.*,tours.*
FROM Accommodations 
INNER JOIN tours
ON Accommodations.location = tours.Destination;

--تعداد رزروهای انجام‌شده برای هر تور
SELECT tours.TourName, COUNT(Reservations.ReservationID) AS total_reservation
FROM Tours
INNER JOIN Reservations 
ON Tours.TourID = Reservations.TourID
GROUP BY Tours.TourName;

--تعداد رزروهای هر مسافز
SELECT Travelers.TravelerID,Travelers.FirstName,Travelers.LastName,
       COUNT(TravelerReservations.ReservationID) AS ReservationCount
FROM Travelers,TravelerReservations 
WHERE Travelers.TravelerID = TravelerReservations.TravelerID
GROUP BY Travelers.TravelerID, Travelers.FirstName, Travelers.LastName
ORDER BY TravelerID ASC;

--نام هتل ها و تورهای مقصد تهران
SELECT DISTINCT Accommodations.location, tours.TourName
FROM Accommodations
INNER JOIN tours
ON Accommodations.location = tours.Destination AND tours.Destination = 'تهران';

--نمایش اطلاعات پرداخت و رزرو مربوط به آن
SELECT Payments.PaymentID, Payments.PaymentDate, Payments.Amount, Payments.PaymentMethod, Reservations.ReservationDate, Reservations.Status
FROM Payments
INNER JOIN Reservations ON Payments.ReservationID = Reservations.ReservationID;



--پیوند طبیعی سه جدول


--برای هر مسافر، تمام رزروهایی که انجام داده به همراه تاریخ و وضعیتش رو نشون می‌ده
SELECT Travelers.TravelerID,Travelers.FirstName,Travelers.LastName,
       Reservations.ReservationID,Reservations.ReservationDate,
       Reservations.Status
FROM TravelerReservations
INNER JOIN Travelers 
    ON TravelerReservations.TravelerID = Travelers.TravelerID
INNER JOIN Reservations 
    ON TravelerReservations.ReservationID = Reservations.ReservationID;

--یک لیست از رزروها است که برای هر رزرو، اطلاعات تور و لیدر مربوطه رو هم نشون می‌دهای
SELECT Reservations.ReservationID,Reservations.ReservationDate,
    Reservations.Status AS ReservationStatus,
    Tours.TourName,Tours.Destination,
    TourLeaders.FirstName || ' ' || TourLeaders.LastName AS TourLeaderName
FROM Reservations,Tours,TourLeadersbjm
WHERE Reservations.TourID = Tours.TourID
      AND Tours.TourLeaderID = TourLeaders.TourLeaderID
ORDER BY Reservations.ReservationDate;

--این کوئری اطلاعات مسافران را که رزرو آن‌ها تأیید شده
SELECT Travelers.FirstName, Travelers.LastName, Reservations.ReservationDate, Reservations.Status
FROM Reservations
NATURAL JOIN TravelerReservations
NATURAL JOIN Travelers
WHERE Reservations.Status = 'Confirmed';

--جزئیات تور، همراه با هتل‌های مرتبط و تعداد رزروها
SELECT Tours.TourName, Tours.Destination, Accommodations.HotelName, COUNT(Reservations.ReservationID) AS TotalReservations
FROM Tours
INNER JOIN Accommodations ON Tours.TourID = Accommodations.TourID
INNER JOIN Reservations ON Tours.TourID = Reservations.TourID
GROUP BY Tours.TourName, Tours.Destination, Accommodations.HotelName;


--پیوند با خود


--شناسایی لیدرهای با سابقه مشابه برای مدیریت تورهای مشابه.
SELECT DISTINCT TL1.TourLeaderID AS Leader1_ID, TL1.FirstName AS Leader1_Name,
    TL2.TourLeaderID AS Leader2_ID,TL2.FirstName AS Leader2_Name,
    TL1.ExperienceYears
FROM TourLeaders TL1
INNER JOIN TourLeaders TL2
ON  TL1.ExperienceYears = TL2.ExperienceYears
    AND TL1.TourLeaderID < TL2.TourLeaderID;

--تعداد پرداختی ها و مجموع پذداختی های هر روز 
SELECT PaymentDate, COUNT(PaymentID) AS TotalPayments, 
                    SUM(Amount) AS TotalAmount
FROM Payments
GROUP BY PaymentDate
ORDER BY PaymentDate;

--  هتل هایی که در یک شهر قرار دارند
SELECT DISTINCT A1.AccommodationID AS Hotel1_ID, A1.HotelName AS Hotel1_Name, A1.Location,
                A2.AccommodationID AS Hotel2_ID, A2.HotelName AS Hotel2_Name, A2.location
FROM Accommodations A1
INNER JOIN Accommodations A2
ON A1.Location = A2.Location
AND A1.AccommodationID < A2.AccommodationID;
