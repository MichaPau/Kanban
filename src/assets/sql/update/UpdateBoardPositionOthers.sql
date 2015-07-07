UPDATE Boards
SET position = position + 1
WHERE position >= :newPosition;