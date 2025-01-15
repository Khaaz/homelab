-- TODO : Table Config check pass
-- TODO : DownloadClients change access
-- TODO : API key to change into Indexer


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
    "host": "localhost",
    "port": 8200,
    "useSsl": false,
    "username": "admin",
    "password": "Khaaz11!",
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
  "baseUrl": "http://localhost:9696/1/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000, 2070, 2030, 2010, 2040, 2060, 2045],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(2, 'The Pirate Bay (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/2/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000, 2020, 2040, 2060, 2030, 2045],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(3, 'Torrent9 (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/3/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(4, 'Badass Torrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/5/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(5, 'ExtraTorrent.st (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/7/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000, 2040, 2045, 2060, 2070, 2010, 2020],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(6, 'Internet Archive (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/9/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(7, 'kickasstorrents.ws (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/10/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(8, 'Torlock (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/11/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [2000],
  "multiLanguages": [],
  "removeYear": false
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0),
(9, 'BitSearch (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "requiredFlags": [],
  "baseUrl": "http://localhost:9696/6/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
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
(1, 'localhost', '/data/movies/', '/data/torrents/movies/');

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
    (1, "movies");

-- Commands
DELETE FROM Commands;
INSERT INTO Commands (Id Name Body Priority Status QueuedAt StartedAt EndedAt Duration Exception Trigger Result) VALUES ('23120','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-14T19:48:08Z;
  lastStartTime: 2025-01-14T19:47:58Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','6','2025-01-14 20:18:28.9217388Z','2025-01-14 20:18:28.9245625Z','2025-01-15 21:03:23.9514778Z','','','2','0'),('23121','RefreshCollections','{
  collectionIds: [];
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  isLongRunning: true;
  completionMessage: Completed;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: RefreshCollections;
  lastExecutionTime: 2025-01-14T19:17:30Z;
  lastStartTime: 2025-01-14T19:17:28Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.0043121Z','2025-01-15 21:03:54.0686181Z','2025-01-15 21:03:54.2683786Z','00:00:00.1997605','','2','0'),('23122','CheckHealth','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: CheckHealth;
  lastExecutionTime: 2025-01-14T19:17:28Z;
  lastStartTime: 2025-01-14T19:17:28Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.0697832Z','2025-01-15 21:03:54.0883135Z','2025-01-15 21:03:55.5818043Z','00:00:01.4934908','','2','0'),('23123','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-14T20:13:58Z;
  lastStartTime: 2025-01-14T20:13:58Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.0950516Z','2025-01-15 21:03:54.1157767Z','2025-01-15 21:03:54.2242154Z','00:00:00.1084387','','2','0'),('23124','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-14T20:17:29Z;
  lastStartTime: 2025-01-14T20:17:28Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:03:54.1210108Z','2025-01-15 21:03:54.3434765Z','2025-01-15 21:03:54.5853827Z','00:00:00.2419062','','2','0'),('23125','RefreshMovie','{
  movieIds: [];
  isNewMovie: false;
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  isLongRunning: true;
  completionMessage: Completed;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: RefreshMovie;
  lastExecutionTime: 2025-01-14T19:17:32Z;
  lastStartTime: 2025-01-14T19:17:30Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.147635Z','2025-01-15 21:03:54.3496608Z','2025-01-15 21:04:02.6898364Z','00:00:08.3401756','','2','0'),('23126','CleanUpRecycleBin','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: CleanUpRecycleBin;
  lastExecutionTime: 2025-01-14T19:17:28Z;
  lastStartTime: 2025-01-14T19:17:28Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.1700383Z','2025-01-15 21:03:54.6495586Z','2025-01-15 21:03:54.6708403Z','00:00:00.0212817','','2','0'),('23127','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-14T19:48:08Z;
  lastStartTime: 2025-01-14T19:47:58Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.2530171Z','2025-01-15 21:03:54.6758878Z','2025-01-15 21:04:10.5792244Z','00:00:15.9033366','','2','0'),('23128','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-14T20:14:58Z;
  lastStartTime: 2025-01-14T20:14:58Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.2786289Z','2025-01-15 21:03:55.6312826Z','2025-01-15 21:03:55.6625744Z','00:00:00.0312918','','2','0'),('23129','ApplicationCheckUpdate','{
  sendUpdatesToClient: true;
  installMajorUpdate: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: ApplicationCheckUpdate;
  lastExecutionTime: 2025-01-14T19:17:30Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.3196057Z','2025-01-15 21:03:55.6705559Z','2025-01-15 21:03:55.8663257Z','00:00:00.1957698','','2','0'),('23130','Housekeeping','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: Housekeeping;
  lastExecutionTime: 2025-01-14T19:17:29Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:54.378518Z','2025-01-15 21:03:55.883481Z','2025-01-15 21:03:56.8996389Z','00:00:01.0161579','','2','0'),('23131','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:03:54.5684171Z','2025-01-15 21:03:54.60754Z','2025-01-15 21:03:54.6429452Z','00:00:00.0354052','','0','0'),('23132','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:03:54Z;
  lastStartTime: 2025-01-15T21:03:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:04:54.67689Z','2025-01-15 21:04:54.682165Z','2025-01-15 21:04:54.6995019Z','00:00:00.0173369','','2','0'),('23133','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:04:54.6974507Z','2025-01-15 21:04:54.6995991Z','2025-01-15 21:04:54.7051369Z','00:00:00.0055378','','0','0'),('23134','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:04:54Z;
  lastStartTime: 2025-01-15T21:04:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:06:24.6916828Z','2025-01-15 21:06:24.6975886Z','2025-01-15 21:06:24.7288605Z','00:00:00.0312719','','2','0'),('23135','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:06:24.7272142Z','2025-01-15 21:06:24.7289016Z','2025-01-15 21:06:24.7321555Z','00:00:00.0032539','','0','0'),('23136','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:06:24Z;
  lastStartTime: 2025-01-15T21:06:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:07:54.7071355Z','2025-01-15 21:07:54.7120137Z','2025-01-15 21:07:54.7276203Z','00:00:00.0156066','','2','0'),('23137','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:07:54.7257274Z','2025-01-15 21:07:54.727703Z','2025-01-15 21:07:54.7339196Z','00:00:00.0062166','','0','0'),('23138','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:03:54Z;
  lastStartTime: 2025-01-15T21:03:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:08:54.720467Z','2025-01-15 21:08:54.7274486Z','2025-01-15 21:08:54.7337436Z','00:00:00.0062950','','2','0'),('23139','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:07:54Z;
  lastStartTime: 2025-01-15T21:07:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:09:24.7311584Z','2025-01-15 21:09:24.7347212Z','2025-01-15 21:09:24.7582219Z','00:00:00.0235007','','2','0'),('23140','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:03:55Z;
  lastStartTime: 2025-01-15T21:03:55Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:09:24.7355894Z','2025-01-15 21:09:24.7412395Z','2025-01-15 21:09:24.7497166Z','00:00:00.0084771','','2','0'),('23141','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:09:24.7568255Z','2025-01-15 21:09:24.7582721Z','2025-01-15 21:09:24.7626685Z','00:00:00.0043964','','0','0'),('23142','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:09:24Z;
  lastStartTime: 2025-01-15T21:09:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:10:54.7460765Z','2025-01-15 21:10:54.7503648Z','2025-01-15 21:10:54.7650672Z','00:00:00.0147024','','2','0'),('23143','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:10:54.7631969Z','2025-01-15 21:10:54.7651073Z','2025-01-15 21:10:54.7719637Z','00:00:00.0068564','','0','0'),('23144','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:10:54Z;
  lastStartTime: 2025-01-15T21:10:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:12:24.7571512Z','2025-01-15 21:12:24.7621242Z','2025-01-15 21:12:24.7834242Z','00:00:00.0213000','','2','0'),('23145','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:12:24.7806282Z','2025-01-15 21:12:24.7834645Z','2025-01-15 21:12:24.7890357Z','00:00:00.0055712','','0','0'),('23146','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:08:54Z;
  lastStartTime: 2025-01-15T21:08:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:13:54.7696135Z','2025-01-15 21:13:54.7750959Z','2025-01-15 21:13:54.7834787Z','00:00:00.0083828','','2','0'),('23147','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:12:24Z;
  lastStartTime: 2025-01-15T21:12:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:13:54.7757601Z','2025-01-15 21:13:54.7789682Z','2025-01-15 21:13:54.8104365Z','00:00:00.0314683','','2','0'),('23148','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:13:54.8060302Z','2025-01-15 21:13:54.8105367Z','2025-01-15 21:13:54.8187775Z','00:00:00.0082408','','0','0'),('23149','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:09:24Z;
  lastStartTime: 2025-01-15T21:09:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:14:24.7824627Z','2025-01-15 21:14:24.7851942Z','2025-01-15 21:14:24.7903012Z','00:00:00.0051070','','2','0'),('23150','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:13:54Z;
  lastStartTime: 2025-01-15T21:13:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:15:24.7900878Z','2025-01-15 21:15:24.7947331Z','2025-01-15 21:15:24.8140486Z','00:00:00.0193155','','2','0'),('23151','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:15:24.8120832Z','2025-01-15 21:15:24.8140871Z','2025-01-15 21:15:24.8246977Z','00:00:00.0106106','','0','0'),('23152','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:15:24Z;
  lastStartTime: 2025-01-15T21:15:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:16:54.8029222Z','2025-01-15 21:16:54.8099444Z','2025-01-15 21:16:54.8327912Z','00:00:00.0228468','','2','0'),('23153','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:16:54.8313948Z','2025-01-15 21:16:54.8328099Z','2025-01-15 21:16:54.8427969Z','00:00:00.0099870','','0','0'),('23154','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:16:54Z;
  lastStartTime: 2025-01-15T21:16:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:18:24.8230057Z','2025-01-15 21:18:24.8400551Z','2025-01-15 21:18:24.8602696Z','00:00:00.0202145','','2','0'),('23155','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:18:24.8584393Z','2025-01-15 21:18:24.8603245Z','2025-01-15 21:18:24.8653458Z','00:00:00.0050213','','0','0'),('23156','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:13:54Z;
  lastStartTime: 2025-01-15T21:13:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:18:54.8425406Z','2025-01-15 21:18:54.8452737Z','2025-01-15 21:18:54.8483737Z','00:00:00.0031000','','2','0'),('23157','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:14:24Z;
  lastStartTime: 2025-01-15T21:14:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:19:24.8488154Z','2025-01-15 21:19:24.8531988Z','2025-01-15 21:19:24.8592098Z','00:00:00.0060110','','2','0'),('23158','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:18:24Z;
  lastStartTime: 2025-01-15T21:18:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:19:54.8626766Z','2025-01-15 21:19:54.8648747Z','2025-01-15 21:19:54.88068Z','00:00:00.0158053','','2','0'),('23159','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:19:54.8796765Z','2025-01-15 21:19:54.8807004Z','2025-01-15 21:19:54.8836627Z','00:00:00.0029623','','0','0'),('23160','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:19:54Z;
  lastStartTime: 2025-01-15T21:19:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:20:54.9032725Z','2025-01-15 21:20:54.9111501Z','2025-01-15 21:20:54.924431Z','00:00:00.0132809','','2','0'),('23161','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:20:54.9227813Z','2025-01-15 21:20:54.9244419Z','2025-01-15 21:20:54.9278105Z','00:00:00.0033686','','0','0'),('23162','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:20:54Z;
  lastStartTime: 2025-01-15T21:20:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:22:24.9209457Z','2025-01-15 21:22:24.9260116Z','2025-01-15 21:22:24.9502179Z','00:00:00.0242063','','2','0'),('23163','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:22:24.9485772Z','2025-01-15 21:22:24.9502555Z','2025-01-15 21:22:24.9608055Z','00:00:00.0105500','','0','0'),('23164','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:18:54Z;
  lastStartTime: 2025-01-15T21:18:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:23:54.9289207Z','2025-01-15 21:23:54.9323082Z','2025-01-15 21:23:54.9404289Z','00:00:00.0081207','','2','0'),('23165','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:22:24Z;
  lastStartTime: 2025-01-15T21:22:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:23:54.9328403Z','2025-01-15 21:23:54.9376634Z','2025-01-15 21:23:54.9550112Z','00:00:00.0173478','','2','0'),('23166','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:23:54.953015Z','2025-01-15 21:23:54.9550579Z','2025-01-15 21:23:54.9625056Z','00:00:00.0074477','','0','0'),('23167','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:19:24Z;
  lastStartTime: 2025-01-15T21:19:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:24:24.9383518Z','2025-01-15 21:24:24.9438875Z','2025-01-15 21:24:24.9493249Z','00:00:00.0054374','','2','0'),('23168','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:23:54Z;
  lastStartTime: 2025-01-15T21:23:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:25:24.9511597Z','2025-01-15 21:25:24.958566Z','2025-01-15 21:25:24.9814053Z','00:00:00.0228393','','2','0'),('23169','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:25:24.9795699Z','2025-01-15 21:25:24.9814384Z','2025-01-15 21:25:24.9873399Z','00:00:00.0059015','','0','0'),('23170','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:25:24Z;
  lastStartTime: 2025-01-15T21:25:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:26:54.9632615Z','2025-01-15 21:26:54.9676801Z','2025-01-15 21:26:54.9878492Z','00:00:00.0201691','','2','0'),('23171','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:26:54.9863335Z','2025-01-15 21:26:54.9879004Z','2025-01-15 21:26:54.992682Z','00:00:00.0047816','','0','0'),('23172','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:26:54Z;
  lastStartTime: 2025-01-15T21:26:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:28:24.970858Z','2025-01-15 21:28:24.9738439Z','2025-01-15 21:28:25.0127882Z','00:00:00.0389443','','2','0'),('23173','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:28:25.0098662Z','2025-01-15 21:28:25.0129197Z','2025-01-15 21:28:25.0166477Z','00:00:00.0037280','','0','0'),('23174','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:23:54Z;
  lastStartTime: 2025-01-15T21:23:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:28:54.9772662Z','2025-01-15 21:28:54.9802943Z','2025-01-15 21:28:54.9846874Z','00:00:00.0043931','','2','0'),('23175','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:24:24Z;
  lastStartTime: 2025-01-15T21:24:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:29:24.9853629Z','2025-01-15 21:29:24.9889429Z','2025-01-15 21:29:24.9940163Z','00:00:00.0050734','','2','0'),('23176','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:28:25Z;
  lastStartTime: 2025-01-15T21:28:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:29:54.9913045Z','2025-01-15 21:29:54.995728Z','2025-01-15 21:29:55.0223781Z','00:00:00.0266501','','2','0'),('23177','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:29:55.020583Z','2025-01-15 21:29:55.0223979Z','2025-01-15 21:29:55.0272677Z','00:00:00.0048698','','0','0'),('23178','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:29:55Z;
  lastStartTime: 2025-01-15T21:29:54Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:31:25.0115227Z','2025-01-15 21:31:25.0161458Z','2025-01-15 21:31:25.0291913Z','00:00:00.0130455','','2','0'),('23179','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:31:25.0261403Z','2025-01-15 21:31:25.0292301Z','2025-01-15 21:31:25.0331187Z','00:00:00.0038886','','0','0'),('23180','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:31:25Z;
  lastStartTime: 2025-01-15T21:31:25Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:32:55.026012Z','2025-01-15 21:32:55.0314139Z','2025-01-15 21:32:55.0463032Z','00:00:00.0148893','','2','0'),('23181','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:32:55.0448745Z','2025-01-15 21:32:55.04634Z','2025-01-15 21:32:55.0545949Z','00:00:00.0082549','','0','0'),('23182','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:28:54Z;
  lastStartTime: 2025-01-15T21:28:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:33:55.0386712Z','2025-01-15 21:33:55.042449Z','2025-01-15 21:33:55.0451916Z','00:00:00.0027426','','2','0'),('23183','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:32:55Z;
  lastStartTime: 2025-01-15T21:32:55Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:34:25.0434837Z','2025-01-15 21:34:25.0453391Z','2025-01-15 21:34:25.0638297Z','00:00:00.0184906','','2','0'),('23184','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-15T21:04:10Z;
  lastStartTime: 2025-01-15T21:03:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:25.0457485Z','2025-01-15 21:34:25.0501324Z','2025-01-15 21:34:41.4844356Z','00:00:16.4343032','','2','0'),('23185','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:29:24Z;
  lastStartTime: 2025-01-15T21:29:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:25.0500269Z','2025-01-15 21:34:25.0546347Z','2025-01-15 21:34:25.0569412Z','00:00:00.0023065','','2','0'),('23186','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:34:25.0569937Z','2025-01-15 21:34:25.0732605Z','2025-01-15 21:34:25.0816606Z','00:00:00.0084001','','0','0'),('23187','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:34:25Z;
  lastStartTime: 2025-01-15T21:34:25Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:35:55.0619176Z','2025-01-15 21:35:55.0660436Z','2025-01-15 21:35:55.0839157Z','00:00:00.0178721','','2','0'),('23188','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:35:55.0825596Z','2025-01-15 21:35:55.0839407Z','2025-01-15 21:35:55.0896842Z','00:00:00.0057435','','0','0'),('23189','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:35:55Z;
  lastStartTime: 2025-01-15T21:35:55Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:37:25.0761585Z','2025-01-15 21:37:25.0807191Z','2025-01-15 21:37:25.0926347Z','00:00:00.0119156','','2','0'),('23190','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:37:25.0914362Z','2025-01-15 21:37:25.0926684Z','2025-01-15 21:37:25.09747Z','00:00:00.0048016','','0','0'),('23191','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:33:55Z;
  lastStartTime: 2025-01-15T21:33:55Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:38:55.0886013Z','2025-01-15 21:38:55.0962278Z','2025-01-15 21:38:55.1072453Z','00:00:00.0110175','','2','0'),('23192','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:37:25Z;
  lastStartTime: 2025-01-15T21:37:25Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:38:55.0966822Z','2025-01-15 21:38:55.099317Z','2025-01-15 21:38:55.1125537Z','00:00:00.0132367','','2','0'),('23193','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:38:55.1106539Z','2025-01-15 21:38:55.112645Z','2025-01-15 21:38:55.1174417Z','00:00:00.0047967','','0','0'),('23194','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:34:25Z;
  lastStartTime: 2025-01-15T21:34:25Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:39:25.1171337Z','2025-01-15 21:39:25.1202297Z','2025-01-15 21:39:25.1236722Z','00:00:00.0034425','','2','0'),('23195','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:38:55Z;
  lastStartTime: 2025-01-15T21:38:55Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:39:55.1268216Z','2025-01-15 21:39:55.1303115Z','2025-01-15 21:39:55.1445161Z','00:00:00.0142046','','2','0'),('23196','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:39:55.1425965Z','2025-01-15 21:39:55.1445645Z','2025-01-15 21:39:55.154175Z','00:00:00.0096105','','0','0'),('23197','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:39:55Z;
  lastStartTime: 2025-01-15T21:39:55Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:41:25.1422882Z','2025-01-15 21:41:25.1460191Z','2025-01-15 21:41:25.166151Z','00:00:00.0201319','','2','0'),('23198','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:41:25.163298Z','2025-01-15 21:41:25.1661911Z','2025-01-15 21:41:25.1699178Z','00:00:00.0037267','','0','0'),('23199','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:41:25Z;
  lastStartTime: 2025-01-15T21:41:25Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:42:55.1510158Z','2025-01-15 21:42:55.1550446Z','2025-01-15 21:42:55.1701235Z','00:00:00.0150789','','2','0'),('23200','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:42:55.1676524Z','2025-01-15 21:42:55.170158Z','2025-01-15 21:42:55.1726977Z','00:00:00.0025397','','0','0'),('23201','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:38:55Z;
  lastStartTime: 2025-01-15T21:38:55Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:43:55.1609377Z','2025-01-15 21:43:55.1644268Z','2025-01-15 21:43:55.1680809Z','00:00:00.0036541','','2','0'),('23202','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:42:55Z;
  lastStartTime: 2025-01-15T21:42:55Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:44:25.1671897Z','2025-01-15 21:44:25.169703Z','2025-01-15 21:44:25.1864232Z','00:00:00.0167202','','2','0'),('23203','ImportListSync','{
  sendUpdatesToClient: true;
  isTypeExclusive: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:39:25Z;
  lastStartTime: 2025-01-15T21:39:25Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:44:25.1702956Z','2025-01-15 21:44:25.1751925Z','2025-01-15 21:44:25.1799457Z','00:00:00.0047532','','2','0'),('23204','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:44:25.1847423Z','2025-01-15 21:44:25.1864682Z','2025-01-15 21:44:25.2000117Z','00:00:00.0135435','','0','0'),('23205','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:44:25Z;
  lastStartTime: 2025-01-15T21:44:25Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:45:55.1880196Z','2025-01-15 21:45:55.1932026Z','2025-01-15 21:45:55.2101632Z','00:00:00.0169606','','2','0'),('23206','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  isTypeExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:45:55.2088728Z','2025-01-15 21:45:55.2101948Z','2025-01-15 21:45:55.2146365Z','00:00:00.0044417','','0','0');