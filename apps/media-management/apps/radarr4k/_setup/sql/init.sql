-- TODO : Table Config check pass


-- AutoTagging
DELETE FROM AutoTagging;
INSERT INTO AutoTagging (
    Id,
    Name,
    Specifications,
    RemoveTagsAutomatically,
    Tags
)
VALUES (
    1,
    'movies',
    '[
        {
            "type": "RootFolderSpecification",
            "body": {
                "order": 1,
                "implementationName": "Root Folder",
                "value": "/data/media/movies",
                "name": "movies",
                "negate": false,
                "required": false
            }
        }
    ]',
    0,
    '[
        1
    ]'
);

-- Config
DELETE FROM Config;
INSERT INTO Config (Id, Key, Value)
VALUES
(1, 'plexclientidentifier', 'fb173292-2ad4-49f2-b256-e3dde403cacd'),
(2, 'rijndaelpassphrase', '8fd1d813-1da9-4dad-89d5-e6d7d3f96435'),
(3, 'hmacpassphrase', '79dfb5fc-e52d-4f79-91c9-7fbd4299dfcf'),
(4, 'rijndaelsalt', '46470625-cefa-45a5-8321-7670551e069d'),
(5, 'hmacsalt', '541da817-e217-4fd4-a39c-4540ae049e48'),
(6, 'cleanupmetadataimages', 'False'),
(7, 'autounmonitorpreviouslydownloadedmovies', 'True'),
(8, 'firstdayofweek', '1'),
(9, 'calendarweekcolumnheader', 'ddd DD/MM'),
(10, 'shortdateformat', 'DD MMM YYYY'),
(11, 'longdateformat', 'dddd, D MMMM YYYY'),
(12, 'timeformat', 'HH:mm');
    

-- DelayProfiles
DELETE FROM DelayProfiles;
INSERT INTO DelayProfiles (Id, EnableUsenet, EnableTorrent, PreferredProtocol, UsenetDelay, TorrentDelay, "Order", Tags, BypassIfHighestQuality, BypassIfAboveCustomFormatScore, MinimumCustomFormatScore)
VALUES (1, 1, 1, 1, 0, 0, 2147483647, '[]', 1, 0, NULL);

-- DownloadClients
DELETE FROM DownloadClients;
INSERT INTO DownloadClients (Id, Enable, Name, Implementation, Settings, ConfigContract, Priority, RemoveCompletedDownloads, RemoveFailedDownloads, Tags)
VALUES (
  1,
  1,
  'qbit',
  'QBittorrent',
  '{
    "host": "${DOCKER_SUBNET}.10",
    "port": ${PORT_UI_QBITTORRENT},
    "useSsl": false,
    "username": "admin",
    "password": "admin!",
    "movieCategory": "movies",
    "recentMoviePriority": 0,
    "olderMoviePriority": 0,
    "initialState": 0,
    "sequentialOrder": false,
    "firstAndLast": false,
    "contentLayout": 0
  }',
  'QBittorrentSettings',
  1,
  1,
  1,
  '[1]'
);

-- Indexers
DELETE FROM Indexers;   
INSERT INTO Indexers (Id, Name, Implementation, Settings, ConfigContract, EnableRss, EnableAutomaticSearch, EnableInteractiveSearch, Priority, Tags, DownloadClientId)
VALUES
(1, '1337x (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/1/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000, 2070, 2030, 2010, 2040, 2060, 2045],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(2, 'The Pirate Bay (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/2/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000, 2020, 2040, 2060, 2030, 2045],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(3, 'Torrent9 (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/3/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(4, 'Badass Torrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/5/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(5, 'ExtraTorrent.st (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/7/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000, 2040, 2045, 2060, 2070, 2010, 2020],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(6, 'Internet Archive (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/9/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(7, 'kickasstorrents.ws (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/10/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(8, 'Torlock (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/11/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(9, 'BitSearch (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://${DOCKER_SUBNET}.15:${PORT_UI_PROWLARR}/6/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0);

-- Metadata
DELETE FROM Metadata;   
INSERT INTO Metadata (Id, Enable, Name, Implementation, Settings, ConfigContract)
VALUES
(1, 0, 'Kodi (XBMC) / Emby', 'XbmcMetadata', '{
  "movieMetadata": true,
  "useMovieNfo": false,
  "movieMetadataLanguage": 1,
  "movieMetadataURL": false,
  "addCollectionName": true,
  "movieImages": true,
  "isValid": true
}', 'XbmcMetadataSettings'),
(2, 0, 'WDTV', 'WdtvMetadata', '{
  "movieMetadata": true,
  "movieImages": true,
  "isValid": true
}', 'WdtvMetadataSettings'),
(3, 0, 'Roksbox', 'RoksboxMetadata', '{
  "movieMetadata": true,
  "movieImages": true,
  "isValid": true
}', 'RoksboxMetadataSettings'),
(4, 0, 'Emby (Legacy)', 'MediaBrowserMetadata', '{
  "movieMetadata": true,
  "isValid": true
}', 'MediaBrowserMetadataSettings'),
(5, 0, 'Kometa', 'KometaMetadata', '{
  "movieImages": true
}', 'KometaMetadataSettings');

-- NamingConfig
DELETE FROM NamingConfig;
INSERT INTO NamingConfig (Id, ReplaceIllegalCharacters, StandardMovieFormat, MovieFolderFormat, ColonReplacementFormat, RenameMovies)
VALUES
(1, 1, '{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} {edition-{Edition Tags}} {[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[Mediainfo VideoCodec]}{-Release Group}', '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}', 4, 1);

-- QualityDefinitions
DELETE FROM QualityDefinitions;
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize)
VALUES
(1, 0, 'Unknown', 0, 100, 95),
(2, 24, 'WORKPRINT', 0, 100, 95),
(3, 25, 'CAM', 0, 100, 95),
(4, 26, 'TELESYNC', 0, 100, 95),
(5, 27, 'TELECINE', 0, 100, 95),
(6, 29, 'REGIONAL', 0, 100, 95),
(7, 28, 'DVDSCR', 0, 100, 95),
(8, 1, 'SDTV', 0, 100, 95),
(9, 2, 'DVD', 0, 100, 95),
(10, 23, 'DVD-R', 0, 100, 95),
(11, 8, 'WEBDL-480p', 0, 100, 95),
(12, 12, 'WEBRip-480p', 0, 100, 95),
(13, 20, 'Bluray-480p', 0, 100, 95),
(14, 21, 'Bluray-576p', 0, 100, 95),
(15, 4, 'HDTV-720p', 0, 100, 95),
(16, 5, 'WEBDL-720p', 0, 100, 95),
(17, 14, 'WEBRip-720p', 0, 100, 95),
(18, 6, 'Bluray-720p', 0, 100, 95),
(19, 9, 'HDTV-1080p', 0, 100, 95),
(20, 3, 'WEBDL-1080p', 0, 100, 95),
(21, 15, 'WEBRip-1080p', 0, 100, 95),
(22, 7, 'Bluray-1080p', 0, NULL, NULL),
(23, 30, 'Remux-1080p', 0, NULL, NULL),
(24, 16, 'HDTV-2160p', 0, NULL, NULL),
(25, 18, 'WEBDL-2160p', 0, NULL, NULL),
(26, 17, 'WEBRip-2160p', 0, NULL, NULL),
(27, 19, 'Bluray-2160p', 0, NULL, NULL),
(28, 31, 'Remux-2160p', 0, NULL, NULL),
(29, 22, 'BR-DISK', 0, NULL, NULL),
(30, 10, 'Raw-HD', 0, NULL, NULL);

-- QualityProfiles
DELETE FROM QualityProfiles;    
INSERT INTO QualityProfiles (Id, Name, Cutoff, Items, Language, FormatItems, UpgradeAllowed, MinFormatScore, CutoffFormatScore, MinUpgradeFormatScore)
VALUES
(1, 'Any', 20, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": true},
  {"quality": 25, "items": [], "allowed": true},
  {"quality": 26, "items": [], "allowed": true},
  {"quality": 27, "items": [], "allowed": true},
  {"quality": 29, "items": [], "allowed": true},
  {"quality": 28, "items": [], "allowed": true},
  {"quality": 1, "items": [], "allowed": true},
  {"quality": 2, "items": [], "allowed": true},
  {"quality": 23, "items": [], "allowed": true},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": true},
    {"quality": 12, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 20, "items": [], "allowed": true},
  {"quality": 21, "items": [], "allowed": true},
  {"quality": 4, "items": [], "allowed": true},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": true},
    {"quality": 14, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 6, "items": [], "allowed": true},
  {"quality": 9, "items": [], "allowed": true},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": true},
    {"quality": 15, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 7, "items": [], "allowed": true},
  {"quality": 30, "items": [], "allowed": true},
  {"quality": 16, "items": [], "allowed": true},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": true},
    {"quality": 17, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 19, "items": [], "allowed": true},
  {"quality": 31, "items": [], "allowed": true},
  {"quality": 22, "items": [], "allowed": true},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1),
(2, 'SD', 20, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": true},
  {"quality": 25, "items": [], "allowed": true},
  {"quality": 26, "items": [], "allowed": true},
  {"quality": 27, "items": [], "allowed": true},
  {"quality": 29, "items": [], "allowed": true},
  {"quality": 28, "items": [], "allowed": true},
  {"quality": 1, "items": [], "allowed": true},
  {"quality": 2, "items": [], "allowed": true},
  {"quality": 23, "items": [], "allowed": false},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": true},
    {"quality": 12, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 20, "items": [], "allowed": true},
  {"quality": 21, "items": [], "allowed": true},
  {"quality": 4, "items": [], "allowed": false},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": false},
    {"quality": 14, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 6, "items": [], "allowed": false},
  {"quality": 9, "items": [], "allowed": false},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": false},
    {"quality": 15, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 7, "items": [], "allowed": false},
  {"quality": 30, "items": [], "allowed": false},
  {"quality": 16, "items": [], "allowed": false},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": false},
    {"quality": 17, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 19, "items": [], "allowed": false},
  {"quality": 31, "items": [], "allowed": false},
  {"quality": 22, "items": [], "allowed": false},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1),
(3, 'HD-720p', 6, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": false},
  {"quality": 25, "items": [], "allowed": false},
  {"quality": 26, "items": [], "allowed": false},
  {"quality": 27, "items": [], "allowed": false},
  {"quality": 29, "items": [], "allowed": false},
  {"quality": 28, "items": [], "allowed": false},
  {"quality": 1, "items": [], "allowed": false},
  {"quality": 2, "items": [], "allowed": false},
  {"quality": 23, "items": [], "allowed": false},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": false},
    {"quality": 12, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 20, "items": [], "allowed": false},
  {"quality": 21, "items": [], "allowed": false},
  {"quality": 4, "items": [], "allowed": true},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": true},
    {"quality": 14, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 6, "items": [], "allowed": true},
  {"quality": 9, "items": [], "allowed": false},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": false},
    {"quality": 15, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 7, "items": [], "allowed": false},
  {"quality": 30, "items": [], "allowed": false},
  {"quality": 16, "items": [], "allowed": false},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": false},
    {"quality": 17, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 19, "items": [], "allowed": false},
  {"quality": 31, "items": [], "allowed": false},
  {"quality": 22, "items": [], "allowed": false},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1),
(4, 'HD-1080p', 7, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": false},
  {"quality": 25, "items": [], "allowed": false},
  {"quality": 26, "items": [], "allowed": false},
  {"quality": 27, "items": [], "allowed": false},
  {"quality": 29, "items": [], "allowed": false},
  {"quality": 28, "items": [], "allowed": false},
  {"quality": 1, "items": [], "allowed": false},
  {"quality": 2, "items": [], "allowed": false},
  {"quality": 23, "items": [], "allowed": false},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": false},
    {"quality": 12, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 20, "items": [], "allowed": false},
  {"quality": 21, "items": [], "allowed": false},
  {"quality": 4, "items": [], "allowed": false},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": false},
    {"quality": 14, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 6, "items": [], "allowed": false},
  {"quality": 9, "items": [], "allowed": true},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": true},
    {"quality": 15, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 7, "items": [], "allowed": true},
  {"quality": 30, "items": [], "allowed": true},
  {"quality": 16, "items": [], "allowed": false},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": false},
    {"quality": 17, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 19, "items": [], "allowed": false},
  {"quality": 31, "items": [], "allowed": false},
  {"quality": 22, "items": [], "allowed": false},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1),
(5, 'Ultra-HD', 31, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": false},
  {"quality": 25, "items": [], "allowed": false},
  {"quality": 26, "items": [], "allowed": false},
  {"quality": 27, "items": [], "allowed": false},
  {"quality": 29, "items": [], "allowed": false},
  {"quality": 28, "items": [], "allowed": false},
  {"quality": 1, "items": [], "allowed": false},
  {"quality": 2, "items": [], "allowed": false},
  {"quality": 23, "items": [], "allowed": false},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": false},
    {"quality": 12, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 20, "items": [], "allowed": false},
  {"quality": 21, "items": [], "allowed": false},
  {"quality": 4, "items": [], "allowed": false},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": false},
    {"quality": 14, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 6, "items": [], "allowed": false},
  {"quality": 9, "items": [], "allowed": false},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": false},
    {"quality": 15, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 7, "items": [], "allowed": false},
  {"quality": 30, "items": [], "allowed": false},
  {"quality": 16, "items": [], "allowed": true},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": true},
    {"quality": 17, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 19, "items": [], "allowed": true},
  {"quality": 31, "items": [], "allowed": true},
  {"quality": 22, "items": [], "allowed": false},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1),
(6, 'HD - 720p/1080p', 6, '[
  {"quality": 0, "items": [], "allowed": false},
  {"quality": 24, "items": [], "allowed": false},
  {"quality": 25, "items": [], "allowed": false},
  {"quality": 26, "items": [], "allowed": false},
  {"quality": 27, "items": [], "allowed": false},
  {"quality": 29, "items": [], "allowed": false},
  {"quality": 28, "items": [], "allowed": false},
  {"quality": 1, "items": [], "allowed": false},
  {"quality": 2, "items": [], "allowed": false},
  {"quality": 23, "items": [], "allowed": false},
  {"id": 1000, "name": "WEB 480p", "items": [
    {"quality": 8, "items": [], "allowed": false},
    {"quality": 12, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 20, "items": [], "allowed": false},
  {"quality": 21, "items": [], "allowed": false},
  {"quality": 4, "items": [], "allowed": true},
  {"id": 1001, "name": "WEB 720p", "items": [
    {"quality": 5, "items": [], "allowed": true},
    {"quality": 14, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 6, "items": [], "allowed": true},
  {"quality": 9, "items": [], "allowed": true},
  {"id": 1002, "name": "WEB 1080p", "items": [
    {"quality": 3, "items": [], "allowed": true},
    {"quality": 15, "items": [], "allowed": true}
  ], "allowed": true},
  {"quality": 7, "items": [], "allowed": true},
  {"quality": 30, "items": [], "allowed": true},
  {"quality": 16, "items": [], "allowed": false},
  {"id": 1003, "name": "WEB 2160p", "items": [
    {"quality": 18, "items": [], "allowed": false},
    {"quality": 17, "items": [], "allowed": false}
  ], "allowed": false},
  {"quality": 19, "items": [], "allowed": false},
  {"quality": 31, "items": [], "allowed": false},
  {"quality": 22, "items": [], "allowed": false},
  {"quality": 10, "items": [], "allowed": false}
]', 1, '[]', 0, 0, 0, 1);


-- RemotePathMappings
DELETE FROM RemotePathMappings; 
INSERT INTO RemotePathMappings (Id, Host, RemotePath, LocalPath)
VALUES
(1, '${DOCKER_SUBNET}.10', '/data/movies/', '/data/torrents/movies/');

-- RootFolders
DELETE FROM RootFolders;    
INSERT INTO RootFolders (Id, Path)
VALUES
(1, '/data/media/movies/');

-- ScheduledTasks
DELETE FROM ScheduledTasks;    
INSERT INTO ScheduledTasks (Id, TypeName, Interval, LastExecution, LastStartTime)
VALUES
(1, 'NzbDrone.Core.Messaging.Commands.MessagingCleanupCommand', 5, '2025-01-15 21:43:55.1695465Z', '2025-01-15 21:43:55.1644268Z'),
(2, 'NzbDrone.Core.Update.Commands.ApplicationCheckUpdateCommand', 360, '2025-01-15 21:03:55.8764272Z', '2025-01-15 21:03:55.6705559Z'),
(3, 'NzbDrone.Core.HealthCheck.CheckHealthCommand', 360, '2025-01-15 21:03:55.6274635Z', '2025-01-15 21:03:54.0883135Z'),
(4, 'NzbDrone.Core.Movies.Commands.RefreshMovieCommand', 1440, '2025-01-15 21:04:02.6987971Z', '2025-01-15 21:03:54.3496608Z'),
(5, 'NzbDrone.Core.Housekeeping.HousekeepingCommand', 1440, '2025-01-15 21:03:57.0035491Z', '2025-01-15 21:03:55.883481Z'),
(6, 'NzbDrone.Core.MediaFiles.Commands.CleanUpRecycleBinCommand', 1440, '2025-01-15 21:03:54.6731032Z', '2025-01-15 21:03:54.6495586Z'),
(7, 'NzbDrone.Core.Movies.Commands.RefreshCollectionsCommand', 1440, '2025-01-15 21:03:54.3112808Z', '2025-01-15 21:03:54.0686181Z'),
(8, 'NzbDrone.Core.Backup.BackupCommand', 10080, '2025-01-12 18:34:15.567968Z', '2025-01-12 18:34:15.1006314Z'),
(9, 'NzbDrone.Core.Indexers.RssSyncCommand', 30, '2025-01-15 21:34:41.4857271Z', '2025-01-15 21:34:25.0501324Z'),
(10, 'NzbDrone.Core.ImportLists.ImportListSyncCommand', 5, '2025-01-15 21:44:25.1822235Z', '2025-01-15 21:44:25.1751925Z'),
(11, 'NzbDrone.Core.Download.RefreshMonitoredDownloadsCommand', 1, '2025-01-15 21:44:25.19699Z', '2025-01-15 21:44:25.169703Z');

--- Tags
DELETE FROM Tags;
INSERT INTO
    Tags (Id, Label)
VALUES
    (1, 'movies');
