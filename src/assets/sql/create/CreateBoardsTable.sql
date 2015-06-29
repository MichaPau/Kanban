CREATE TABLE "Boards" (
	id INTEGER PRIMARY KEY AUTOINCREMENT,     
	title TEXT NOT NULL DEFAULT BoardTitle,     
	creationTime TEXT,
	position INTEGER,
	backgroundColor INTEGER NOT NULL DEFAULT 34749
)