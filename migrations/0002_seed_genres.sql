-- Default genres (same list the app seeds on first run)
INSERT OR IGNORE INTO genres (name, slug) VALUES
  ('Jangari (Action)', 'action'),
  ('Sarguzasht (Adventure)', 'adventure'),
  ('Fantastika (Fantasy)', 'fantasy'),
  ('Sehr-jodu (Magic)', 'magic'),
  ('Romantika (Romance)', 'romance'),
  ('Komediya (Comedy)', 'comedy'),
  ('Drama', 'drama'),
  ('Shounen', 'shounen'),
  ('Isekai', 'isekai'),
  ('Psixologik (Psychological)', 'psychological');
