INSERT INTO Tasks (id, title, containerId, creationTime, text, boardId, categoryId)
SELECT 1, "first task", 1, datetime('now', 'localtime'), "move this task to doing", 1, 1 UNION
SELECT 2, "second task", 1, datetime('now', 'localtime'), "move this task over doing to finished", 1, 1 UNION
SELECT 3, "third task", 1, datetime('now', 'localtime'), "delete this task and create a new one", 1, 1
