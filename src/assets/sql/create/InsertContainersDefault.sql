INSERT INTO Containers (id, title, boardId, maxItems, parentId, position, type)
SELECT 1, "Backlog", 1, 0, 0, 1, "backlog" UNION
SELECT 2, "Doing", 1, 5, 0, 2, "normal" UNION
SELECT 3, "Finished", 1, 0, 0, 3, "finished" 
