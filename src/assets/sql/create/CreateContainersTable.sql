CREATE TABLE "Containers" (
	id INTEGER PRIMARY KEY AUTOINCREMENT,   
	title TEXT NOT NULL DEFAULT ContainerTitle,   
	boardId INTEGER DEFAULT 0,   
	maxItems INTEGER DEFAULT 5,  
	parentId INTEGER,  
	position INTEGER NOT NULL DEFAULT 0,  
	type TEXT,
	FOREIGN KEY(boardId) REFERENCES Boards(id)
)