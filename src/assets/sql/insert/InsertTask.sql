INSERT INTO main.Tasks (title, containerId, creationTime, text, boardId, categoryId)
VALUES (:title, :containerId, datetime('now', 'localtime'), :text, :boardId, :categoryId)