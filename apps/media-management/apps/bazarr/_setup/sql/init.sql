DELETE FROM table_movies_rootfolder;
INSERT INTO table_movies_rootfolder (accessible, error, id, path)
VALUES (1, NULL, 1, '/data/media/movies');

DELETE FROM table_shows_rootfolder;
INSERT INTO table_shows_rootfolder (accessible, error, id, path)
VALUES (1, NULL, 3, '/data/media/series');

UPDATE table_settings_languages
SET enabled = 1
WHERE code3 IN ('eng', 'fra');

DELETE FROM table_languages_profiles;
INSERT INTO table_languages_profiles (
    profileId, cutoff, originalFormat, items, name, mustContain, mustNotContain, tag
)
VALUES (
    1,
    NULL,
    0,
    '[{"id": 1, "language": "en", "audio_exclude": "False", "hi": "False", "forced": "False"}, {"id": 2, "language": "fr", "audio_exclude": "True", "hi": "False", "forced": "False"}]',
    'Main',
    '[]',
    '[]',
    NULL
);
