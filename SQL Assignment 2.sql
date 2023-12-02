TASK 1
select o.name as owner_name, o.surname as owner_surname , p.name as pet_name
from petowners o
left join pets p on o.OwnerID=p.OwnerID;

-- TASK 2
select o.name as owner_name, o.surname as owner_surname , p.name as pet_name
from pets p
left join petowners o on p.OwnerID=o.OwnerID;
-- All pets have recorded owners so the result of task2 and task1 is same

-- TASK 3
select *
from pets p
left join petowners o on p.OwnerID=o.OwnerID;
-- All information for the 100 pets, there are no onwers without pets and no pets without owners

-- TASK 4
select o.name as owner_name, o.surname as owner_surname , p.name as pet_name, d.procedureType
from procedureshistory d
join pets p on p.petid=d.petID
join petowners o on o.OwnerID=p.OwnerID;

-- TASK 5
SELECT o.OwnerID, o.Name, COUNT(p.PetID) AS NumberOfDogs
FROM petowners o
JOIN pets p ON o.OwnerID = p.OwnerID
WHERE p.Kind = 'Dog'
GROUP BY o.OwnerID, o.Name;

-- TASK 6
SELECT p.PetID, p.Name FROM pets p
LEFT JOIN procedureshistory ph ON p.PetID = ph.PetID
WHERE ph.PetID IS NULL;

-- TASK 7
select petid, name, age from pets
where age = (select max(age) from pets);

-- TASK 8
SELECT p.PetID, p.Name, ph.ProcedureType, pd.Price
FROM pets p
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.Proceduretype = pd.Proceduretype
WHERE pd.Price > (SELECT AVG(Price) FROM proceduresdetails);

-- TASK 9
SELECT p.PetID, p.Name, ph.ProcedureType, ph.date, pd.Price, pd.description from pets p
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.ProcedureSubCode = pd.ProcedureSubCode
                         AND ph.ProcedureType = pd.ProcedureType
WHERE p.Name = 'Cuddles';

-- TASK 10
SELECT po.OwnerID, po.Name, SUM(pd.price) AS TotalSpending
FROM petowners po
JOIN pets p ON po.OwnerID = p.OwnerID
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.ProcedureSubCode = pd.ProcedureSubCode
                         AND ph.ProcedureType = pd.ProcedureType
GROUP BY po.OwnerID, po.Name
HAVING SUM(pd.price) > (SELECT AVG(TotalCost) FROM (SELECT SUM(pd.price) AS TotalCost
                                                         FROM proceduresdetails pd
                                                         GROUP BY pd.ProcedureSubCode, pd.ProcedureType) AS AvgCost);

-- TASK 11
SELECT DISTINCT p.PetID, p.Name from pets p
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.ProcedureSubCode = pd.ProcedureSubCode
                         AND ph.ProcedureType = pd.ProcedureType
WHERE ph.ProcedureType = 'VACCINATIONS';

-- TASK 12
SELECT DISTINCT po.OwnerID, po.Name FROM petowners po
    JOIN pets p ON po.OwnerID = p.OwnerID
    JOIN procedureshistory ph ON p.PetID = ph.PetID
    WHERE ph.ProcedureType = 'EMERGENCY';
-- EMERGENCY DOESN'T EXIST IN THE RECORD. HENCE NO RESULT

-- TASK 13
SELECT po.OwnerID, po.Name, SUM(pd.PRICE) AS TotalCostSpent FROM petowners po
JOIN pets p ON po.OwnerID = p.OwnerID
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.ProcedureSubCode = pd.ProcedureSubCode
                         AND ph.ProcedureType = pd.ProcedureType
GROUP BY po.OwnerID, po.Name;

-- TASK 14
SELECT kind, COUNT(KIND) FROM PETS group by Kind;

-- TASK 15
SELECT gender, kind, COUNT(KIND) FROM PETS group by gender, Kind order by gender, kind;

-- TASK 16
SELECT Kind, AVG(Age) AS AverageAge FROM pets GROUP BY Kind HAVING COUNT(kind) > 5;

-- TASK 17
SELECT ProcedureType, AVG(price) AS AverageCost FROM proceduresdetails
GROUP BY ProcedureType HAVING AVG(price) > 50;

-- TASK 18
SELECT PetID, Name, Age,
    CASE
        WHEN Age < 3 THEN 'Young'
        WHEN Age BETWEEN 3 AND 8 THEN 'Adult'
        ELSE 'Senior'
    END AS AgeCategory
FROM pets;

-- TASK 19
SELECT po.OwnerID, po.Name, SUM(pd.price) AS TotalSpending,
    CASE
        WHEN SUM(pd.price) < 100 THEN 'Low Spender'
        WHEN SUM(pd.price) BETWEEN 100 AND 500 THEN 'Moderate Spender'
        ELSE 'High Spender'
    END AS SpendingCategory
FROM petowners po
JOIN pets p ON po.OwnerID = p.OwnerID
JOIN procedureshistory ph ON p.PetID = ph.PetID
JOIN proceduresdetails pd ON ph.ProcedureSubCode = pd.ProcedureSubCode
                         AND ph.ProcedureType = pd.ProcedureType
GROUP BY po.OwnerID, po.Name;

-- TASK 20
SELECT *,
case
when gender = "Male"  then "Boy"
when gender = "Female"  then "Girl"
Else "Uknown"
End as new_label
FROM PETS;

-- TASK 21
SELECT p.PetID, p.Name, COUNT(ph.Proceduretype) AS NumProcedures,
    CASE
        WHEN COUNT(ph.Proceduretype) BETWEEN 0 AND 3 THEN 'Regular'
        WHEN COUNT(ph.Proceduretype) BETWEEN 4 AND 7 THEN 'Frequent'
        ELSE 'Super User'
    END AS StatusLabel
FROM pets p
LEFT JOIN procedureshistory ph ON p.PetID = ph.PetID
GROUP BY p.PetID, p.Name;

-- TASK 22
SELECT PetID, Name, Age, Kind,
    RANK() OVER (PARTITION BY Kind ORDER BY Age) AS RankWithinKind
FROM pets;

-- TASK 23
SELECT PetID, Name, Age, Kind,
    DENSE_RANK() OVER (ORDER BY Age) AS AGE_RANK
FROM pets;

-- TASK 24
SELECT PetID, Name,
LEAD(Name) OVER (ORDER BY Name) AS NextPet,
LAG(Name) OVER (ORDER BY Name) AS PreviousPet
FROM pets;

-- TASK 25
SELECT DISTINCT Kind, AVG(Age) OVER (PARTITION BY Kind) AS AverageAgeByKind
FROM pets;

-- TASK 26
SELECT DISTINCT Kind, AVG(Age) OVER (PARTITION BY Kind) AS AverageAgeByKind
FROM pets;

-- TASK 27
WITH All_Pets AS (
    SELECT PetID, Name, Age FROM pets)
SELECT PetID, Name, Age
FROM All_Pets
WHERE Age > 5;