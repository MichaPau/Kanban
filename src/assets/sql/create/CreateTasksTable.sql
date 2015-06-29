CREATE TABLE "Tasks" (
	id INTEGER PRIMARY KEY AUTOINCREMENT,    
	title TEXT NOT NULL DEFAULT CardTitle,   
	containerId INTEGER NOT NULL DEFAULT 0,   
	creationTime TEXT,   
	text TEXT,   
	boardId INTEGER NOT NULL DEFAULT 0,  
	selectionTime TEXT,  
	finishedTime TEXT,
	categoryId INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY(containerId) REFERENCES Containers(id),
	FOREIGN KEY(categoryId) REFERENCES Categories(id)
)