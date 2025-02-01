DELETE FROM library_sections;
INSERT INTO library_sections (
    id, library_id, name, name_sort, section_type, language, agent, scanner, 
    user_thumb_url, user_art_url, user_theme_music_url, public, created_at, 
    updated_at, scanned_at, display_secondary_level, user_fields, query_xml, 
    query_type, uuid, changed_at, content_changed_at
) VALUES
    (1, NULL, 'Movies', NULL, 1, 'en-US', 'tv.plex.agents.movie', 'Plex Movie', 
    NULL, NULL, NULL, NULL, 1734272305, 1734468423, 1738360552, NULL, 
    '{"pr:respectTags":"1","pv:lastBlurHashChangedAt":"16504","pv:lastUltraBlurChangedAt":"16504","url":"pr%3ArespectTags=1&pv%3AlastBlurHashChangedAt=16504&pv%3AlastUltraBlurChangedAt=16504"}', 
    NULL, NULL, '0c7c32f4-0643-43bb-b1d1-3b16f9f44820', 266, 16505),
    (2, NULL, 'Series', NULL, 2, 'en-US', 'tv.plex.agents.series', 'Plex TV Series', 
    NULL, NULL, NULL, NULL, 1734286526, 1734998688, 1738360552, NULL, 
    '{"pv:lastBlurHashChangedAt":"9758","pv:lastUltraBlurChangedAt":"9758","url":"pv%3AlastBlurHashChangedAt=9758&pv%3AlastUltraBlurChangedAt=9758"}', 
    NULL, NULL, 'ff00f5aa-4c63-4929-b9ce-010cfc7b5449', 2089, 8650),
    (3, NULL, 'Anime', NULL, 2, 'en-US', 'tv.plex.agents.series', 'Plex TV Series', 
    NULL, NULL, NULL, NULL, 1734389208, 1735842619, 1738360252, NULL, 
    '{"url":""}', 
    NULL, NULL, 'fea48fbc-3ca8-48c7-accc-7326b8dbc7f4', 4737, 15758);

DELETE FROM section_locations;
INSERT INTO section_locations (
    id, library_section_id, root_path, available, scanned_at, created_at, updated_at
) VALUES
(1, 1, '/data/media/movies', 1, 1738360552, NULL, 1738360552),
(2, 2, '/data/media/series', 1, 1738360552, NULL, 1738360552),
(3, 3, '/data/media/anime', 1, 1738360252, NULL, 1738360252);