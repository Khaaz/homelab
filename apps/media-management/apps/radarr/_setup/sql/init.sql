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


DELETE FROM QualityProfiles; 

INSERT INTO QualityProfiles VALUES(4,'Multi VO',1002,replace('[\n  {\n    "quality": 0,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 24,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 25,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 26,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 27,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 29,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 28,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 1,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 2,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 23,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1000,\n    "name": "WEB 480p",\n    "items": [\n      {\n        "quality": 8,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 12,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 20,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 21,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 4,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1001,\n    "name": "WEB 720p",\n    "items": [\n      {\n        "quality": 5,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 14,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 9,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 30,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 16,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1003,\n    "name": "WEB 2160p",\n    "items": [\n      {\n        "quality": 18,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 17,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 19,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 31,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 22,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 10,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 6,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1002,\n    "name": "Blueray / WEB 1080p",\n    "items": [\n      {\n        "quality": 3,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 15,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 7,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  }\n]','\n',char(10)),-2,replace('[\n  {\n    "format": 117,\n    "score": 0\n  },\n  {\n    "format": 116,\n    "score": 0\n  },\n  {\n    "format": 115,\n    "score": 0\n  },\n  {\n    "format": 114,\n    "score": 0\n  },\n  {\n    "format": 113,\n    "score": 0\n  },\n  {\n    "format": 112,\n    "score": 0\n  },\n  {\n    "format": 111,\n    "score": 0\n  },\n  {\n    "format": 110,\n    "score": 0\n  },\n  {\n    "format": 109,\n    "score": 0\n  },\n  {\n    "format": 108,\n    "score": 0\n  },\n  {\n    "format": 107,\n    "score": 0\n  },\n  {\n    "format": 106,\n    "score": 0\n  },\n  {\n    "format": 105,\n    "score": 0\n  },\n  {\n    "format": 104,\n    "score": 0\n  },\n  {\n    "format": 103,\n    "score": 0\n  },\n  {\n    "format": 102,\n    "score": 0\n  },\n  {\n    "format": 101,\n    "score": 0\n  },\n  {\n    "format": 100,\n    "score": 0\n  },\n  {\n    "format": 99,\n    "score": 0\n  },\n  {\n    "format": 98,\n    "score": 0\n  },\n  {\n    "format": 97,\n    "score": 0\n  },\n  {\n    "format": 96,\n    "score": 0\n  },\n  {\n    "format": 95,\n    "score": 0\n  },\n  {\n    "format": 94,\n    "score": 0\n  },\n  {\n    "format": 93,\n    "score": 0\n  },\n  {\n    "format": 92,\n    "score": 0\n  },\n  {\n    "format": 91,\n    "score": 0\n  },\n  {\n    "format": 90,\n    "score": 0\n  },\n  {\n    "format": 89,\n    "score": 0\n  },\n  {\n    "format": 88,\n    "score": 0\n  },\n  {\n    "format": 87,\n    "score": 0\n  },\n  {\n    "format": 86,\n    "score": 0\n  },\n  {\n    "format": 85,\n    "score": 0\n  },\n  {\n    "format": 84,\n    "score": 0\n  },\n  {\n    "format": 83,\n    "score": 0\n  },\n  {\n    "format": 82,\n    "score": 0\n  },\n  {\n    "format": 81,\n    "score": 0\n  },\n  {\n    "format": 80,\n    "score": 0\n  },\n  {\n    "format": 79,\n    "score": 0\n  },\n  {\n    "format": 78,\n    "score": 0\n  },\n  {\n    "format": 77,\n    "score": 0\n  },\n  {\n    "format": 76,\n    "score": 0\n  },\n  {\n    "format": 75,\n    "score": 0\n  },\n  {\n    "format": 74,\n    "score": 0\n  },\n  {\n    "format": 73,\n    "score": 0\n  },\n  {\n    "format": 72,\n    "score": 0\n  },\n  {\n    "format": 71,\n    "score": 0\n  },\n  {\n    "format": 70,\n    "score": 0\n  },\n  {\n    "format": 69,\n    "score": 0\n  },\n  {\n    "format": 68,\n    "score": 0\n  },\n  {\n    "format": 67,\n    "score": 0\n  },\n  {\n    "format": 66,\n    "score": 0\n  },\n  {\n    "format": 65,\n    "score": 0\n  },\n  {\n    "format": 64,\n    "score": 0\n  },\n  {\n    "format": 63,\n    "score": 0\n  },\n  {\n    "format": 62,\n    "score": 0\n  },\n  {\n    "format": 61,\n    "score": 0\n  },\n  {\n    "format": 60,\n    "score": 1650\n  },\n  {\n    "format": 59,\n    "score": 1700\n  },\n  {\n    "format": 58,\n    "score": 0\n  },\n  {\n    "format": 57,\n    "score": 0\n  },\n  {\n    "format": 56,\n    "score": 800\n  },\n  {\n    "format": 55,\n    "score": 800\n  },\n  {\n    "format": 54,\n    "score": 125\n  },\n  {\n    "format": 53,\n    "score": 25\n  },\n  {\n    "format": 52,\n    "score": 25\n  },\n  {\n    "format": 51,\n    "score": 25\n  },\n  {\n    "format": 50,\n    "score": 25\n  },\n  {\n    "format": 49,\n    "score": 25\n  },\n  {\n    "format": 48,\n    "score": 0\n  },\n  {\n    "format": 47,\n    "score": -10000\n  },\n  {\n    "format": 46,\n    "score": -10000\n  },\n  {\n    "format": 45,\n    "score": -10000\n  },\n  {\n    "format": 44,\n    "score": -10000\n  },\n  {\n    "format": 43,\n    "score": -10000\n  },\n  {\n    "format": 42,\n    "score": -10000\n  },\n  {\n    "format": 41,\n    "score": 0\n  },\n  {\n    "format": 40,\n    "score": 0\n  },\n  {\n    "format": 39,\n    "score": 0\n  },\n  {\n    "format": 38,\n    "score": 0\n  },\n  {\n    "format": 37,\n    "score": 20\n  },\n  {\n    "format": 36,\n    "score": 0\n  },\n  {\n    "format": 35,\n    "score": 0\n  },\n  {\n    "format": 34,\n    "score": 0\n  },\n  {\n    "format": 33,\n    "score": 0\n  },\n  {\n    "format": 32,\n    "score": 0\n  },\n  {\n    "format": 31,\n    "score": 0\n  },\n  {\n    "format": 30,\n    "score": 20\n  },\n  {\n    "format": 29,\n    "score": 15\n  },\n  {\n    "format": 28,\n    "score": 0\n  },\n  {\n    "format": 27,\n    "score": 0\n  },\n  {\n    "format": 26,\n    "score": -10000\n  },\n  {\n    "format": 25,\n    "score": -10000\n  },\n  {\n    "format": 24,\n    "score": -10000\n  },\n  {\n    "format": 23,\n    "score": -10000\n  },\n  {\n    "format": 22,\n    "score": -10000\n  },\n  {\n    "format": 21,\n    "score": -10000\n  },\n  {\n    "format": 20,\n    "score": -10000\n  },\n  {\n    "format": 19,\n    "score": -10000\n  },\n  {\n    "format": 18,\n    "score": 7\n  },\n  {\n    "format": 17,\n    "score": 6\n  },\n  {\n    "format": 16,\n    "score": 5\n  },\n  {\n    "format": 15,\n    "score": 1600\n  },\n  {\n    "format": 14,\n    "score": 1650\n  },\n  {\n    "format": 13,\n    "score": 1700\n  },\n  {\n    "format": 12,\n    "score": 1850\n  },\n  {\n    "format": 11,\n    "score": 1900\n  },\n  {\n    "format": 10,\n    "score": 1950\n  },\n  {\n    "format": 9,\n    "score": 1500\n  },\n  {\n    "format": 8,\n    "score": 1900\n  },\n  {\n    "format": 7,\n    "score": 1950\n  },\n  {\n    "format": 6,\n    "score": 0\n  },\n  {\n    "format": 5,\n    "score": 0\n  },\n  {\n    "format": 4,\n    "score": 0\n  },\n  {\n    "format": 3,\n    "score": -10000\n  },\n  {\n    "format": 2,\n    "score": 500\n  }\n]','\n',char(10)),1,0,10000,1);
INSERT INTO QualityProfiles VALUES(5,'Multi VF',1002,replace('[\n  {\n    "quality": 0,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 24,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 25,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 26,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 27,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 29,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 28,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 1,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 2,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 23,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1000,\n    "name": "WEB 480p",\n    "items": [\n      {\n        "quality": 8,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 12,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 20,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 21,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 4,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1001,\n    "name": "WEB 720p",\n    "items": [\n      {\n        "quality": 5,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 14,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 9,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 30,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 16,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1003,\n    "name": "WEB 2160p",\n    "items": [\n      {\n        "quality": 18,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 17,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 19,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 31,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 22,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 10,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 6,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1002,\n    "name": "Blueray / WEB 1080p",\n    "items": [\n      {\n        "quality": 3,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 15,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 7,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  }\n]','\n',char(10)),2,replace('[\n  {\n    "format": 117,\n    "score": 0\n  },\n  {\n    "format": 116,\n    "score": 0\n  },\n  {\n    "format": 115,\n    "score": 0\n  },\n  {\n    "format": 114,\n    "score": 0\n  },\n  {\n    "format": 113,\n    "score": 0\n  },\n  {\n    "format": 112,\n    "score": 0\n  },\n  {\n    "format": 111,\n    "score": 0\n  },\n  {\n    "format": 110,\n    "score": 0\n  },\n  {\n    "format": 109,\n    "score": 0\n  },\n  {\n    "format": 108,\n    "score": 0\n  },\n  {\n    "format": 107,\n    "score": 0\n  },\n  {\n    "format": 106,\n    "score": 0\n  },\n  {\n    "format": 105,\n    "score": 0\n  },\n  {\n    "format": 104,\n    "score": 0\n  },\n  {\n    "format": 103,\n    "score": 0\n  },\n  {\n    "format": 102,\n    "score": 0\n  },\n  {\n    "format": 101,\n    "score": 0\n  },\n  {\n    "format": 100,\n    "score": 0\n  },\n  {\n    "format": 99,\n    "score": 0\n  },\n  {\n    "format": 98,\n    "score": 0\n  },\n  {\n    "format": 97,\n    "score": 0\n  },\n  {\n    "format": 96,\n    "score": 0\n  },\n  {\n    "format": 95,\n    "score": 0\n  },\n  {\n    "format": 94,\n    "score": 0\n  },\n  {\n    "format": 93,\n    "score": 0\n  },\n  {\n    "format": 92,\n    "score": 0\n  },\n  {\n    "format": 91,\n    "score": 0\n  },\n  {\n    "format": 90,\n    "score": 0\n  },\n  {\n    "format": 89,\n    "score": 0\n  },\n  {\n    "format": 88,\n    "score": 0\n  },\n  {\n    "format": 87,\n    "score": 0\n  },\n  {\n    "format": 86,\n    "score": 0\n  },\n  {\n    "format": 85,\n    "score": 0\n  },\n  {\n    "format": 84,\n    "score": 0\n  },\n  {\n    "format": 83,\n    "score": 0\n  },\n  {\n    "format": 82,\n    "score": 0\n  },\n  {\n    "format": 81,\n    "score": 0\n  },\n  {\n    "format": 80,\n    "score": 0\n  },\n  {\n    "format": 79,\n    "score": 0\n  },\n  {\n    "format": 78,\n    "score": 0\n  },\n  {\n    "format": 77,\n    "score": 0\n  },\n  {\n    "format": 76,\n    "score": 0\n  },\n  {\n    "format": 75,\n    "score": 0\n  },\n  {\n    "format": 74,\n    "score": 0\n  },\n  {\n    "format": 73,\n    "score": 0\n  },\n  {\n    "format": 72,\n    "score": 0\n  },\n  {\n    "format": 71,\n    "score": 0\n  },\n  {\n    "format": 70,\n    "score": 0\n  },\n  {\n    "format": 69,\n    "score": 0\n  },\n  {\n    "format": 68,\n    "score": 0\n  },\n  {\n    "format": 67,\n    "score": 0\n  },\n  {\n    "format": 66,\n    "score": 0\n  },\n  {\n    "format": 65,\n    "score": 0\n  },\n  {\n    "format": 64,\n    "score": 0\n  },\n  {\n    "format": 63,\n    "score": 0\n  },\n  {\n    "format": 62,\n    "score": 0\n  },\n  {\n    "format": 61,\n    "score": 0\n  },\n  {\n    "format": 60,\n    "score": 1650\n  },\n  {\n    "format": 59,\n    "score": 1700\n  },\n  {\n    "format": 58,\n    "score": 0\n  },\n  {\n    "format": 57,\n    "score": 0\n  },\n  {\n    "format": 56,\n    "score": 800\n  },\n  {\n    "format": 55,\n    "score": 800\n  },\n  {\n    "format": 54,\n    "score": 125\n  },\n  {\n    "format": 53,\n    "score": 25\n  },\n  {\n    "format": 52,\n    "score": 25\n  },\n  {\n    "format": 51,\n    "score": 25\n  },\n  {\n    "format": 50,\n    "score": 25\n  },\n  {\n    "format": 49,\n    "score": 25\n  },\n  {\n    "format": 48,\n    "score": 0\n  },\n  {\n    "format": 47,\n    "score": -10000\n  },\n  {\n    "format": 46,\n    "score": -10000\n  },\n  {\n    "format": 45,\n    "score": -10000\n  },\n  {\n    "format": 44,\n    "score": -10000\n  },\n  {\n    "format": 43,\n    "score": -10000\n  },\n  {\n    "format": 42,\n    "score": -10000\n  },\n  {\n    "format": 41,\n    "score": 0\n  },\n  {\n    "format": 40,\n    "score": 0\n  },\n  {\n    "format": 39,\n    "score": 0\n  },\n  {\n    "format": 38,\n    "score": 0\n  },\n  {\n    "format": 37,\n    "score": 20\n  },\n  {\n    "format": 36,\n    "score": 0\n  },\n  {\n    "format": 35,\n    "score": 0\n  },\n  {\n    "format": 34,\n    "score": 0\n  },\n  {\n    "format": 33,\n    "score": 0\n  },\n  {\n    "format": 32,\n    "score": 0\n  },\n  {\n    "format": 31,\n    "score": 0\n  },\n  {\n    "format": 30,\n    "score": 20\n  },\n  {\n    "format": 29,\n    "score": 15\n  },\n  {\n    "format": 28,\n    "score": 0\n  },\n  {\n    "format": 27,\n    "score": 0\n  },\n  {\n    "format": 26,\n    "score": -10000\n  },\n  {\n    "format": 25,\n    "score": -10000\n  },\n  {\n    "format": 24,\n    "score": -10000\n  },\n  {\n    "format": 23,\n    "score": -10000\n  },\n  {\n    "format": 22,\n    "score": -10000\n  },\n  {\n    "format": 21,\n    "score": -10000\n  },\n  {\n    "format": 20,\n    "score": -10000\n  },\n  {\n    "format": 19,\n    "score": -10000\n  },\n  {\n    "format": 18,\n    "score": 7\n  },\n  {\n    "format": 17,\n    "score": 6\n  },\n  {\n    "format": 16,\n    "score": 5\n  },\n  {\n    "format": 15,\n    "score": 1600\n  },\n  {\n    "format": 14,\n    "score": 1650\n  },\n  {\n    "format": 13,\n    "score": 1700\n  },\n  {\n    "format": 12,\n    "score": 1850\n  },\n  {\n    "format": 11,\n    "score": 1900\n  },\n  {\n    "format": 10,\n    "score": 1950\n  },\n  {\n    "format": 9,\n    "score": 1500\n  },\n  {\n    "format": 8,\n    "score": 1900\n  },\n  {\n    "format": 7,\n    "score": 1950\n  },\n  {\n    "format": 6,\n    "score": 0\n  },\n  {\n    "format": 5,\n    "score": 0\n  },\n  {\n    "format": 4,\n    "score": -10000\n  },\n  {\n    "format": 3,\n    "score": 0\n  },\n  {\n    "format": 2,\n    "score": 500\n  }\n]','\n',char(10)),1,0,10000,1);
INSERT INTO QualityProfiles VALUES(9,'Anime',1004,replace('[\n  {\n    "quality": 0,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 24,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 25,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 26,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 27,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 29,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 28,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 23,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 20,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 16,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1003,\n    "name": "WEB 2160p",\n    "items": [\n      {\n        "quality": 18,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 17,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 19,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 31,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 22,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 10,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 1,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "quality": 2,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1000,\n    "name": "WEB 480p",\n    "items": [\n      {\n        "quality": 8,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 12,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  },\n  {\n    "quality": 21,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1001,\n    "name": "WEB 720p",\n    "items": [\n      {\n        "quality": 5,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 14,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 4,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  },\n  {\n    "quality": 6,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1002,\n    "name": "WEB 1080p",\n    "items": [\n      {\n        "quality": 3,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 15,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 9,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  },\n  {\n    "id": 1004,\n    "name": "Remux-1080p",\n    "items": [\n      {\n        "quality": 30,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 7,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  }\n]','\n',char(10)),-2,replace('[\n  {\n    "format": 117,\n    "score": -10000\n  },\n  {\n    "format": 116,\n    "score": 0\n  },\n  {\n    "format": 115,\n    "score": 0\n  },\n  {\n    "format": 114,\n    "score": 10\n  },\n  {\n    "format": 113,\n    "score": 4\n  },\n  {\n    "format": 112,\n    "score": 3\n  },\n  {\n    "format": 111,\n    "score": 2\n  },\n  {\n    "format": 110,\n    "score": 1\n  },\n  {\n    "format": 109,\n    "score": -51\n  },\n  {\n    "format": 108,\n    "score": 0\n  },\n  {\n    "format": 107,\n    "score": -10000\n  },\n  {\n    "format": 106,\n    "score": -10000\n  },\n  {\n    "format": 105,\n    "score": 100\n  },\n  {\n    "format": 104,\n    "score": 200\n  },\n  {\n    "format": 103,\n    "score": 300\n  },\n  {\n    "format": 102,\n    "score": 400\n  },\n  {\n    "format": 101,\n    "score": 500\n  },\n  {\n    "format": 100,\n    "score": 600\n  },\n  {\n    "format": 99,\n    "score": 700\n  },\n  {\n    "format": 98,\n    "score": 800\n  },\n  {\n    "format": 97,\n    "score": 900\n  },\n  {\n    "format": 96,\n    "score": 1000\n  },\n  {\n    "format": 95,\n    "score": 1100\n  },\n  {\n    "format": 94,\n    "score": 1200\n  },\n  {\n    "format": 93,\n    "score": 1300\n  },\n  {\n    "format": 92,\n    "score": 1400\n  },\n  {\n    "format": 2,\n    "score": 0\n  },\n  {\n    "format": 3,\n    "score": 0\n  },\n  {\n    "format": 4,\n    "score": 0\n  },\n  {\n    "format": 5,\n    "score": 1000\n  },\n  {\n    "format": 6,\n    "score": 0\n  },\n  {\n    "format": 7,\n    "score": 0\n  },\n  {\n    "format": 8,\n    "score": 0\n  },\n  {\n    "format": 9,\n    "score": 0\n  },\n  {\n    "format": 10,\n    "score": 1050\n  },\n  {\n    "format": 11,\n    "score": 1000\n  },\n  {\n    "format": 12,\n    "score": 950\n  },\n  {\n    "format": 13,\n    "score": 350\n  },\n  {\n    "format": 14,\n    "score": 250\n  },\n  {\n    "format": 15,\n    "score": 150\n  },\n  {\n    "format": 16,\n    "score": 0\n  },\n  {\n    "format": 17,\n    "score": 0\n  },\n  {\n    "format": 18,\n    "score": 0\n  },\n  {\n    "format": 19,\n    "score": 0\n  },\n  {\n    "format": 20,\n    "score": 0\n  },\n  {\n    "format": 21,\n    "score": 0\n  },\n  {\n    "format": 22,\n    "score": 0\n  },\n  {\n    "format": 23,\n    "score": 0\n  },\n  {\n    "format": 24,\n    "score": 0\n  },\n  {\n    "format": 25,\n    "score": 0\n  },\n  {\n    "format": 26,\n    "score": -10000\n  },\n  {\n    "format": 27,\n    "score": 0\n  },\n  {\n    "format": 28,\n    "score": 0\n  },\n  {\n    "format": 29,\n    "score": 0\n  },\n  {\n    "format": 30,\n    "score": 0\n  },\n  {\n    "format": 31,\n    "score": 0\n  },\n  {\n    "format": 32,\n    "score": 0\n  },\n  {\n    "format": 33,\n    "score": 0\n  },\n  {\n    "format": 34,\n    "score": 0\n  },\n  {\n    "format": 35,\n    "score": 0\n  },\n  {\n    "format": 36,\n    "score": 0\n  },\n  {\n    "format": 37,\n    "score": 0\n  },\n  {\n    "format": 38,\n    "score": 0\n  },\n  {\n    "format": 39,\n    "score": 0\n  },\n  {\n    "format": 40,\n    "score": 0\n  },\n  {\n    "format": 41,\n    "score": 0\n  },\n  {\n    "format": 42,\n    "score": 0\n  },\n  {\n    "format": 43,\n    "score": 0\n  },\n  {\n    "format": 44,\n    "score": 0\n  },\n  {\n    "format": 45,\n    "score": 0\n  },\n  {\n    "format": 46,\n    "score": 0\n  },\n  {\n    "format": 47,\n    "score": 0\n  },\n  {\n    "format": 48,\n    "score": 0\n  },\n  {\n    "format": 49,\n    "score": 0\n  },\n  {\n    "format": 50,\n    "score": 0\n  },\n  {\n    "format": 51,\n    "score": 0\n  },\n  {\n    "format": 52,\n    "score": 0\n  },\n  {\n    "format": 53,\n    "score": 0\n  },\n  {\n    "format": 54,\n    "score": 0\n  },\n  {\n    "format": 55,\n    "score": 0\n  },\n  {\n    "format": 56,\n    "score": 0\n  },\n  {\n    "format": 57,\n    "score": 0\n  },\n  {\n    "format": 58,\n    "score": 0\n  },\n  {\n    "format": 59,\n    "score": 0\n  },\n  {\n    "format": 60,\n    "score": 0\n  },\n  {\n    "format": 61,\n    "score": 0\n  },\n  {\n    "format": 62,\n    "score": 0\n  },\n  {\n    "format": 63,\n    "score": 0\n  },\n  {\n    "format": 64,\n    "score": 0\n  },\n  {\n    "format": 65,\n    "score": 0\n  },\n  {\n    "format": 66,\n    "score": 0\n  },\n  {\n    "format": 67,\n    "score": 0\n  },\n  {\n    "format": 68,\n    "score": 0\n  },\n  {\n    "format": 69,\n    "score": 0\n  },\n  {\n    "format": 70,\n    "score": 0\n  },\n  {\n    "format": 71,\n    "score": 0\n  },\n  {\n    "format": 72,\n    "score": 0\n  },\n  {\n    "format": 73,\n    "score": 0\n  },\n  {\n    "format": 74,\n    "score": 0\n  },\n  {\n    "format": 75,\n    "score": 0\n  },\n  {\n    "format": 76,\n    "score": 0\n  },\n  {\n    "format": 77,\n    "score": 0\n  },\n  {\n    "format": 78,\n    "score": 0\n  },\n  {\n    "format": 79,\n    "score": 0\n  },\n  {\n    "format": 80,\n    "score": 0\n  },\n  {\n    "format": 81,\n    "score": 0\n  },\n  {\n    "format": 82,\n    "score": 0\n  },\n  {\n    "format": 83,\n    "score": 0\n  },\n  {\n    "format": 84,\n    "score": 0\n  },\n  {\n    "format": 85,\n    "score": 0\n  },\n  {\n    "format": 86,\n    "score": 0\n  },\n  {\n    "format": 87,\n    "score": 0\n  },\n  {\n    "format": 88,\n    "score": 0\n  },\n  {\n    "format": 89,\n    "score": 0\n  },\n  {\n    "format": 90,\n    "score": 0\n  },\n  {\n    "format": 91,\n    "score": 0\n  }\n]','\n',char(10)),1,100,10000,1);
INSERT INTO QualityProfiles VALUES(13,'No filter VF',30,replace('[\n  {\n    "quality": 0,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 24,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 25,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 26,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 27,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 29,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 28,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 1,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 2,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 23,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1000,\n    "name": "WEB 480p",\n    "items": [\n      {\n        "quality": 8,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 12,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 20,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 21,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 4,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1001,\n    "name": "WEB 720p",\n    "items": [\n      {\n        "quality": 5,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 14,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 6,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 9,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1002,\n    "name": "WEB 1080p",\n    "items": [\n      {\n        "quality": 3,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 15,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  },\n  {\n    "quality": 7,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "quality": 30,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "quality": 16,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1003,\n    "name": "WEB 2160p",\n    "items": [\n      {\n        "quality": 18,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 17,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 19,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 31,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 22,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 10,\n    "items": [],\n    "allowed": false\n  }\n]','\n',char(10)),2,replace('[\n  {\n    "format": 2,\n    "score": 0\n  },\n  {\n    "format": 3,\n    "score": 0\n  },\n  {\n    "format": 4,\n    "score": 0\n  },\n  {\n    "format": 5,\n    "score": 0\n  },\n  {\n    "format": 6,\n    "score": 0\n  },\n  {\n    "format": 7,\n    "score": 0\n  },\n  {\n    "format": 8,\n    "score": 0\n  },\n  {\n    "format": 9,\n    "score": 0\n  },\n  {\n    "format": 10,\n    "score": 0\n  },\n  {\n    "format": 11,\n    "score": 0\n  },\n  {\n    "format": 12,\n    "score": 0\n  },\n  {\n    "format": 13,\n    "score": 0\n  },\n  {\n    "format": 14,\n    "score": 0\n  },\n  {\n    "format": 15,\n    "score": 0\n  },\n  {\n    "format": 16,\n    "score": 0\n  },\n  {\n    "format": 17,\n    "score": 0\n  },\n  {\n    "format": 18,\n    "score": 0\n  },\n  {\n    "format": 19,\n    "score": 0\n  },\n  {\n    "format": 20,\n    "score": 0\n  },\n  {\n    "format": 21,\n    "score": 0\n  },\n  {\n    "format": 22,\n    "score": 0\n  },\n  {\n    "format": 23,\n    "score": 0\n  },\n  {\n    "format": 24,\n    "score": 0\n  },\n  {\n    "format": 25,\n    "score": 0\n  },\n  {\n    "format": 26,\n    "score": 0\n  },\n  {\n    "format": 27,\n    "score": 0\n  },\n  {\n    "format": 28,\n    "score": 0\n  },\n  {\n    "format": 29,\n    "score": 0\n  },\n  {\n    "format": 30,\n    "score": 0\n  },\n  {\n    "format": 31,\n    "score": 0\n  },\n  {\n    "format": 32,\n    "score": 0\n  },\n  {\n    "format": 33,\n    "score": 0\n  },\n  {\n    "format": 34,\n    "score": 0\n  },\n  {\n    "format": 35,\n    "score": 0\n  },\n  {\n    "format": 36,\n    "score": 0\n  },\n  {\n    "format": 37,\n    "score": 0\n  },\n  {\n    "format": 38,\n    "score": 0\n  },\n  {\n    "format": 39,\n    "score": 0\n  },\n  {\n    "format": 40,\n    "score": 0\n  },\n  {\n    "format": 41,\n    "score": 0\n  },\n  {\n    "format": 42,\n    "score": 0\n  },\n  {\n    "format": 43,\n    "score": 0\n  },\n  {\n    "format": 44,\n    "score": 0\n  },\n  {\n    "format": 45,\n    "score": 0\n  },\n  {\n    "format": 46,\n    "score": 0\n  },\n  {\n    "format": 47,\n    "score": 0\n  },\n  {\n    "format": 48,\n    "score": 0\n  },\n  {\n    "format": 49,\n    "score": 0\n  },\n  {\n    "format": 50,\n    "score": 0\n  },\n  {\n    "format": 51,\n    "score": 0\n  },\n  {\n    "format": 52,\n    "score": 0\n  },\n  {\n    "format": 53,\n    "score": 0\n  },\n  {\n    "format": 54,\n    "score": 0\n  },\n  {\n    "format": 55,\n    "score": 0\n  },\n  {\n    "format": 56,\n    "score": 0\n  },\n  {\n    "format": 57,\n    "score": 0\n  },\n  {\n    "format": 58,\n    "score": 0\n  },\n  {\n    "format": 59,\n    "score": 0\n  },\n  {\n    "format": 60,\n    "score": 0\n  },\n  {\n    "format": 61,\n    "score": 0\n  },\n  {\n    "format": 62,\n    "score": 0\n  },\n  {\n    "format": 63,\n    "score": 0\n  },\n  {\n    "format": 64,\n    "score": 0\n  },\n  {\n    "format": 65,\n    "score": 0\n  },\n  {\n    "format": 66,\n    "score": 0\n  },\n  {\n    "format": 67,\n    "score": 0\n  },\n  {\n    "format": 68,\n    "score": 0\n  },\n  {\n    "format": 69,\n    "score": 0\n  },\n  {\n    "format": 70,\n    "score": 0\n  },\n  {\n    "format": 71,\n    "score": 0\n  },\n  {\n    "format": 72,\n    "score": 0\n  },\n  {\n    "format": 73,\n    "score": 0\n  },\n  {\n    "format": 74,\n    "score": 0\n  },\n  {\n    "format": 75,\n    "score": 0\n  },\n  {\n    "format": 76,\n    "score": 0\n  },\n  {\n    "format": 77,\n    "score": 0\n  },\n  {\n    "format": 78,\n    "score": 0\n  },\n  {\n    "format": 79,\n    "score": 0\n  },\n  {\n    "format": 80,\n    "score": 0\n  },\n  {\n    "format": 81,\n    "score": 0\n  },\n  {\n    "format": 82,\n    "score": 0\n  },\n  {\n    "format": 83,\n    "score": 0\n  },\n  {\n    "format": 84,\n    "score": 0\n  },\n  {\n    "format": 85,\n    "score": 0\n  },\n  {\n    "format": 86,\n    "score": 0\n  },\n  {\n    "format": 87,\n    "score": 0\n  },\n  {\n    "format": 88,\n    "score": 0\n  },\n  {\n    "format": 89,\n    "score": 0\n  },\n  {\n    "format": 90,\n    "score": 0\n  },\n  {\n    "format": 91,\n    "score": 0\n  },\n  {\n    "format": 92,\n    "score": 0\n  },\n  {\n    "format": 93,\n    "score": 0\n  },\n  {\n    "format": 94,\n    "score": 0\n  },\n  {\n    "format": 95,\n    "score": 0\n  },\n  {\n    "format": 96,\n    "score": 0\n  },\n  {\n    "format": 97,\n    "score": 0\n  },\n  {\n    "format": 98,\n    "score": 0\n  },\n  {\n    "format": 99,\n    "score": 0\n  },\n  {\n    "format": 100,\n    "score": 0\n  },\n  {\n    "format": 101,\n    "score": 0\n  },\n  {\n    "format": 102,\n    "score": 0\n  },\n  {\n    "format": 103,\n    "score": 0\n  },\n  {\n    "format": 104,\n    "score": 0\n  },\n  {\n    "format": 105,\n    "score": 0\n  },\n  {\n    "format": 106,\n    "score": 0\n  },\n  {\n    "format": 107,\n    "score": 0\n  },\n  {\n    "format": 108,\n    "score": 0\n  },\n  {\n    "format": 109,\n    "score": 0\n  },\n  {\n    "format": 110,\n    "score": 0\n  },\n  {\n    "format": 111,\n    "score": 0\n  },\n  {\n    "format": 112,\n    "score": 0\n  },\n  {\n    "format": 113,\n    "score": 0\n  },\n  {\n    "format": 114,\n    "score": 0\n  },\n  {\n    "format": 115,\n    "score": 0\n  },\n  {\n    "format": 116,\n    "score": 0\n  },\n  {\n    "format": 117,\n    "score": 0\n  }\n]','\n',char(10)),0,0,0,1);
INSERT INTO QualityProfiles VALUES(14,'No filter VO',1002,replace('[\n  {\n    "quality": 0,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 24,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 25,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 26,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 27,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 29,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 28,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 1,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 2,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 23,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1000,\n    "name": "WEB 480p",\n    "items": [\n      {\n        "quality": 8,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 12,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 20,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 21,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 4,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1001,\n    "name": "WEB 720p",\n    "items": [\n      {\n        "quality": 5,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 14,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 6,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 9,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "id": 1002,\n    "name": "WEB 1080p",\n    "items": [\n      {\n        "quality": 3,\n        "items": [],\n        "allowed": true\n      },\n      {\n        "quality": 15,\n        "items": [],\n        "allowed": true\n      }\n    ],\n    "allowed": true\n  },\n  {\n    "quality": 7,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "quality": 30,\n    "items": [],\n    "allowed": true\n  },\n  {\n    "quality": 16,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "id": 1003,\n    "name": "WEB 2160p",\n    "items": [\n      {\n        "quality": 18,\n        "items": [],\n        "allowed": false\n      },\n      {\n        "quality": 17,\n        "items": [],\n        "allowed": false\n      }\n    ],\n    "allowed": false\n  },\n  {\n    "quality": 19,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 31,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 22,\n    "items": [],\n    "allowed": false\n  },\n  {\n    "quality": 10,\n    "items": [],\n    "allowed": false\n  }\n]','\n',char(10)),-2,replace('[\n  {\n    "format": 2,\n    "score": 0\n  },\n  {\n    "format": 3,\n    "score": 0\n  },\n  {\n    "format": 4,\n    "score": 0\n  },\n  {\n    "format": 5,\n    "score": 0\n  },\n  {\n    "format": 6,\n    "score": 0\n  },\n  {\n    "format": 7,\n    "score": 0\n  },\n  {\n    "format": 8,\n    "score": 0\n  },\n  {\n    "format": 9,\n    "score": 0\n  },\n  {\n    "format": 10,\n    "score": 0\n  },\n  {\n    "format": 11,\n    "score": 0\n  },\n  {\n    "format": 12,\n    "score": 0\n  },\n  {\n    "format": 13,\n    "score": 0\n  },\n  {\n    "format": 14,\n    "score": 0\n  },\n  {\n    "format": 15,\n    "score": 0\n  },\n  {\n    "format": 16,\n    "score": 0\n  },\n  {\n    "format": 17,\n    "score": 0\n  },\n  {\n    "format": 18,\n    "score": 0\n  },\n  {\n    "format": 19,\n    "score": 0\n  },\n  {\n    "format": 20,\n    "score": 0\n  },\n  {\n    "format": 21,\n    "score": 0\n  },\n  {\n    "format": 22,\n    "score": 0\n  },\n  {\n    "format": 23,\n    "score": 0\n  },\n  {\n    "format": 24,\n    "score": 0\n  },\n  {\n    "format": 25,\n    "score": 0\n  },\n  {\n    "format": 26,\n    "score": 0\n  },\n  {\n    "format": 27,\n    "score": 0\n  },\n  {\n    "format": 28,\n    "score": 0\n  },\n  {\n    "format": 29,\n    "score": 0\n  },\n  {\n    "format": 30,\n    "score": 0\n  },\n  {\n    "format": 31,\n    "score": 0\n  },\n  {\n    "format": 32,\n    "score": 0\n  },\n  {\n    "format": 33,\n    "score": 0\n  },\n  {\n    "format": 34,\n    "score": 0\n  },\n  {\n    "format": 35,\n    "score": 0\n  },\n  {\n    "format": 36,\n    "score": 0\n  },\n  {\n    "format": 37,\n    "score": 0\n  },\n  {\n    "format": 38,\n    "score": 0\n  },\n  {\n    "format": 39,\n    "score": 0\n  },\n  {\n    "format": 40,\n    "score": 0\n  },\n  {\n    "format": 41,\n    "score": 0\n  },\n  {\n    "format": 42,\n    "score": 0\n  },\n  {\n    "format": 43,\n    "score": 0\n  },\n  {\n    "format": 44,\n    "score": 0\n  },\n  {\n    "format": 45,\n    "score": 0\n  },\n  {\n    "format": 46,\n    "score": 0\n  },\n  {\n    "format": 47,\n    "score": 0\n  },\n  {\n    "format": 48,\n    "score": 0\n  },\n  {\n    "format": 49,\n    "score": 0\n  },\n  {\n    "format": 50,\n    "score": 0\n  },\n  {\n    "format": 51,\n    "score": 0\n  },\n  {\n    "format": 52,\n    "score": 0\n  },\n  {\n    "format": 53,\n    "score": 0\n  },\n  {\n    "format": 54,\n    "score": 0\n  },\n  {\n    "format": 55,\n    "score": 0\n  },\n  {\n    "format": 56,\n    "score": 0\n  },\n  {\n    "format": 57,\n    "score": 0\n  },\n  {\n    "format": 58,\n    "score": 0\n  },\n  {\n    "format": 59,\n    "score": 0\n  },\n  {\n    "format": 60,\n    "score": 0\n  },\n  {\n    "format": 61,\n    "score": 0\n  },\n  {\n    "format": 62,\n    "score": 0\n  },\n  {\n    "format": 63,\n    "score": 0\n  },\n  {\n    "format": 64,\n    "score": 0\n  },\n  {\n    "format": 65,\n    "score": 0\n  },\n  {\n    "format": 66,\n    "score": 0\n  },\n  {\n    "format": 67,\n    "score": 0\n  },\n  {\n    "format": 68,\n    "score": 0\n  },\n  {\n    "format": 69,\n    "score": 0\n  },\n  {\n    "format": 70,\n    "score": 0\n  },\n  {\n    "format": 71,\n    "score": 0\n  },\n  {\n    "format": 72,\n    "score": 0\n  },\n  {\n    "format": 73,\n    "score": 0\n  },\n  {\n    "format": 74,\n    "score": 0\n  },\n  {\n    "format": 75,\n    "score": 0\n  },\n  {\n    "format": 76,\n    "score": 0\n  },\n  {\n    "format": 77,\n    "score": 0\n  },\n  {\n    "format": 78,\n    "score": 0\n  },\n  {\n    "format": 79,\n    "score": 0\n  },\n  {\n    "format": 80,\n    "score": 0\n  },\n  {\n    "format": 81,\n    "score": 0\n  },\n  {\n    "format": 82,\n    "score": 0\n  },\n  {\n    "format": 83,\n    "score": 0\n  },\n  {\n    "format": 84,\n    "score": 0\n  },\n  {\n    "format": 85,\n    "score": 0\n  },\n  {\n    "format": 86,\n    "score": 0\n  },\n  {\n    "format": 87,\n    "score": 0\n  },\n  {\n    "format": 88,\n    "score": 0\n  },\n  {\n    "format": 89,\n    "score": 0\n  },\n  {\n    "format": 90,\n    "score": 0\n  },\n  {\n    "format": 91,\n    "score": 0\n  },\n  {\n    "format": 92,\n    "score": 0\n  },\n  {\n    "format": 93,\n    "score": 0\n  },\n  {\n    "format": 94,\n    "score": 0\n  },\n  {\n    "format": 95,\n    "score": 0\n  },\n  {\n    "format": 96,\n    "score": 0\n  },\n  {\n    "format": 97,\n    "score": 0\n  },\n  {\n    "format": 98,\n    "score": 0\n  },\n  {\n    "format": 99,\n    "score": 0\n  },\n  {\n    "format": 100,\n    "score": 0\n  },\n  {\n    "format": 101,\n    "score": 0\n  },\n  {\n    "format": 102,\n    "score": 0\n  },\n  {\n    "format": 103,\n    "score": 0\n  },\n  {\n    "format": 104,\n    "score": 0\n  },\n  {\n    "format": 105,\n    "score": 0\n  },\n  {\n    "format": 106,\n    "score": 0\n  },\n  {\n    "format": 107,\n    "score": 0\n  },\n  {\n    "format": 108,\n    "score": 0\n  },\n  {\n    "format": 109,\n    "score": 0\n  },\n  {\n    "format": 110,\n    "score": 0\n  },\n  {\n    "format": 111,\n    "score": 0\n  },\n  {\n    "format": 112,\n    "score": 0\n  },\n  {\n    "format": 113,\n    "score": 0\n  },\n  {\n    "format": 114,\n    "score": 0\n  },\n  {\n    "format": 115,\n    "score": 0\n  },\n  {\n    "format": 116,\n    "score": 0\n  },\n  {\n    "format": 117,\n    "score": 0\n  }\n]','\n',char(10)),0,0,0,1);



DELETE FROM CustomFormats; 
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('2', 'Language: Original + French', '[
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": -2,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Original Language",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": 2,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "French Language",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MULTi)(\\b|\\d)",
      "name": "MULTi",
      "negate": false,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('3', 'Language: Not Original', '[
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": -2,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not Original Language",
      "negate": true,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('4', 'Language: Not French', '[
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": 2,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not French Language",
      "negate": true,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('5', 'VOSTFR', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(VOST.*?FR(E|A)?)\\b",
      "name": "VOSTFR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SUBFR(A|ENCH)?)\\b",
      "name": "SUBFRENCH",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('6', 'MULTi', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Multi)(?![ ._-]?sub(s)?)(\\b|\\d)",
      "name": "Multi",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('7', 'FR Remux Tier 01', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Remux",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BlackAngel)$",
      "name": "BlackAngel",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Choco)$",
      "name": "Choco",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HDForever)$",
      "name": "HDForever",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MAX)$",
      "name": "MAX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ONLY)$",
      "name": "ONLY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Psaro)$",
      "name": "Psaro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Sicario)$",
      "name": "Sicario",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Tezcat74)$",
      "name": "Tezcat74",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TyrellCorp)$",
      "name": "TyrellCorp",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Zapax)$",
      "name": "Zapax",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('8', 'FR Remux Tier 02', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Remux",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BDHD)$",
      "name": "BDHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FtLi)$",
      "name": "FtLi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Goldenyann)$",
      "name": "Goldenyann",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HeavyWeight)$",
      "name": "HeavyWeight",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KTM)$",
      "name": "KTM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MARBLECAKE)$",
      "name": "MARBLECAKE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MUSTANG)$",
      "name": "MUSTANG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Obi)$",
      "name": "Obi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PEPiTE)$",
      "name": "PEPiTE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Q(UEBE)?C63)$",
      "name": "QUEBEC63",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ROMKENT)$",
      "name": "ROMKENT",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('9', 'FR Scene Groups', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(4FR)$",
      "name": "#",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(AiR3D|AiRDOCS|AiRFORCE|AiRLiNE|AiRTV|AKLHD|AMB3R|ANMWR|AVON|AYMO|AZR)$",
      "name": "A",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BANKAi|BAWLS|BiPOLAR|BLACKPANTERS|BODIE|BOOLZ|BRiNK|BTT)$",
      "name": "B",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CARAPiLS|CiELOS|CiNEMA|CMBHD|CoRa|COUAC|CRYPT0)$",
      "name": "C",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(D4KiD|DEAL|DiEBEX|DUPLI|DUSS)$",
      "name": "D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ENJOi|EUBDS)$",
      "name": "E",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FHD|FiDELiO|FiDO|ForceBleue|FREAMON|FRENCHDEADPOOL2|FRiES|FUTiL|FWDHD)$",
      "name": "F",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GHOULS|GiMBAP|GLiMMER|Goatlove)$",
      "name": "G",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HERC|HiggsBoson|HiRoSHiMa|HYBRiS|HyDe)$",
      "name": "H",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(JMT|JoKeR|JUSTICELEAGUE)$",
      "name": "J",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KAZETV)$",
      "name": "K",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(L0SERNiGHT|LaoZi|LeON|LOFiDEL|LOST|LOWIMDB|LYPSG)$",
      "name": "L",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MAGiCAL|MANGACiTY|MAXAGAZ|MaxiBeNoul|McNULTY|MELBA|MiND|MORELAND|MUNSTER|MUxHD)$",
      "name": "M",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NERDHD|NERO|NrZ|NTK)$",
      "name": "N",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(OBSTACLE|OohLaLa|OOKAMI)$",
      "name": "O",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PANZeR|PATHECROUTE|Penrose|PiNKPANTERS|PKPTRS|PRiDEHD|PROPJOE|PURE|PUREWASTEOFBW)$",
      "name": "P",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ROUGH|RUDE|Ryotox)$",
      "name": "R",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SAFETY|SASHiMi|SEiGHT|SESKAPiLE|SHEEEiT|SHiNiGAMi(UHD)?|SiGeRiS|SILVIODANTE|SLEEPINGFOREST|SODAPOP|S4LVE|SPINE|SPOiLER|STRINGERBELL|Sunday26th|SUNRiSE)$",
      "name": "S",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(tFR|THENiGHTMAREiNHD|THiNK|THREESOME|TiMELiNE|TSuNaMi)$",
      "name": "T",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(UKDHD|UKDTV|ULSHD|Ulysse|USUNSKiLLED|URY)$",
      "name": "U",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(VENUE|VFC|VoMiT)$",
      "name": "V",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Wednesday29th)$",
      "name": "W",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ZEST|ZiRCON)$",
      "name": "Z",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('10', 'Remux Tier 01', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Remux",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(3L)$",
      "name": "3L",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BiZKiT)$",
      "name": "BiZKiT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BLURANiUM)$",
      "name": "BLURANiUM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BMF)$",
      "name": "BMF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CiNEPHiLES)$",
      "name": "CiNEPHiLES",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FraMeSToR)$",
      "name": "FraMeSToR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PmP)$",
      "name": "PmP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(WiLDCAT)$",
      "name": "WiLDCAT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ZQ)$",
      "name": "ZQ",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('11', 'Remux Tier 02', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Remux",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Flights)$",
      "name": "Flights",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NCmt)$",
      "name": "NCmt",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(playBD)$",
      "name": "playBD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SiCFoI)$",
      "name": "SiCFoI",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SURFINBIRD)$",
      "name": "SURFINBIRD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TEPES)$",
      "name": "TEPES",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('12', 'Remux Tier 03', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Remux",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(decibeL)$",
      "name": "decibeL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(EPSiLON)$",
      "name": "EPSiLON",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HiFi)$",
      "name": "HiFi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(iFT)$",
      "name": "iFT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KRaLiMaRKo)$",
      "name": "KRaLiMaRKo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NTb)$",
      "name": "NTb",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PTP)$",
      "name": "PTP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SumVision)$",
      "name": "SumVision",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TOA)$",
      "name": "TOA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TRiToN)$",
      "name": "TRiToN",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('13', 'WEB Tier 01', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ABBIE)$",
      "name": "ABBIE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(AJP69)$",
      "name": "AJP69",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(APEX|PAXA|PEXA|XEPA)$",
      "name": "APEX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BLUTONiUM)$",
      "name": "BLUTONiUM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CMRG)$",
      "name": "CMRG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CRFW)$",
      "name": "CRFW",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CRUD)$",
      "name": "CRUD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FLUX)$",
      "name": "FLUX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GNOME)$",
      "name": "GNOME",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HONE)$",
      "name": "HONE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KiNGS)$",
      "name": "KiNGS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Kitsune)$",
      "name": "Kitsune",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NOSiViD)$",
      "name": "NOSiViD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NTb)$",
      "name": "NTb",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NTG)$",
      "name": "NTG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SiC)$",
      "name": "SiC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TEPES)$",
      "name": "TEPES",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('14', 'WEB Tier 02', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(dB)$",
      "name": "dB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Flights)$",
      "name": "Flights",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MiU)$",
      "name": "MiU",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(monkee)$",
      "name": "monkee",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MZABI)$",
      "name": "MZABI",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PHOENiX)$",
      "name": "PHOENiX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(playWEB)$",
      "name": "playWEB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SbR)$",
      "name": "SbR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SMURF)$",
      "name": "SMURF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TOMMY)$",
      "name": "TOMMY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(XEBEC|4KBEC|CEBEX)$",
      "name": "XEBEC",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('15', 'WEB Tier 03', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BYNDR)$",
      "name": "BYNDR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GNOMiSSiON)$",
      "name": "GNOMiSSiON",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NINJACENTRAL)$",
      "name": "NINJACENTRAL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ROCCaT)$",
      "name": "ROCCaT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SiGMA)$",
      "name": "SiGMA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SLiGNOME)$",
      "name": "SLiGNOME",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SwAgLaNdEr)$",
      "name": "SwAgLaNdEr",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('16', 'Repack/Proper', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Repack)\\b",
      "name": "Repack",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Proper)\\b",
      "name": "Proper",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Rerip)\\b",
      "name": "Rerip",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('17', 'Repack2', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Repack2)\\b",
      "name": "Repack2",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Proper2)\\b",
      "name": "Proper2",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('18', 'Repack3', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Repack3)\\b",
      "name": "Repack3",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Proper3)\\b",
      "name": "Proper3",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('19', 'BR-DISK', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?!.*\\b((?\u003C!HD[._ -]|HD)DVD|BDRip|720p|MKV|XviD|WMV|d3g|(BD)?REMUX|^(?=.*1080p)(?=.*HEVC)|[xh][-_. ]?26[45]|German.*[DM]L|((?\u003C=\\d{4}).*German.*([DM]L)?)(?=.*\\b(AVC|HEVC|VC[-_. ]?1|MVC|MPEG[-_. ]?2)\\b))\\b)(((?=.*\\b(Blu[-_. ]?ray|BD|HD[-_. ]?DVD)\\b)(?=.*\\b(AVC|HEVC|VC[-_. ]?1|MVC|MPEG[-_. ]?2|BDMV|ISO)\\b))|^((?=.*\\b(((?=.*\\b((.*_)?COMPLETE.*|Dis[ck])\\b)(?=.*(Blu[-_. ]?ray|HD[-_. ]?DVD)))|3D[-_. ]?BD|BR[-_. ]?DISK|Full[-_. ]?Blu[-_. ]?ray|^((?=.*((BD|UHD)[-_. ]?(25|50|66|100|ISO)))))))).*",
      "name": "BR-DISK",
      "negate": false,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('20', 'LQ', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(24xHD)\\b",
      "name": "24xHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(41RGB)$",
      "name": "41RGB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(4K4U)$",
      "name": "4K4U",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(AROMA)$",
      "name": "AROMA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(aXXo)$",
      "name": "aXXo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(AZAZE)$",
      "name": "AZAZE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BARC0DE)$",
      "name": "BARC0DE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BAUCKLEY)$",
      "name": "BAUCKLEY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BdC)$",
      "name": "BdC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(beAst)$",
      "name": "beAst",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(C1NEM4)$",
      "name": "C1NEM4",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(C4K)$",
      "name": "C4K",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CDDHD)$",
      "name": "CDDHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CHAOS)$",
      "name": "CHAOS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CHD)$",
      "name": "CHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CiNE)$",
      "name": "CiNE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(COLLECTiVE)$",
      "name": "COLLECTiVE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CREATiVE24)$",
      "name": "CREATiVE24",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CrEwSaDe)$",
      "name": "CrEwSaDe",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CTFOH)$",
      "name": "CTFOH",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(d3g)$",
      "name": "d3g",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(DDR)$",
      "name": "DDR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(DNL)$",
      "name": "DNL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(EPiC)$",
      "name": "EPiC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(EuReKA)$",
      "name": "EuReKA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FaNGDiNG0)$",
      "name": "FaNGDiNG0",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FGT)$",
      "name": "FGT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FRDS)$",
      "name": "FRDS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FZHD)$",
      "name": "FZHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GalaxyRG)$",
      "name": "GalaxyRG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GHD)$",
      "name": "GHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GPTHD)$",
      "name": "GPTHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HDS)$",
      "name": "HDS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HDT)$",
      "name": "HDT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HDTime)$",
      "name": "HDTime",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HDWinG)$",
      "name": "HDWinG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(iNTENSO)$",
      "name": "iNTENSO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(iPlanet)$",
      "name": "iPlanet",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(iVy)$",
      "name": "iVy",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(jennaortega(UHD)?)$",
      "name": "jennaortega",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(JFF)$",
      "name": "JFF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KC)$",
      "name": "KC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KiNGDOM)$",
      "name": "KiNGDOM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(KIRA)$",
      "name": "KIRA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(L0SERNIGHT)$",
      "name": "L0SERNIGHT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(LAMA)$",
      "name": "LAMA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Leffe)$",
      "name": "Leffe",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Liber8)$",
      "name": "Liber8",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(LiGaS)$",
      "name": "LiGaS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(LUCY)$",
      "name": "LUCY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MarkII)$",
      "name": "MarkII",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MeGusta)$",
      "name": "MeGusta",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(mHD)$",
      "name": "mHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(mSD)$",
      "name": "mSD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MTeam|MT)$",
      "name": "MTeam",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MySiLU)$",
      "name": "MySiLU",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NhaNc3)$",
      "name": "NhaNc3",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(nHD)$",
      "name": "nHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(nikt0)$",
      "name": "nikt0",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "NoGr(ou)?p",
      "name": "NoGroup",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(nSD)$",
      "name": "nSD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(OFT)$",
      "name": "OFT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Pahe(\\.(ph|in))?\\b",
      "name": "Pahe",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PATOMiEL)$",
      "name": "PATOMiEL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PiRaTeS)$",
      "name": "PiRaTeS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PRODJi)$",
      "name": "PRODJi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PSA)$",
      "name": "PSA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PTNK)$",
      "name": "PTNK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(RARBG)$",
      "name": "RARBG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(RDN)$",
      "name": "RDN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Rifftrax)$",
      "name": "RiffTrax",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(RU4HD)$",
      "name": "RU4HD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SANTi)$",
      "name": "SANTi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Scene)$",
      "name": "Scene",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SHD)$",
      "name": "SHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ShieldBearer)$",
      "name": "ShieldBearer",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(STUTTERSHIT)$",
      "name": "STUTTERSHIT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SUNSCREEN)$",
      "name": "SUNSCREEN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TBS)$",
      "name": "TBS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TEKNO3D)$",
      "name": "TEKNO3D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Tigole)$",
      "name": "Tigole",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TIKO)$",
      "name": "TIKO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(VISIONPLUSHDR(-X|1000)?)$",
      "name": "VISIONPLUSHDR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(WAF)$",
      "name": "WAF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(WiKi)$",
      "name": "WiKi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(x0r)$",
      "name": "x0r",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(YIFY)$",
      "name": "YIFY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(YTS(.(MX|LT|AG))?)$",
      "name": "YTS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Zeus)$",
      "name": "Zeus",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('21', 'LQ (Release Title)', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(1XBET)\\b",
      "name": "1XBET",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BEN[ ._-]THE[ ._-]MEN)\\b",
      "name": "BEN THE MEN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GalaxyRG)\\b",
      "name": "GalaxyRG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C!-)\\b(jennaortega(UHD)?)\\b",
      "name": "jennaortega",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SWTYBLZ)\\b",
      "name": "SWTYBLZ",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TeeWee)\\b",
      "name": "TeeWee",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TEKNO3D)\\b",
      "name": "TEKNO3D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Will1869)\\b",
      "name": "Will1869",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('22', 'FR LQ', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Bandix|CZ\\d\u002B|EXTREME|GA(\u00CF|I)A|HMiDiMADRiDi|Hush|KILLERMIX|LiBERTAD|LTa?TM|MONiCO|NEWCINE|R(PZ|ZP)|ShowFR|VERCLAM|ViKi47|Wawa-?(city|mania|porno)?|ZW)\\b",
      "name": "Ads/Watermarks",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ACOOL|AlioZ|ASPHiXiAS|AViTECH|AZAZE|Balibalo|BLABLASTREAM|DDLFRENCH(ORG)?|FERVEX|FReeZeR|GHOSTSPiRiT|GHZ|GLaDOS|GZR|HEVCBay|JiHeff|KR4K3N|Matmatha|MKVXTEAM|Monchat|NLX5|NOMAD|NORRIS|PiCKLES|PREUMS|qctimb3rlandqc|ReBoT|ROLLED|SCREEN|SHiFT|SKRiN|TicaDow|Tokushi|Tonyk|TOXIC|TUTUTE|UNiKORN|Zombie)\\b",
      "name": "Bad/False releases",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((Cpasbien|CPB)|ANONA|AT|bigZT|Boheme|BOL|CINeHD|Cortex91|DOLL4R|Dread[ .-]?Team|Dropse|EZTV([ ._-]re)?|FGT|Firetown|FUN|HDMIDIMADRIDI|JetAnime|L-?O-?L|NewZT|NG|RARBG|STVFRV|SubZero|T9|Time2Watch|TIREXO|Torrent9|WebAnime|YIFY|YTS|ZONE|ZT)\\b",
      "name": "DeTAG/ReTAG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AKLHD|ARKRiL|BossBaby|Champion9|Copycomic|CR4ZYTiME|EASPORTS|EliteT|FUNKKY|FZTeam|GOBO2S|HD2|LION|LMPS|LNA3d|MACK4|MeMyl|METALLIKA|MGD|Moorea81|Moviz|Muxman|Mystic|MZC|MZi?SYS|N3TFL1X|NoelMaison|nutella|OMERTA|Papaya|PIKACHU|PULSE|Q7|RELiC|SANCTUAIRE|SHARKS|SP3CTR|Spow|STR4NGE|TeamSuW|TORRiD|TSN999|TVPSLO|Upmix|VATFER|Wakanim|WaNeZt|WINCHESTER|WITA)\\b",
      "name": "Other reasons",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('23', 'x265 (HD)', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "[xh][ ._-]?265|\\bHEVC(\\b|\\d)",
      "name": "x265/HEVC",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not 2160p",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('24', '3D', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=\\b[12]\\d{3}\\b).*\\b(3d|sbs|half[ .-]ou|half[ .-]sbs)\\b",
      "name": "3D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BluRay3D)\\b",
      "name": "BluRay3D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BD3D)\\b",
      "name": "BD3D",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('25', 'Extras', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=\\b[12]\\d{3}\\b).*\\b(Extras|Bonus|Extended[ ._-]Clip)\\b",
      "name": "Extras",
      "negate": false,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('26', 'AV1', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAV1\\b",
      "name": "AV1",
      "negate": false,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('27', 'AMZN', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(amzn|amazon(hd)?)\\b",
      "name": "Amazon",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('28', 'ATVP', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(atvp|aptv|Apple TV\\\u002B)\\b",
      "name": "Apple TV\u002B",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('29', 'BCORE', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BCORE)\\b",
      "name": "Bravia Core",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('30', 'CRiT', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CRiT)\\b",
      "name": "CRiT",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Criterion)$",
      "name": "Not Criterion RlsGrp",
      "negate": true,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('31', 'DSNP', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dsnp|dsny|disney|Disney\\\u002B)\\b",
      "name": "Disney\u002B",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('32', 'HBO', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(hbo)(?![ ._-]max)\\b(?=[ ._-]web[ ._-]?(dl|rip)\\b)",
      "name": "HBO",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('33', 'HMAX', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(hmax|hbom|hbo[ ._-]?max)\\b(?=[ ._-]web[ ._-]?(dl|rip)\\b)",
      "name": "HBO Max",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('34', 'Hulu', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(hulu)\\b",
      "name": "Hulu",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('35', 'iT', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(it|itunes)\\b(?=[ ._-]web[ ._-]?(dl|rip)\\b)",
      "name": "iTunes",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('36', 'MAX', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((?\u003C!hbo[ ._-])max)\\b(?=[ ._-]web[ ._-]?(dl|rip)\\b)",
      "name": "Max",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('37', 'MA', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C!dts[ .-]?hd[ .-]?)\\bma\\b(?=.*\\bweb[ ._-]?(dl|rip)\\b)",
      "name": "Movies Anywhere",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('38', 'NF', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(nf|netflix(u?hd)?)\\b",
      "name": "Netflix",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('39', 'PMTP', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(pmtp|Paramount Plus)\\b",
      "name": "Paramount\u002B",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('40', 'PCOK', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(pcok|peacock)\\b",
      "name": "Peacock TV",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('41', 'STAN', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(stan)\\b[ ._-]web[ ._-]?(dl|rip)?\\b",
      "name": "Stan",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('42', 'Bad Dual Groups', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(alfaHD.*)$",
      "name": "alfaHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BAT)$",
      "name": "BAT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BlackBit)$",
      "name": "BlackBit",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BNd)$",
      "name": "BNd",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(C\\.A\\.A)$",
      "name": "C.A.A",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Cory)$",
      "name": "Cory",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(EXTREME)$",
      "name": "EXTREME",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FF)$",
      "name": "FF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FOXX)$",
      "name": "FOXX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(G4RiS)$",
      "name": "G4RiS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(GUEIRA)$",
      "name": "GUEIRA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(LCD)$",
      "name": "LCD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(N3G4N)$",
      "name": "N3G4N",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ONLYMOViE)$",
      "name": "ONLYMOViE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PD)$",
      "name": "PD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PTHome)$",
      "name": "PTHome",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(RiPER)$",
      "name": "RiPER",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(RK)$",
      "name": "RK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SiGLA)$",
      "name": "SiGLA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Tars)$",
      "name": "Tars",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TvR)$",
      "name": "TvR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(vnlls)$",
      "name": "vnlls",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(WTV)$",
      "name": "WTV",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Yatogam1)$",
      "name": "Yatogam1",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(YusukeFLA)$",
      "name": "YusukeFLA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ZigZag)$",
      "name": "ZigZag",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ZNM)$",
      "name": "ZNM",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('43', 'Black and White Editions', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((B(lack)?[ ._-]?(out|(and|[n\u0026])[ ._-]?(W(hite)?|Chrome))))\\b(?!$)",
      "name": "Blackout/B\u0026W/Black\u0026Chrome",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Monochrome)\\b(?!$)",
      "name": "Monochrome",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=\\b[12]\\d{3}\\b).*\\b(Noir)\\b(?!$)",
      "name": "Noir",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Shush[ ._-]?Cut)\\b(?!$)",
      "name": "Shush Cut",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((No|Minus)[ ._-]?Colou?r)\\b(?!$)",
      "name": "No/Minus Color",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=\\b[12]\\d{3}\\b).*\\b(Gr[ae]y([ ._-]?(scale))?)\\b(?!$)",
      "name": "Grayscale",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Darkness?[ ._-]?(and|\u0026)[ ._-]?(Light))\\b(?!$)",
      "name": "Darkness and Light",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('44', 'EVO (no WEBDL)', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(EVO(TGX)?)$",
      "name": "EVO",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('45', 'No-RlsGroup', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": ".",
      "name": "No Parsed Group",
      "negate": true,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('46', 'Obfuscated', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-4P\\b",
      "name": "4P",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-4Planet\\b",
      "name": "4Planet",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-AsRequested\\b",
      "name": "AsRequested",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-BUYMORE\\b",
      "name": "BUYMORE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-Chamele0n\\b",
      "name": "Chamele0n",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-GEROV\\b",
      "name": "GEROV",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-iNC0GNiTO\\b",
      "name": "iNC0GNiTO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-NZBGeek\\b",
      "name": "NZBGeek",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-Obfuscated\\b",
      "name": "Obfuscated",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-postbot\\b",
      "name": "postbot",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-Rakuv\\b",
      "name": "Rakuv",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=\\b[12]\\d{3}\\b).*(Scrambled)\\b",
      "name": "Scrambled",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-WhiteRev\\b",
      "name": "WhiteRev",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-xpost\\b",
      "name": "xpost",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-WRTEAM\\b",
      "name": "WRTEAM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "-CAPTCHA\\b",
      "name": "CAPTCHA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "_nzb\\b",
      "name": "_nzb",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('47', 'Retags', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[rartv\\]",
      "name": "[rartv]",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[rarbg\\]",
      "name": "[rarbg]",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[eztv([ ._-]re)?\\]",
      "name": "[eztv]",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[TGx\\]",
      "name": "[TGx]",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "[.]VAV\\b",
      "name": ".VAV",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "[.]heb\\b",
      "name": ".heb",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ORARBG)\\b",
      "name": "ORARBG",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('48', 'Scene', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*(\\b\\d{3,4}p\\b).*([_. ]WEB[_. ])(?!DL)\\b)|\\b(-CAKES|-GGEZ|-GGWP|-GLHF|-GOSSIP|-NAISU|-KOGI|-PECULATE|-SLOT|-EDITH|-ETHEL|-ELEANOR|-B2B|-SPAMnEGGS|-FTP|-DiRT|-SYNCOPY|-BAE|-SuccessfulCrab|-NHTFS|-SURCODE|-B0MBARDIERS)",
      "name": "Scene Groups \u002B Naming",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(INFLATE|DEFLATE)\\b",
      "name": "Not INFLATE/DEFLATE",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('49', 'Remaster', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Remaster",
      "name": "Remaster",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "4K",
      "name": "Not 4K Remaster",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('50', '4K Remaster', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Remaster",
      "name": "Remaster",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "4k",
      "name": "4K",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not 4K Resolution",
      "negate": true,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('51', 'Criterion Collection', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Criterion)\\b",
      "name": "Criterion",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CC)\\b",
      "name": "CC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Criterion)$",
      "name": "Not Criterion RlsGrp",
      "negate": true,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('52', 'Masters of Cinema', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Masters[ .-]?Of[ .-]?Cinema)(\\b|\\d)",
      "name": "Masters of Cinema",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MoC)\\b",
      "name": "MoC",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('53', 'Vinegar Syndrome', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Vinegar[ ._-]Syndrome)\\b",
      "name": "Vinegar Syndrome",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(V-S)\\b",
      "name": "VS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(VinSyn)\\b",
      "name": "VinSyn",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('54', 'Special Edition', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C!^|{)\\b(extended|uncut|directors|special|unrated|uncensored|cut|version|edition)(\\b|\\d)",
      "name": "Special Edition",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(IMAX[ ._-]Edition)\\b",
      "name": "Not IMAX Edition",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Open[ ._-]?Matte)\\b",
      "name": "Not Open Matte",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Theatrical",
      "name": "Not Theatrical",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Extended[ ._-]Clip)\\b",
      "name": "Not Extended Clip",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('55', 'IMAX Enhanced', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b((DSNP|Disney\\\u002B|BC|B?CORE)(?=[ ._-]web[ ._-]?(dl|rip)\\b)))(?=.*\\b((?\u003C!NON[ ._-])IMAX)\\b)|^(?=.*\\b(IMAX[ ._-]Enhanced)\\b)",
      "name": "IMAX Enhanced",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('56', 'IMAX', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((?\u003C!NON[ ._-])IMAX)\\b",
      "name": "IMAX",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b((DSNP|Disney\\\u002B|BC|B?CORE)(?=[ ._-]web[ ._-]?(dl|rip)\\b)))(?=.*\\b((?\u003C!NON[ ._-])IMAX)\\b)|^(?=.*\\b(IMAX[ ._-]Enhanced)\\b)",
      "name": "NOT: IMAX Enhanced",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('57', 'FR UHD Bluray Tier 01', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FLOP)$",
      "name": "FLOP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FRATERNiTY)$",
      "name": "FRATERNiTY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FoX)$",
      "name": "FoX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Psaro)$",
      "name": "Psaro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not REMUX",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR\\b",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('58', 'FR UHD Bluray Tier 02', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(DUSTiN)$",
      "name": "DUSTiN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FCK)$",
      "name": "FCK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FrIeNdS)$",
      "name": "FrIeNdS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(QUALiTY)$",
      "name": "QUALiTY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not REMUX",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR\\b",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('59', 'FR WEB Tier 01', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BONBON)$",
      "name": "BONBON",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FCK)$",
      "name": "FCK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FW)$",
      "name": "FW",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FoX)$",
      "name": "FoX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FRATERNiTY)$",
      "name": "FRATERNiTY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FrIeNdS)$",
      "name": "FrIeNdS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MOONLY)$",
      "name": "MOONLY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MTDK)$",
      "name": "MTDK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PATOPESTO)$",
      "name": "PATOPESTO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Psaro)$",
      "name": "Psaro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(T3KASHi)$",
      "name": "T3KASHi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TFA)$",
      "name": "TFA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TiNA)$",
      "name": "TiNA",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('60', 'FR WEB Tier 02', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ALLDAYiN)$",
      "name": "ALLDAYiN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ARK01)$",
      "name": "ARK01",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(FUJiSAN)$",
      "name": "FUJiSAN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HANAMi)$",
      "name": "HANAMi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HeavyWeight)$",
      "name": "HeavyWeight",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NEO)$",
      "name": "NEO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(NoNe)$",
      "name": "NoNe",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(ONLYMOViE)$",
      "name": "ONLYMOViE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(POTO)$",
      "name": "POTO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(Slay3R)$",
      "name": "Slay3R",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(TkHD)$",
      "name": "TkHD",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('61', 'UHD Bluray Tier 01', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not REMUX",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(CtrlHD)$",
      "name": "CtrlHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(MainFrame)$",
      "name": "MainFrame",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(DON)$",
      "name": "DON",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(W4NK3R)$",
      "name": "W4NK3R",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('62', 'UHD Bluray Tier 02', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not REMUX",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HQMUX)$",
      "name": "HQMUX",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('63', 'UHD Bluray Tier 03', '[
  {
    "type": "QualityModifierSpecification",
    "body": {
      "order": 7,
      "implementationName": "Quality Modifier",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not REMUX",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(BHDStudio)$",
      "name": "BHDStudio",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(hallowed)$",
      "name": "hallowed",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(HONE)$",
      "name": "HONE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(PTer)$",
      "name": "PTer",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(SPHD)$",
      "name": "SPHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(WEBDV)$",
      "name": "WEBDV",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('64', 'DV HDR10+', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b((HDR10(?=(P(lus)?)\\b|\\\u002B))))",
      "name": "DV HDR10\u002B",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]HLG)\\b",
      "name": "Not DV HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]SDR)\\b",
      "name": "Not DV SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('65', 'DV HDR10', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b((HDR10(?!(P(lus)?)\\b|\\\u002B))|(HDR))\\b)",
      "name": "DV HDR10",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b((HDR10(?=(P(lus)?)\\b|\\\u002B))))",
      "name": "Not DV HDR10Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]HLG)\\b",
      "name": "Not DV HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]SDR)\\b",
      "name": "Not DV SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('66', 'DV', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "DV",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b(HDR(10)?(P(lus)?)?)\\b)",
      "name": "Not DV HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]HLG)\\b",
      "name": "Not DV HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]SDR)\\b",
      "name": "Not DV SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('67', 'DV HLG', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]HLG)\\b",
      "name": "DV HLG",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b(HDR(10)?(P(lus)?)?)\\b)",
      "name": "Not DV HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]SDR)\\b",
      "name": "Not DV SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('68', 'DV SDR', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]SDR)\\b",
      "name": "DV SDR",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b(HDR(10)?(P(lus)?)?)\\b)",
      "name": "Not DV HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DV[ .]HLG)\\b",
      "name": "Not DV HLG",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('69', 'HDR10+', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(\\\u002B|P(lus)?\\b)",
      "name": "HDR10\u002B",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b(HDR(10)?(P(lus)?)?)\\b)",
      "name": "Not DV HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "Not PQ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HLG)\\b",
      "name": "Not HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR(\\b|\\d)",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('70', 'HDR10', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(?!\\\u002B|Plus)\\b",
      "name": "HDR10",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?=.*\\b(DV|DoVi|Dolby[ .]?V(ision)?)\\b)(?=.*\\b(HDR(10)?(P(lus)?)?)\\b)",
      "name": "Not DV HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "Not PQ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HLG)\\b",
      "name": "Not HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR(\\b|\\d)",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('71', 'HDR', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HDR)\\b",
      "name": "HDR",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(?!\\\u002B|Plus)\\b",
      "name": "Not HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(\\\u002B|P(lus)?\\b)",
      "name": "Not HDR10\u002B",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHLG(\\b|\\d)",
      "name": "Not HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "Not PQ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(FraMeSToR|HQMUX|SiCFoI)\\b",
      "name": "Not RlsGrp (Missing HDR)",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR(\\b|\\d)",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('72', 'HDR (undefined)', '[
  {
    "type": "ReleaseGroupSpecification",
    "body": {
      "order": 9,
      "implementationName": "Release Group",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(FraMeSToR|HQMUX|SiCFoI)\\b",
      "name": "RlsGrp (Missing HDR)",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(?!\\\u002B|Plus)\\b",
      "name": "Not HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(\\\u002B|P(lus)?\\b)",
      "name": "Not HDR10\u002B",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HLG)\\b",
      "name": "Not HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "Not PQ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR(\\b|\\d)",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('73', 'PQ', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "PQ",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(\\\u002B|P(lus)?\\b)",
      "name": "Not HDR10\u002B",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(?!\\\u002B|Plus)\\b",
      "name": "Not HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HLG)\\b",
      "name": "Not HLG",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR(\\b|\\d)",
      "name": "Not SDR",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('74', 'HLG', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HLG)\\b",
      "name": "HLG",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?)\\b",
      "name": "Not DV",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(\\\u002B|P(lus)?\\b)",
      "name": "Not HDR10\u002B",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR10(?!\\\u002B|Plus)\\b",
      "name": "Not HDR10",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PQ)\\b",
      "name": "Not PQ",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('75', 'TrueHD ATMOS', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|W4NK3R|HQMUX",
      "name": "TrueHD",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ATMOS|CtrlHD|W4NK3R|DON)(\\b|\\d)",
      "name": "ATMOS",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "Not DTS X",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('76', 'DTS X', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "DTS X",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "DTS[ .]?[1-9]",
      "name": "Not Basic DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('77', 'ATMOS (undefined)', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bATMOS(\\b|\\d)",
      "name": "ATMOS",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(W4NK3R|HQMUX)\\b",
      "name": "Not RlsGrp (Atmos Only)",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD",
      "name": "Not TrueHD",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('78', 'DD+ ATMOS', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Dolby Digital Plus",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ATMOS|DDPA)(\\b|\\d)",
      "name": "ATMOS",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD",
      "name": "Not TrueHD",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('79', 'TrueHD', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD",
      "name": "TrueHD",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bATMOS(\\b|\\d)",
      "name": "ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CtrlHD|W4NK3R|DON)\\b",
      "name": "Not RlsGrp (TrueHD only)",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('80', 'DTS-HD MA', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_. ]?(ma|hd([-_. ]?ma)?|xll))(\\b|\\d)",
      "name": "DTS-HD MA",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "Not DTS X",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dts[-. ]?(es|(hd[. ]?)?(hr|hi))",
      "name": "Not DTS-HD HRA/ES",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('81', 'FLAC', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "FLAC",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus ",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('82', 'PCM', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "PCM",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus ",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('83', 'DTS-HD HRA', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dts[-. ]?(hd[. ]?)?(hra?|hi\\b)",
      "name": "DTS-HD HRA",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "DTS[ .]?[1-9]",
      "name": "Not Basic DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "Not DTS X",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dts.?es",
      "name": "Not DTS-ES",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "[^0-9]6[ .][0-1]",
      "name": "Not 6.1 Surround",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('84', 'DD+', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B](?!A)|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Dolby Digital Plus",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(True[ .-]?HD|ATMOS|DDPA)(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('85', 'DTS-ES', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dts[-. ]?es\\b",
      "name": "DTS-ES",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "DTS[ .]?[1-9]",
      "name": "Not Basic DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "Not DTS X",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('86', 'DTS', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Basic DTS",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_. ]?(ma|hd([-_. ]?ma)?|xll))(\\b|\\d)",
      "name": "Not DTS-HD",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dts[-. ]?(es|(hd[. ]?)?(hr|hi))",
      "name": "Not DTS-HD HRA/ES",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dts[-_.: ]?x7?)\\b(?![-_. ]?(26[456]))",
      "name": "Not DTS X",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('87', 'AAC', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "AAC",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus ",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Not Basic Dolby Digital",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('88', 'DD', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[^a-z\u002B]|(?\u003C!e-)\\b(ac-?3)\\b",
      "name": "Basic Dolby Digital",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDD[P\u002B]|\\b(e[-_. ]?ac-?3)\\b",
      "name": "Not Dolby Digital Plus",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "True[ .-]?HD|\\bATMOS(\\b|\\d)",
      "name": "Not TrueHD/ATMOS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bDTS(\\b|\\d)",
      "name": "Not DTS",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bFLAC(\\b|\\d)",
      "name": "Not FLAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bAAC(\\b|\\d)",
      "name": "Not AAC",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(l?)PCM(\\b|\\d)",
      "name": "Not PCM",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('89', 'SDR', '[
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR(\\b|\\d)|\\b(dv|dovi|dolby[ .]?v(ision)?)\\b|\\b(FraMeSToR|HQMUX|SICFoI)\\b|\\b(PQ)\\b|\\bHLG(\\b|\\d)",
      "name": "HDR Formats",
      "negate": true,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR\\b",
      "name": "SDR",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('90', 'SDR (no WEBDL)', '[
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "2160p",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bHDR(\\b|\\d)|\\b(dv|dovi|dolby[ .]?v(ision)?)\\b|\\b(FraMeSToR|HQMUX|SICFoI)\\b|\\b(PQ)\\b|\\bHLG(\\b|\\d)",
      "name": "HDR Formats",
      "negate": true,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\bSDR\\b",
      "name": "SDR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBDL",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not WEBRIP",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('91', 'x265 (no HDR/DV)', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "[xh][ ._-]?265|\\bHEVC(\\b|\\d)",
      "name": "x265/HEVC",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(dv|dovi|dolby[ .]?v(ision)?|hdr(10(P(lus)?)?)?|pq)\\b",
      "name": "Not HDR/DV",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "ResolutionSpecification",
    "body": {
      "order": 6,
      "implementationName": "Resolution",
      "value": 2160,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Not 2160p",
      "negate": true,
      "required": true
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('92', 'Anime BD Tier 01 (Top SeaDex Muxers)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Aergia\\]|-Aergia(?!-raws)\\b",
      "name": "Aergia",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Arg0)\\b",
      "name": "Arg0",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Legion\\]|-Legion\\b",
      "name": "Legion",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LYS1TH3A)\\b",
      "name": "LYS1TH3A",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(OZR)\\b",
      "name": "OZR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[sam\\]|-sam\\b",
      "name": "sam",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SCY)\\b",
      "name": "SCY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[smol\\]|-smol\\b",
      "name": "smol",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[SoM\\]|-SoM\\b",
      "name": "SoM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Vanilla\\]|-Vanilla\\b",
      "name": "Vanilla",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Vodes\\]|(?\u003C!Not)-Vodes\\b",
      "name": "Vodes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ZeroBuild)\\b",
      "name": "ZeroBuild",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('93', 'Anime BD Tier 02 (SeaDex Muxers)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(0x539)\\b",
      "name": "0x539",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Alt\\]|-Alt\\b",
      "name": "Alt",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[ARC\\]|-ARC\\b",
      "name": "ARC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Arid\\]|-Arid\\b",
      "name": "Arid",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(aro)\\b",
      "name": "aro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Baws)\\b",
      "name": "Baws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BKC)\\b",
      "name": "BKC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Brrrrrrr)\\b",
      "name": "Brrrrrrr",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Chotab)\\b",
      "name": "Chotab",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Crow\\]|-Crow\\b",
      "name": "Crow",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CsS)\\b",
      "name": "CsS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CUNNY)\\b",
      "name": "CUNNY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Cunnysseur)\\b",
      "name": "Cunnysseur",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(D-Z0N3)\\b",
      "name": "D-Z0N3",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Dae)\\b",
      "name": "Dae",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Datte13)\\b",
      "name": "Datte13",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Drag\\]|-Drag\\b",
      "name": "Drag",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(FLFL)\\b",
      "name": "FLFL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(hydes)\\b",
      "name": "hydes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(iKaos)\\b",
      "name": "iKaos",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(JySzE)\\b",
      "name": "JySzE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LostYears)\\b",
      "name": "LostYears",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Lulu\\]|-Lulu\\b",
      "name": "Lulu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Matsya)\\b",
      "name": "Matsya",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MC)\\b",
      "name": "MC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Metal\\]|-Metal\\b",
      "name": "Metal",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Moxie\\]|-Moxie\\b",
      "name": "Moxie",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MTBB)\\b",
      "name": "MTBB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Not-Vodes\\]|-Not-Vodes\\b",
      "name": "Not-Vodes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Noyr)\\b",
      "name": "Noyr",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NSDAB)\\b",
      "name": "NSDAB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Okay-Subs)\\b",
      "name": "Okay-Subs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(pog42)\\b",
      "name": "pog42",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(pyroneko)\\b",
      "name": "pyroneko",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(RAI)\\b",
      "name": "RAI",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Reza)\\b",
      "name": "Reza",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Shimatta)\\b",
      "name": "Shimatta",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Smoke\\]|-Smoke\\b",
      "name": "Smoke",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Spirale)\\b",
      "name": "Spirale",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Thighs\\]|-Thighs\\b",
      "name": "Thighs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(UDF)\\b",
      "name": "UDF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Yuki\\]|-Yuki\\b",
      "name": "Yuki",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('94', 'Anime BD Tier 03 (SeaDex Muxers)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[AC\\]|-AC$",
      "name": "AC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ASC)\\b",
      "name": "ASC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AssMix)\\b",
      "name": "AssMix",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Ayashii\\]|-Ayashii\\b",
      "name": "Ayashii",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CBT)\\b",
      "name": "CBT",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CTR)\\b",
      "name": "CTR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CyC)\\b",
      "name": "CyC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Dekinai\\]|-Dekinai\\b",
      "name": "Dekinai",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[EXP\\]|-EXP\\b",
      "name": "EXP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Galator)\\b",
      "name": "Galator",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GSK[._-]kun)\\b",
      "name": "GSK_kun",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Holomux)\\b",
      "name": "Holomux",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(IK)\\b",
      "name": "IK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AnimeKaizoku)\\b|\\[Kaizoku\\]|-Kaizoku\\b",
      "name": "Kaizoku",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kametsu)\\b",
      "name": "Kametsu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KH)\\b",
      "name": "KH",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(kuchikirukia)\\b",
      "name": "kuchikirukia",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LazyRemux)\\b",
      "name": "LazyRemux",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MK)\\b",
      "name": "MK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Mysteria\\]|-Mysteria\\b",
      "name": "Mysteria",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(?\u003C=remux).*\\b(NAN0)\\b",
      "name": "NAN0",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Netaro)\\b",
      "name": "Netaro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Pn8)\\b",
      "name": "Pn8",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Pookie)\\b",
      "name": "Pookie",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Quetzal)\\b",
      "name": "Quetzal",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Rasetsu)\\b",
      "name": "Rasetsu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Senjou\\]|-Senjou\\b",
      "name": "Senjou",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ShowY)\\b",
      "name": "ShowY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(WBDP)\\b",
      "name": "WBDP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(WSE)\\b",
      "name": "WSE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Yoghurt)\\b",
      "name": "Yoghurt",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[YURI\\]|-YURI\\b",
      "name": "YURI",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ZOIO)\\b",
      "name": "ZOIO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ZR)\\b|-ZR-",
      "name": "ZR",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('95', 'Anime BD Tier 04 (SeaDex Muxers)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(9volt)\\b",
      "name": "9volt",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AOmundson)\\b",
      "name": "AOmundson",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Asakura\\]|-Asakura\\b",
      "name": "Asakura",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ASO)\\b",
      "name": "ASO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Bolshevik\\]|-Bolshevik\\b",
      "name": "Bolshevik",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Bulldog\\]|-Bulldog\\b",
      "name": "Bulldog",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Cait-Sidhe)\\b",
      "name": "Cait-Sidhe",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Chihiro\\]|-Chihiro\\b",
      "name": "Chihiro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Chimera\\]|-Chimera\\b",
      "name": "Chimera",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CoalGirls)\\b",
      "name": "CoalGirls",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Commie)\\b",
      "name": "Commie",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(D3)\\b",
      "name": "D3",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Davinci\\]|-Davinci\\b",
      "name": "Davinci",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(deanzel)\\b",
      "name": "deanzel",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Doki\\]|-Doki\\b",
      "name": "Doki",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Dragon-Releases)\\b",
      "name": "Dragon-Releases",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Foxtrot\\]|-Foxtrot\\b",
      "name": "Foxtrot",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GHS)\\b",
      "name": "GHS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HaiveMind)\\b",
      "name": "HaiveMind",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(hchcsen)\\b",
      "name": "hchcsen",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Iznjie[ .-]Biznjie)\\b",
      "name": "Iznjie Biznjie",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kaleido)\\b",
      "name": "Kaleido",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(karios)\\b",
      "name": "karios",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(kBaraka)\\b",
      "name": "kBaraka",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(kmplx)\\b",
      "name": "kmplx",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Koitern)\\b",
      "name": "Koitern",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Koten[ ._-]Gars)\\b",
      "name": "Koten_Gars",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kulot)\\b",
      "name": "Kulot",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Lia\\]|-Lia\\b",
      "name": "Lia",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MCLR)\\b",
      "name": "MCLR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(mottoj)\\b",
      "name": "mottoj",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NH)\\b",
      "name": "NH",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NTRM)\\b",
      "name": "NTRM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Orphan\\]|-Orphan\\b",
      "name": "Orphan",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(RMX)\\b",
      "name": "RMX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SallySubs)\\b",
      "name": "SallySubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Scriptum)\\b",
      "name": "Scriptum",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ShadyCrab)\\b",
      "name": "ShadyCrab",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SNSbu)\\b",
      "name": "SNSbu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[SOLA\\]|-SOLA\\b",
      "name": "SOLA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(THORA)\\b",
      "name": "THORA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Tsundere\\]|-Tsundere(?!-)\\b",
      "name": "Tsundere",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(UWU)\\b",
      "name": "UWU",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(xPearse)\\b",
      "name": "xPearse",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('96', 'Anime BD Tier 05 (Remuxes)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BluDragon)\\b",
      "name": "BluDragon",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CRUCiBLE)\\b",
      "name": "CRUCiBLE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(D4C)\\b",
      "name": "D4C",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(E[.-]N[.-]D)\\b",
      "name": "E.N.D",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PMR)\\b.*(Remux)",
      "name": "PMR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Raizel)\\b",
      "name": "Raizel",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(REVO)\\b",
      "name": "REVO",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SRLS)\\b",
      "name": "SRLS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TTGA)\\b",
      "name": "TTGA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[VULCAN\\]|-VULCAN\\b",
      "name": "VULCAN",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('97', 'Anime BD Tier 06 (FanSubs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Afro\\]|-Afro\\b",
      "name": "Afro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Akai\\]|-Akai\\b",
      "name": "Akai",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Almighty\\]|-Almighty\\b",
      "name": "Almighty",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[ANE\\]|-ANE$",
      "name": "ANE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Asenshi)\\b",
      "name": "Asenshi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BlurayDesuYo)\\b",
      "name": "BlurayDesuYo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Bunny-Apocalypse)\\b",
      "name": "Bunny-Apocalypse",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[CH\\]|-CH\\b",
      "name": "CH",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(EJF)\\b",
      "name": "EJF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Exiled-Destiny|E-D)\\b",
      "name": "Exiled-Destiny",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(FFF)\\b",
      "name": "FFF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Final8)\\b",
      "name": "Final8",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GS)\\b",
      "name": "GS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Harunatsu\\]|-Harunatsu\\b",
      "name": "Harunatsu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Impatience\\]|-Impatience\\b",
      "name": "Impatience",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Inka-Subs)\\b",
      "name": "Inka-Subs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Judgment\\]|-Judgment\\b",
      "name": "Judgement",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Kantai\\]|-Kantai\\b",
      "name": "Kantai",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LCE)\\b",
      "name": "LCE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Licca)\\b",
      "name": "Licca",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Nii-sama\\]|-Nii-sama\\b",
      "name": "Nii-sama",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(niizk)\\b",
      "name": "niizk",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Nishi-Taku)\\b",
      "name": "Nishi-Taku",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(OnDeed)\\b",
      "name": "OnDeed",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(orz)\\b",
      "name": "orz",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PAS)\\b",
      "name": "PAS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(peachflavored)\\b",
      "name": "peachflavored",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Saizen)\\b",
      "name": "Saizen",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SCP-2223)\\b",
      "name": "SCP-2223",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SHiN-gx)\\b",
      "name": "SHiN-gx",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SmugCat)\\b",
      "name": "SmugCat",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Soldado\\]|-Soldado\\b",
      "name": "Soldado",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Sushi\\]|-Sushi\\b",
      "name": "Sushi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Vivid\\]|-Vivid\\b",
      "name": "Vivid",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Watashi\\]|-Watashi\\b",
      "name": "Watashi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Yabai\\]|-Yabai\\b",
      "name": "Yabai",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Zurako)\\b",
      "name": "Zurako",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('98', 'Anime BD Tier 07 (P2P/Scene)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(A-L)\\b",
      "name": "A-L",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ANiHLS)\\b",
      "name": "ANiHLS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CBM)\\b",
      "name": "CBM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DHD)\\b",
      "name": "DHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DragsterPS)\\b",
      "name": "DragsterPS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HAiKU)\\b",
      "name": "HAiKU",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Hark0N)\\b",
      "name": "Hark0N",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(iAHD)\\b",
      "name": "iAHD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(inid4c)\\b",
      "name": "inid4c",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KS|KiyoshiStar)\\b",
      "name": "KiyoshiStar",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MCR)\\b",
      "name": "MCR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[NPC\\]|-NPC\\b",
      "name": "NPC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(RedBlade)\\b",
      "name": "RedBlade",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(RH)\\b",
      "name": "RH",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SEV)\\b",
      "name": "SEV",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[STRiFE\\]|-STRiFE\\b",
      "name": "STRiFE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TENEIGHTY)\\b",
      "name": "TENEIGHTY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(WaLMaRT)\\b",
      "name": "WaLMaRT",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('99', 'Anime BD Tier 08 (Mini Encodes)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 9,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Bluray",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 5,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "DVD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AkihitoSubs)\\b",
      "name": "AkihitoSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Arukoru)\\b",
      "name": "Arukoru",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[EDGE\\]|-EDGE\\b",
      "name": "EDGE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[EMBER\\]|-EMBER\\b",
      "name": "EMBER",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[GHOST\\]|-GHOST\\b",
      "name": "GHOST",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Judas\\]|-Judas",
      "name": "Judas",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[naiyas\\]|-naiyas\\b",
      "name": "naiyas",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Nep[ ._-]Blanc)\\b",
      "name": "Nep_Blanc",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Prof\\]|-Prof\\b",
      "name": "Prof",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Shir\u03C3)\\b",
      "name": "Shir\u03C3",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[YURASUKA\\]|-YURASUKA\\b",
      "name": "YURASAKA",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('100', 'Anime Web Tier 01 (Muxers)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Arg0)\\b",
      "name": "Arg0",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Arid\\]|-Arid\\b",
      "name": "Arid",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Baws)\\b",
      "name": "Baws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LostYears)\\b",
      "name": "LostYears",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LYS1TH3A)\\b",
      "name": "LYS1TH3A",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[sam\\]|-sam\\b",
      "name": "sam",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SCY)\\b",
      "name": "SCY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Setsugen)\\b",
      "name": "Setsugen",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[smol\\]|-smol\\b",
      "name": "smol",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Vodes\\]|(?\u003C!Not)-Vodes\\b",
      "name": "Vodes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Z4ST1N)\\b",
      "name": "Z4ST1N",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ZeroBuild)\\b",
      "name": "ZeroBuild",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('101', 'Anime Web Tier 02 (Top FanSubs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(0x539)\\b",
      "name": "0x539",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Asakura\\]|-Asakura\\b",
      "name": "Asakura",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Cyan\\]|-Cyan\\b",
      "name": "Cyan",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Dae\\]|-Dae\\b",
      "name": "Dae",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Foxtrot\\]|-Foxtrot\\b",
      "name": "Foxtrot",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Gao\\]|-Gao\\b",
      "name": "Gao",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GSK[._-]kun)\\b",
      "name": "GSK_kun",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HatSubs)\\b",
      "name": "HatSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MTBB)\\b",
      "name": "MTBB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Not-Vodes\\]|-Not-Vodes\\b",
      "name": "Not-Vodes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Okay-Subs)\\b",
      "name": "Okay-Subs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Pizza\\]|-Pizza\\b",
      "name": "Pizza",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Reza)\\b",
      "name": "Reza",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Slyfox)\\b",
      "name": "Slyfox",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SoLCE)\\b",
      "name": "SoLCE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[tenshi\\]|-tenshi$",
      "name": "Tenshi",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('102', 'Anime Web Tier 03 (Official Subs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SubsPlease)\\b",
      "name": "SubsPlease",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SubsPlus\\\u002B?)\\b",
      "name": "SubsPlus\u002B",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ZR)\\b",
      "name": "ZR",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('103', 'Anime Web Tier 04 (Official Subs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BlueLobster)\\b",
      "name": "BlueLobster",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Erai-raws)\\b",
      "name": "Erai-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GST)\\b",
      "name": "GST",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HorribleRips)\\b",
      "name": "HorribleRips",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HorribleSubs)\\b",
      "name": "HorribleSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KAN3D2M)\\b",
      "name": "KAN3D2M",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KS|KiyoshiStar)\\b",
      "name": "KiyoshiStar",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Lia\\]|-Lia\\b",
      "name": "Lia",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NanDesuKa)\\b",
      "name": "NanDesuKa",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(URANIME)\\b",
      "name": "URANIME",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(VARYG)\\b",
      "name": "VARYG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[ZigZag\\]|-ZigZab\b",
      "name": "ZigZag",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('104', 'Anime Web Tier 05 (FanSubs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(9volt)\\b",
      "name": "9volt",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GJM)\\b",
      "name": "GJM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kaleido)\\b",
      "name": "Kaleido",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Kantai\\]|-Kantai\\b",
      "name": "Kantai",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SobsPlease)\\b",
      "name": "SobsPlease",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('105', 'Anime Web Tier 06 (FanSubs)', '[
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Asenshi)\\b",
      "name": "Asenshi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Chihiro\\]|-Chihiro\\b",
      "name": "Chihiro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Commie)\\b",
      "name": "Commie",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DameDesuYo)\\b",
      "name": "DameDesuYo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Doki\\]|-Doki\\b",
      "name": "Doki",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Tsundere\\]|-Tsundere(?!-)\\b",
      "name": "Tsundere",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('106', 'Anime Raws', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Asuka[ ._-]?(Raws)",
      "name": "AsukaRaws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Beatrice[ ._-]?(Raws)",
      "name": "Beatrice-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Daddy[ ._-]?(Raws)",
      "name": "Daddy-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Fumi[ ._-]?(Raws)",
      "name": "Fumi-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Iriza[ ._-]?(Raws)",
      "name": "IrizaRaws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Kawaiika[ ._-]?(Raws)",
      "name": "Kawaiika-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[km\\]|-km\\b",
      "name": "km",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Koi[ ._-]?(Raws)",
      "name": "Koi-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Lilith[ ._-]?(Raws)",
      "name": "Lilith-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "LowPower[ ._-]?(Raws)",
      "name": "LowPower-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Moozzi2)\\b",
      "name": "Moozzi2",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Nanako[ ._-]?(Raws)",
      "name": "NanakoRaws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "NC[ ._-]?(Raws)",
      "name": "NC-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "neko[ ._-]?(raws)",
      "name": "neko-raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "New[ ._-]?(raws)",
      "name": "New-raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Ohys[ ._-]?(Raws)",
      "name": "Ohys-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Pandoratv[ ._-]?(Raws)",
      "name": "Pandoratv-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Raws-Maji)\\b",
      "name": "Raws-Maji",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ReinForce)\\b",
      "name": "ReinForce",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Scryous[ ._-]?(Raws)",
      "name": "Scryous-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Seicher[ ._-]?(Raws)",
      "name": "Seicher-Raws",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "Shiniori[ ._-]?(Raws)",
      "name": "Shiniori-Raws",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('107', 'Anime LQ Groups', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(\\$tore-Chill)\\b",
      "name": "$tore-Chill",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(0neshot)\\b",
      "name": "0neshot",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[224\\]|-224\\b",
      "name": "224",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(A-Destiny)\\b",
      "name": "A-Destiny",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AceAres)\\b",
      "name": "AceAres",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AhmadDev)\\b",
      "name": "AhmadDev",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Anime[ .-]?Chap)\\b",
      "name": "Anime Chap",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Anime[ .-]?Land)\\b",
      "name": "Anime Land",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Anime[ .-]?Time)\\b",
      "name": "Anime Time",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AnimeDynastyEN)\\b",
      "name": "AnimeDynastyEN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AnimeKuro)\\b",
      "name": "AnimeKuro",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AnimeRG)\\b",
      "name": "AnimeRG",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Animesubs)\\b",
      "name": "Animesubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AnimeTR)\\b",
      "name": "AnimeTR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Anitsu)\\b",
      "name": "Anitsu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AniVoid)\\b",
      "name": "AniVoid",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ArataEnc)\\b",
      "name": "ArataEnc",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(AREY)\\b",
      "name": "AREY",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Ari\\]|-Ari\\b",
      "name": "Ari",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ASW)\\b",
      "name": "ASW",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BJX)\\b",
      "name": "BJX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(BlackLuster)\\b",
      "name": "BlackLuster",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(bonkai77)\\b",
      "name": "bonkai77",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CameEsp)\\b",
      "name": "CameEsp",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Cat66)\\b",
      "name": "Cat66",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CBB)\\b",
      "name": "CBB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Cerberus\\]|-Cerberus\\b",
      "name": "Cerberus",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Cleo\\]|-Cleo",
      "name": "Cleo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(CuaP)\\b",
      "name": "CuaP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Daddy(Subs)?\\]|-Daddy(Subs)?\\b",
      "name": "DaddySubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DARKFLiX)\\b",
      "name": "DARKFLiX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[DB\\]",
      "name": "DB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DBArabic)\\b",
      "name": "DBArabic",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Deadmau[ .-]?[ .-]?RAWS)\\b",
      "name": "Deadmau- RAWS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DKB)\\b",
      "name": "DKB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DP)\\b",
      "name": "DP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(DsunS)\\b",
      "name": "DsunS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Emmid\\]|-Emmid\\b",
      "name": "Emmid",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ExREN)\\b",
      "name": "ExREN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[FAV\\]|-FAV\\b",
      "name": "FAV",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b((Baked|Dead|Space)Fish)\\b",
      "name": "Fish",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(FunArts)\\b",
      "name": "FunArts",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(GERMini)\\b",
      "name": "GERMini",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Hakata[ .-]?Ramen)\\b",
      "name": "Hakata Ramen",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Hall_of_C)\\b",
      "name": "Hall_of_C",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Hatsuyuki\\]|-Hatsuyuki\\b",
      "name": "Hatsuyuki",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HAV1T)\\b",
      "name": "HAV1T",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HENiL)\\b",
      "name": "HENiL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Hitoku\\]|-Hitoki\\b",
      "name": "Hitoku",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HollowRoxas)\\b",
      "name": "HollowRoxas",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(HR)\\b",
      "name": "HR",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(ICEBLUE)\\b",
      "name": "ICEBLUE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(iPUNISHER)\\b",
      "name": "iPUNISHER",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(JacobSwaggedUp)\\b",
      "name": "JacobSwaggedUp",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Johnny-englishsubs)\\b",
      "name": "Johnny-englishsubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Kallango\\]|-Kallango\\b",
      "name": "Kallango",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kanjouteki)\\b",
      "name": "Kanjouteki",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KEKMASTERS)\\b",
      "name": "KEKMASTERS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Kirion)\\b",
      "name": "Kirion",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KQRM)\\b",
      "name": "KQRM",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KRP)\\b",
      "name": "KRP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(LoliHouse)\\b",
      "name": "LoliHouse",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(M@nI)\\b",
      "name": "M@nI",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(mal[ .-]lu[ .-]zen)\\b",
      "name": "mal lu zen",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Man\\.K)\\b",
      "name": "Man.K",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Maximus\\]|-Maximus\\b",
      "name": "Maximus",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[MD\\]|-MD\\b",
      "name": "MD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(mdcx)\\b",
      "name": "mdcx",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Metaljerk)\\b",
      "name": "Metaljerk",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MGD)\\b",
      "name": "MGD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MiniFreeza)\\b",
      "name": "MiniFreeza",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MiniMTBB)\\b",
      "name": "MiniMTBB",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MinisCuba)\\b",
      "name": "MinisCuba",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(MiniTheatre)\\b",
      "name": "MiniTheatre",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Mites)\\b",
      "name": "Mites",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Modders[ .-]?Bay)\\b",
      "name": "Modders Bay",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Mr\\.Deadpool)\\b",
      "name": "Mr. Deadpool",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NemDiggers)\\b",
      "name": "NemDiggers",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(neoHEVC)\\b",
      "name": "neoHEVC",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Nokou)\\b",
      "name": "Nokou",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(N[eo][wo]b[ ._-]?Subs)\\b",
      "name": "NoobSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(NS)\\b",
      "name": "NS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Nyanpasu)\\b",
      "name": "Nyanpasu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(OldCastle)\\b",
      "name": "OldCastle",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Pantsu\\]|-Pantsu\\b",
      "name": "Pantsu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Pao\\]|-Pao\\b",
      "name": "Pao",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(phazer11)\\b",
      "name": "phazer11",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Pixel\\]|-Pixel\\b",
      "name": "Pixel",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Plex[ .-]?Friendly)\\b",
      "name": "Plex Friendly",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PnPSubs)\\b",
      "name": "PnPSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Polarwindz)\\b",
      "name": "Polarwindz",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Project-gxs)\\b",
      "name": "Project-gxs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(PuyaSubs)\\b",
      "name": "PuyaSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(QAS)\\b",
      "name": "QaS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(QCE)\\b",
      "name": "QCE",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Rando235)\\b",
      "name": "Rando235",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Ranger\\]|-Ranger\\b",
      "name": "Ranger",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Rapta\\]|-Rapta\\b",
      "name": "Rapta",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(M2TS|BDMV|BDVD)\\b",
      "name": "Raw Files",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Raze\\]|-Raze\\b",
      "name": "Raze",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Reaktor)\\b",
      "name": "Reaktor",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(RightShiftBy2)\\b",
      "name": "RightShiftBy2",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Rip[ .-]?Time)\\b",
      "name": "Rip Time",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[SAD\\]|-SAD\\b",
      "name": "SAD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Salieri)\\b",
      "name": "Salieri",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Samir755)\\b",
      "name": "Samir755",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SanKyuu)\\b",
      "name": "SanKyuu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[SEiN\\]|-SEiN\\b",
      "name": "SEiN",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(sekkusu\u0026ok)\\b",
      "name": "sekkusu\u0026ok",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SHFS)\\b",
      "name": "SHFS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SLAX)\\b",
      "name": "SLAX",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Sokudo\\]|-Sokudo\\b",
      "name": "Sokudo",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SRW)\\b",
      "name": "SRW",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(SSA)\\b",
      "name": "SSA",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(StrayGods)\\b",
      "name": "StrayGods",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Suki[ .-]?Desu\\]|-Suki[ .-]?Desu\\b",
      "name": "Suki Desu",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TeamTurquoize)\\b",
      "name": "TeamTurquoize",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Tenrai[ .-]?Sensei)\\b",
      "name": "Tenrai Sensei",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TnF)\\b",
      "name": "TnF",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(TOPKEK)\\b",
      "name": "TOPKEK",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Trix\\]|-Trix\\b",
      "name": "Trix",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(U3-Web)\\b",
      "name": "U3-Web",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[UNBIASED\\]|-UNBIASED\\b",
      "name": "UNBIASED",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[uP\\]",
      "name": "uP",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[USD\\]|-USD\\b",
      "name": "USD",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Valenciano)\\b",
      "name": "Valenciano",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(VipapkStudios)\\b",
      "name": "VipapkStudios",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Wardevil\\]|-Wardevil\\b",
      "name": "Wardevil",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(WtF[ ._-]?Anime)\\b",
      "name": "WtF Anime",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(xiao-av1)\\b",
      "name": "xiao-av1",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Yabai_Desu_NeRandomRemux)\\b",
      "name": "Yabai_Desu_NeRandomRemux",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(YakuboEncodes)\\b",
      "name": "YakuboEncodes",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(youshikibi)\\b",
      "name": "youshikibi",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(YuiSubs)\\b",
      "name": "YuiSubs",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Yun\\]|-Yun\\b",
      "name": "Yun",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[zza\\]|-zza\\b",
      "name": "zza",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('108', 'Uncensored', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Uncut|Unrated|Uncensored|AT[-_. ]?X)\\b",
      "name": "Uncensored",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('109', 'v0', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(\\b|\\d)(v0)\\b",
      "name": "v0",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('110', 'v1', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(\\b|\\d)(v1)\\b",
      "name": "v1",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('111', 'v2', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(\\b|\\d)(v2)\\b",
      "name": "v2",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('112', 'v3', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(\\b|\\d)(v3)\\b",
      "name": "v3",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('113', 'v4', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "(\\b|\\d)(v4)\\b",
      "name": "v4",
      "negate": false,
      "required": true
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('114', 'VRV', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(vrv)\\b",
      "name": "VRV",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 7,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBDL",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SourceSpecification",
    "body": {
      "order": 5,
      "implementationName": "Source",
      "value": 8,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "WEBRIP",
      "negate": false,
      "required": false
    }
  }
]', '1');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('115', '10bit', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "10[.-]?bit",
      "name": "10bit",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "hi10p",
      "name": "hi10p",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('116', 'Anime Dual Audio', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "dual[ ._-]?(audio|varyg)|[([]dual[])]|(JA|ZH|KO)\\\u002BEN|EN\\\u002B(JA|ZH|KO)",
      "name": "Dual Audio",
      "negate": false,
      "required": true
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[(JA|ZH|KO)\\]",
      "name": "Not Single Language Only",
      "negate": true,
      "required": true
    }
  },
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": 8,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Japanese Language",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": 10,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Chinese Language",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "LanguageSpecification",
    "body": {
      "order": 3,
      "implementationName": "Language",
      "value": 21,
      "exceptLanguage": false,
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "name": "Korean Language",
      "negate": false,
      "required": false
    }
  }
]', '0');
INSERT INTO CustomFormats (Id, Name, Specifications, IncludeCustomFormatWhenRenaming) VALUES ('117', 'Dubs Only', '[
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?!.*(Dual|Multi)[-_. ]?Audio).*((?\u003C!multi-)\\b(dub(bed)?)\\b|(funi|eng(lish)?)_?dub)",
      "name": "Dubbed",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(Golumpa)\\b",
      "name": "Golumpa",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?!.*(dual[ ._-]?audio|[([]dual[])]|(JA|ZH|KO)\\\u002BEN|EN\\\u002B(JA|ZH|KO))).*\\b(KaiDubs)\\b",
      "name": "KaiDubs (Not Dual Audio)",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(KamiFS)\\b",
      "name": "KamiFS",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "^(?!.*(dual[ ._-]?audio|[([]dual[])]|(JA|ZH|KO)\\\u002BEN|EN\\\u002B(JA|ZH|KO))).*\\bKS\\b",
      "name": "KS (Not Dual Audio)",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\b(torenter69)\\b",
      "name": "torenter69",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "ReleaseTitleSpecification",
    "body": {
      "order": 1,
      "implementationName": "Release Title",
      "infoLink": "https://wiki.servarr.com/radarr/settings#custom-formats-2",
      "value": "\\[Yameii\\]|-Yameii\\b",
      "name": "Yameii",
      "negate": false,
      "required": false
    }
  }
]', '0');

DELETE FROM QualityDefinitions; 
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('1', '0', 'Unknown', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('2', '24', 'WORKPRINT', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('3', '25', 'CAM', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('4', '26', 'TELESYNC', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('5', '27', 'TELECINE', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('6', '29', 'REGIONAL', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('7', '28', 'DVDSCR', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('8', '1', 'SDTV', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('9', '2', 'DVD', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('10', '23', 'DVD-R', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('11', '8', 'WEBDL-480p', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('12', '12', 'WEBRip-480p', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('13', '20', 'Bluray-480p', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('14', '21', 'Bluray-576p', '0', '100', '95');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('15', '4', 'HDTV-720p', '17.1', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('16', '5', 'WEBDL-720p', '12.5', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('17', '14', 'WEBRip-720p', '12.5', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('18', '6', 'Bluray-720p', '25.7', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('19', '9', 'HDTV-1080p', '33.8', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('20', '3', 'WEBDL-1080p', '12.5', NULL, '1999');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('21', '15', 'WEBRip-1080p', '12.5', NULL, '99');
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('22', '7', 'Bluray-1080p', '50.8', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('23', '30', 'Remux-1080p', '102', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('24', '16', 'HDTV-2160p', '85', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('25', '18', 'WEBDL-2160p', '34.5', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('26', '17', 'WEBRip-2160p', '34.5', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('27', '19', 'Bluray-2160p', '102', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('28', '31', 'Remux-2160p', '187.4', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('29', '22', 'BR-DISK', '0', NULL, NULL);
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize) VALUES ('30', '10', 'Raw-HD', '0', NULL, NULL);
