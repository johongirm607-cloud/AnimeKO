-- AnimeKO schema for Cloudflare D1 (mirrors src/lib/db.ts and src/lib/auth-service.ts)

CREATE TABLE IF NOT EXISTS manga (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  original_title TEXT,
  description TEXT,
  cover_url TEXT NOT NULL,
  author TEXT,
  artist TEXT,
  status TEXT DEFAULT 'ongoing',
  type TEXT DEFAULT 'manga',
  release_year INTEGER,
  views INTEGER DEFAULT 0,
  rating REAL DEFAULT 4.8,
  rating_count INTEGER DEFAULT 1,
  schedule_day TEXT DEFAULT 'Dushanba',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS genres (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  slug TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS manga_genres (
  manga_id INTEGER,
  genre_id INTEGER,
  PRIMARY KEY (manga_id, genre_id),
  FOREIGN KEY (manga_id) REFERENCES manga(id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chapters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  manga_id INTEGER NOT NULL,
  chapter_number REAL NOT NULL,
  title TEXT,
  volume INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (manga_id) REFERENCES manga(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chapter_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  chapter_id INTEGER NOT NULL,
  page_number INTEGER NOT NULL,
  image_url TEXT NOT NULL,
  FOREIGN KEY (chapter_id) REFERENCES chapters(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  manga_id INTEGER NOT NULL,
  author_name TEXT NOT NULL,
  content TEXT NOT NULL,
  rating INTEGER DEFAULT 5,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (manga_id) REFERENCES manga(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  avatar_url TEXT DEFAULT '/animeko-logo.jpg',
  role TEXT DEFAULT 'user',
  google_id TEXT,
  coins INTEGER DEFAULT 0,
  subscription_status TEXT DEFAULT 'free',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_manga_slug ON manga(slug);
CREATE INDEX IF NOT EXISTS idx_chapters_manga ON chapters(manga_id, chapter_number);
CREATE INDEX IF NOT EXISTS idx_pages_chapter ON chapter_pages(chapter_id, page_number);
CREATE INDEX IF NOT EXISTS idx_comments_manga ON comments(manga_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
