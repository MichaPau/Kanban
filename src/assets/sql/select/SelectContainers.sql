SELECT id, title, boardId, maxItems, parentId, position, type 
FROM main.Containers
WHERE boardId = :boardId
ORDER BY position