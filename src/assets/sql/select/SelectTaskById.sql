SELECT
T.id, T.title, containerId, creationTime, text, T.boardId, selectionTime, finishedTime, categoryId, color
FROM main.Tasks as T
LEFT JOIN Categories ON T.categoryId = Categories.id
WHERE T.id = :taskId