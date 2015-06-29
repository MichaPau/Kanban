SELECT id, title, boardId, maxItems, parentId, position, type 
FROM main.Containers
WHERE id = :id