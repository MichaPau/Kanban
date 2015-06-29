CREATE TABLE "Categories" (
	id INTEGER PRIMARY KEY AUTOINCREMENT,    
	boardId INTEGER,    
	color INTEGER,
	title TEXT,
	FOREIGN KEY(boardId) REFERENCES Boards(id)
)