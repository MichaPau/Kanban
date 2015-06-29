SELECT T.id, T.title, containerId, categoryId, creationTime, text, T.boardId, selectionTime, finishedTime, color 
FROM Tasks AS T 
LEFT JOIN Categories ON T.categoryId = Categories.id
WHERE T.boardId = :boardId