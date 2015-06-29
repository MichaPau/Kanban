INSERT INTO Categories (boardId, color, title)
SELECT :newBoardId, Categories.color, Categories.title
FROM Categories WHERE Categories.boardId = :copyFromBoardId