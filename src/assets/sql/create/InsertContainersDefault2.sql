INSERT INTO Containers (title, boardId, maxItems, parentId, position, type)
SELECT "Backlog", :boardId, 0, 0, 1, "backlog" UNION
SELECT "Doing", :boardId, 5, 0, 2, "normal" UNION
SELECT "Finished", :boardId, 0, 0, 3, "finished" 
