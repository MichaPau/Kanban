INSERT INTO Boards (id, title, creationTime)
SELECT 1, :title, datetime('now', 'localtime'), 1
