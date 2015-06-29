INSERT INTO Boards (title, creationTime, position)
SELECT :title, datetime('now', 'localtime'), :position