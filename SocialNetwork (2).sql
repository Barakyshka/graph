
USE master;
GO
DROP DATABASE IF EXISTS SocialNetwork;
GO
CREATE DATABASE SocialNetwork;
GO
USE SocialNetwork;
GO

-- �������� ������� ����� ��� �������������
CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
) AS NODE;

-- �������� ������� ����� ��� �����
CREATE TABLE Groups (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
) AS NODE;

-- �������� ������� ����� ��� ������
CREATE TABLE Posts (
    id INT PRIMARY KEY,
	title VARCHAR(50),
    text TEXT NOT NULL,
  time DATETIME
) AS NODE;

-- �������� ������� ���� ��� ������
CREATE TABLE Friending AS EDGE;

-- �������� ������� ���� ��� ����������
CREATE TABLE Publishing ([date] DATETIME) AS EDGE;

-- �������� ������� ���� ��� ��������
CREATE TABLE Subscribing ([date] DATETIME) AS EDGE;

-- ���������� ������� ����� ��� �������������
INSERT INTO Users (id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'David', 'david@example.com'),
(5, 'Eve', 'eve@example.com'),
(6, 'Frank', 'frank@example.com'),
(7, 'Grace', 'grace@example.com'),
(8, 'Henry', 'henry@example.com'),
(9, 'Ivy', 'ivy@example.com'),
(10, 'Jack', 'jack@example.com');

-- ���������� ������� ����� ��� �����
INSERT INTO Groups (id, name, description) VALUES
(1, 'Tech Enthusiasts', 'A group for technology enthusiasts'),
(2, 'Book Club', 'A group for book lovers'),
(3, 'Fitness Fanatics', 'A group for fitness enthusiasts'),
(4, 'Travel Lovers', 'A group for travel enthusiasts'),
(5, 'Photography Club', 'A group for photography enthusiasts'),
(6, 'Music Lovers', 'A group for music enthusiasts'),
(7, 'Cooking Club', 'A group for cooking enthusiasts'),
(8, 'Art Enthusiasts', 'A group for art lovers'),
(9, 'Gaming Club', 'A group for gaming enthusiasts'),
(10, 'Film Buffs', 'A group for movie lovers');

-- ���������� ������� ����� ��� ������
INSERT INTO Posts (id, title, text, time) VALUES
(1, 'Joining Group', 'Hello, everyone! Excited to join this group!', '2024-05-01 12:00:00'),
(2, 'Book Recommendations', 'Just finished reading an amazing book! Any recommendations?', '2024-05-02 09:30:00'),
(3, 'Morning Workout', 'Completed my morning workout routine. Feeling energized!', '2024-05-03 07:45:00'),
(4, 'Trip to Europe', 'Just returned from an incredible trip to Europe!', '2024-05-04 15:20:00'),
(5, 'Stunning Sunset', 'Captured a stunning sunset today. Nature is amazing!', '2024-05-05 19:00:00'),
(6, 'Favorite Music', 'Listening to my favorite music playlist. Music is life!', '2024-05-06 14:10:00'),
(7, 'Delicious Recipe', 'Tried a new recipe today and it turned out delicious!', '2024-05-07 18:30:00'),
(8, 'Art Gallery Visit', 'Visited an art gallery and saw some amazing paintings!', '2024-05-08 11:00:00'),
(9, 'Game High Score', 'Just achieved a new high score in my favorite game!', '2024-05-09 16:45:00'),
(10, 'Classic Movie Night', 'Watched a classic movie last night. Movie nights are the best!', '2024-05-10 20:15:00');

-- ���������� ������� ���� ��� ������
INSERT INTO Friending ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM Users WHERE id = 1), (SELECT $node_id FROM Users WHERE id = 2)),
((SELECT $node_id FROM Users WHERE id = 10), (SELECT $node_id FROM Users WHERE id = 5)),
((SELECT $node_id FROM Users WHERE id = 2), (SELECT $node_id FROM Users WHERE id = 9)),
((SELECT $node_id FROM Users WHERE id = 3), (SELECT $node_id FROM Users WHERE id = 1)),
((SELECT $node_id FROM Users WHERE id = 3), (SELECT $node_id FROM Users WHERE id = 6)),
((SELECT $node_id FROM Users WHERE id = 4), (SELECT $node_id FROM Users WHERE id = 2)),
((SELECT $node_id FROM Users WHERE id = 5), (SELECT $node_id FROM Users WHERE id = 4)),
((SELECT $node_id FROM Users WHERE id = 6), (SELECT $node_id FROM Users WHERE id = 7)),
((SELECT $node_id FROM Users WHERE id = 6), (SELECT $node_id FROM Users WHERE id = 8)),
((SELECT $node_id FROM Users WHERE id = 8), (SELECT $node_id FROM Users WHERE id = 3));


-- ���������� ������� ���� ��� ����������
INSERT INTO Publishing ($from_id, $to_id, [date])
VALUES 
((SELECT $node_id FROM Users WHERE ID = 1), (SELECT $node_id FROM Posts WHERE ID = 1), '2022-05-05 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 5), (SELECT $node_id FROM Posts WHERE ID = 1), '2022-05-10 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 8), (SELECT $node_id FROM Posts WHERE ID = 1), '2022-05-05 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 2), (SELECT $node_id FROM Posts WHERE ID = 2), '2022-05-10 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 3), (SELECT $node_id FROM Posts WHERE ID = 3), '2022-06-05 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 4), (SELECT $node_id FROM Posts WHERE ID = 3), '2022-06-10 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 6), (SELECT $node_id FROM Posts WHERE ID = 4), '2022-06-05 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 7), (SELECT $node_id FROM Posts WHERE ID = 4), '2022-06-10 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 1), (SELECT $node_id FROM Posts WHERE ID = 9), '2022-06-05 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 9), (SELECT $node_id FROM Posts WHERE ID = 4), '2022-06-10 14:30:00'),
((SELECT $node_id FROM Users WHERE ID = 10), (SELECT $node_id FROM Posts WHERE ID = 9), '2022-07-05 14:30:00');

-- ���������� ������� ���� ��� ��������
INSERT INTO Subscribing ($from_id, $to_id, [date])
VALUES 
((SELECT $node_id FROM Users WHERE ID = 1), (SELECT $node_id FROM Groups WHERE ID = 6), '2021-09-10 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 5), (SELECT $node_id FROM Groups WHERE ID = 1), '2021-09-05 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 8), (SELECT $node_id FROM Groups WHERE ID = 7), '2021-09-10 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 2), (SELECT $node_id FROM Groups WHERE ID = 2), '2021-10-05 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 3), (SELECT $node_id FROM Groups WHERE ID = 5), '2021-10-10 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 4), (SELECT $node_id FROM Groups WHERE ID = 3), '2021-10-05 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 6), (SELECT $node_id FROM Groups WHERE ID = 4), '2021-10-10 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 7), (SELECT $node_id FROM Groups WHERE ID = 2), '2021-10-05 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 1), (SELECT $node_id FROM Groups WHERE ID = 9), '2021-10-10 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 9), (SELECT $node_id FROM Groups WHERE ID = 8), '2021-11-05 09:45:00'),
((SELECT $node_id FROM Users WHERE ID = 10), (SELECT $node_id FROM Groups WHERE ID = 9), '2021-11-10 09:45:00');

-- ������� � �������� ���� ������

-- ������ 1: ��������� ���� �������������, ����������� �� ������, � ������� ������������ Alice
SELECT [User].name, G.name
FROM Users AS [User]
  , Subscribing
  , Groups AS G
WHERE MATCH([User]-(Subscribing)->G)
  AND [User].name = 'Joining Group';

-- ������ 2: ��������� ���� �������������, ������� ������������ ����� ����� 10 ��� 2022 ����
SELECT u.name, ps.title, p.date
FROM Users u
  , Publishing p
  , Posts ps
WHERE MATCH(u-(p)->ps)
AND p.date > '2022-05-10';

-- ������ 3: ��������� ���� �������������, ������� ����������� �� ������ ����� 10 �������� 2021 ����
SELECT [User].name, G.name, S.date
FROM Users AS [User]
  , Subscribing AS S
  , Groups AS G
WHERE MATCH([User]-(S)->G)
AND s.date > '2021-09-10';

-- ������ 4: ��������� ���� ������ ������������ Frank
SELECT u1.name, u2.name
FROM Users AS u1
  , Friending AS f
  , Users AS u2
WHERE MATCH(u1-(f)->u2)
  AND u1.name = 'Frank';

-- ������ 5: ��������� ���� ������������� � �������� �� ������, �������������� Alice
SELECT u.name, ps.title
FROM Users u
  , Publishing p
  , Posts ps
WHERE MATCH(u-(p)->ps)
AND ps.title = 'Joining Group';

-- ������ 6: ��������� ���� ������������� � �� ������, �������� ���������� ���� ��� ������������ Henry
SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS User1
 , Friending FOR PATH AS f
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(f)->User2)+))
 AND User1.name = 'Henry';

-- ������ 7: ��������� ���� ������������� � �� ������, �������� ���������� ���� ��� ������������ Frank � ������������ �� ����� ����
SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS User1
 , Friending FOR PATH AS f
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(f)->User2){1,3}))
 AND User1.name = 'Frank';

-- ������ 8: ��������� ������ ����� ��������������
SELECT User1.id AS IdFirst
  , User1.name AS First
  , CONCAT(N'user',User1.ID) AS [First image name]
  , User2.id AS IdSecond
  , User2.name AS Second
  , CONCAT(N'user', User2.id) AS [Second image name]
FROM Users AS User1
 , Friending AS f
 , Users AS User2
WHERE MATCH(User1-(f)->User2);

-- ������ 9: ��������� ������ ����� �������������� � �� ��������������� �������
SELECT [User].id AS IdFirst
  , [User].name AS First
  , CONCAT(N'user', [User].id) AS [First image name]
  , p.id AS IdSecond
  , p.title AS Second
  , CONCAT(N'post', p.id) AS [Second image name]
FROM Users AS [User]
  , Publishing AS ps
  , Posts
AS p
WHERE MATCH([User]-(ps)->p);

-- ������ 10: ��������� ������ ����� �������������� � ��������, �� ������� ��� ���������
SELECT [User].id AS IdFirst
  , [User].name AS First
  , CONCAT(N'user', [User].id) AS [First image name]
  , g.id AS IdSecond
  , g.name AS Second
  , CONCAT(N'groups', g.id) AS [Second image name]
FROM Users AS [User]
  , Subscribing AS s
  , Groups AS g
WHERE MATCH([User]-(s)->g);


--������:        DESKTOP-LVK19RB
--���� ������:   SocialNetwork
--https://github.com/nik-vitebskiy/SocialNetwork/tree/main/images/groups
--https://github.com/nik-vitebskiy/SocialNetwork/tree/main/images/posts
--https://github.com/nik-vitebskiy/SocialNetwork/tree/main/images/users

SELECT P1.ID AS IdFirst,
       P1.name AS First,
       CONCAT('User (', P1.id, ')') AS [First image name],
       P2.ID AS IdSecond,
       P2.name AS Second,
       CONCAT('User (', P2.id, ')') AS [Second image name]
FROM dbo.Users AS P1,
     dbo.Friending AS F,
     dbo.Users AS P2
WHERE MATCH (P1-(F)->P2);



