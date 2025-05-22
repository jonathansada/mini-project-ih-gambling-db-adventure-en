-- Q1:
SELECT Title, FirstName, LastName, DateOfBirth FROM Customer;

-- Q2: 
SELECT CustomerGroup, COUNT('CustomerID') AS Cgroup
FROM Customer
GROUP BY CustomerGroup;

-- Q3: 
SELECT c.*, a.CurrencyCode
FROM Customer AS c
JOIN Account AS a ON c.CustId;

-- Q4:
SELECT
    p.product AS ProductFamily,
    DATE(b.BetDate) AS BetDay,
    SUM(b.Bet_Amt) AS TotalBet
FROM Betting b
JOIN Product p
  ON b.ClassId = p.CLASSID AND b.CategoryId = p.CATEGORYID
GROUP BY ProductFamily, BetDay
ORDER BY BetDay;

-- Q5:
SELECT p.product, DATE (b.BetDate) AS BetDay, SUM(b.Bet_Amt) AS TotalBet
FROM Betting AS b
	JOIN Product AS p ON b.ClassId = p.ClassId AND b.CategoryId = p.CategoryId
WHERE b.BetDate >= '2012-11-01' AND p.product = 'Sportsbook'
GROUP BY p.product, BetDay
ORDER BY BetDay, p.product;

-- Q6:
SELECT p.product, a.CurrencyCode, c.CustomerGroup, SUM(b.Bet_Amt) AS TotalBet
FROM Betting AS b
	JOIN Product AS p ON b.ClassId = p.ClassId 
	JOIN Account AS a ON b.AccountNo = a.AccountNo
	JOIN Customer AS c ON a.CustId = c.CustId
WHERE b.BetDate >= '2012-12-01'
GROUP BY p.product, a.CurrencyCode, c.CustomerGroup
ORDER BY p.product, a.CurrencyCode, c.CustomerGroup;

-- Q7:
SELECT c.Title, c.FirstName, c.LastName, SUM(b.bet_amt) as TotalBets
FROM Customer as c 
	LEFT JOIN Account as a ON c.CustId = a.CustId
	LEFT JOIN Betting as b ON a.AccountNo = b.AccountNo AND b.BetDate >= '2012-11-01' AND b.BetDate < '2012-12-01'
GROUP BY c.CustId;

-- Q8:
SELECT c.Title, c.FirstName, c.LastName, COUNT(DISTINCT b.product) as NumProducts
FROM Customer as c 
	INNER JOIN Account as a ON c.CustId = a.CustId
	INNER JOIN Betting as b ON a.AccountNo = b.AccountNo
WHERE b.bet_amt > 0
GROUP BY c.CustId
ORDER BY NumProducts DESC;

-- Q9:
SELECT c.Title, c.FirstName, c.LastName, SUM(b.bet_amt) as TotalBets
FROM Customer as c 
	INNER JOIN Account as a ON c.CustId = a.CustId
	INNER JOIN Betting as b ON a.AccountNo = b.AccountNo
WHERE b.Product LIKE '%sportsbook%' AND b.bet_amt > 0
GROUP BY c.CustId;

-- Q10:
-- Assuming stanked money is the money beat - money won
SELECT c.Title, c.FirstName, c.LastName, s.product, s.money_stanked
FROM Customer as c
	INNER JOIN (
		SELECT a.CustId, b.product, MIN(b.Bet_Amt - b.Win_Amt) as money_stanked
		FROM Account as a
			LEFT JOIN Betting as b ON a.AccountNo = b.AccountNo
		GROUP BY a.CustId
		ORDER BY money_stanked ASC) as s ON c.CustId = s.CustId
GROUP BY c.CustId, s.product
ORDER BY  s.money_stanked ASC;

-- Q11:
SELECT student_name, GPA 
FROM student
ORDER BY GPA DESC
LIMIT 5;

-- Q12:
SELECT sc.school_name, COUNT(st.student_id) as students_num
FROM school as sc
	LEFT JOIN student as st ON sc.school_id = st.school_id
GROUP BY sc.school_id
ORDER BY students_num DESC;

-- Q13:
SELECT st.student_name, sc.school_name, MAX(st.GPA) as GPA 
FROM student as st
	INNER JOIN school as sc on st.school_id = sc.school_id
GROUP BY sc.school_id
ORDER BY st.GPA DESC;
