-- TODO : Table Config check pass
-- TODO : DownloadClients change access
-- TODO : API key to change into Indexer

-- AutoTagging
DELETE FROM AutoTagging;
INSERT INTO AutoTagging (Id, Name, Specifications, RemoveTagsAutomatically, Tags)
VALUES
(1, 'anime', '[
  {
    "type": "RootFolderSpecification",
    "body": {
      "order": 1,
      "implementationName": "Root Folder",
      "value": "/data/media/anime",
      "name": "anime",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "SeriesTypeSpecification",
    "body": {
      "order": 2,
      "implementationName": "Series Type",
      "value": 2,
      "name": "anime",
      "negate": false,
      "required": false
    }
  }
]', 0, '[1]'),
(2, 'series', '[
  {
    "type": "SeriesTypeSpecification",
    "body": {
      "order": 2,
      "implementationName": "Series Type",
      "value": 0,
      "name": "series",
      "negate": false,
      "required": false
    }
  },
  {
    "type": "RootFolderSpecification",
    "body": {
      "order": 1,
      "implementationName": "Root Folder",
      "value": "/data/media/series",
      "name": "series",
      "negate": false,
      "required": false
    }
  }
]', 0, '[3]');

-- Config
DELETE FROM Config;
INSERT INTO Config (Id, Key, Value)
VALUES
(1, 'enablecompleteddownloadhandling', 'True'),
(2, 'plexclientidentifier', '6ff86444-e446-49f6-b703-d93348d995b4'),
(3, 'rijndaelpassphrase', '0352edf2-5863-40b8-875a-89df552f94a5'),
(4, 'hmacpassphrase', '0e8bab18-4c33-46a7-9a30-63a0cc8d5635'),
(5, 'rijndaelsalt', '5ad7b91e-609b-4985-a0b6-b1af5663944b'),
(6, 'hmacsalt', '342c5610-854e-469a-92b0-b7feb163a981'),
(7, 'cleanupmetadataimages', 'False'),
(8, 'firstdayofweek', '1'),
(9, 'calendarweekcolumnheader', 'ddd DD/MM'),
(10, 'timeformat', 'HH:mm'),
(11, 'autounmonitorpreviouslydownloadedepisodes', 'True');

-- DelayProfiles
DELETE FROM DelayProfiles;
INSERT INTO DelayProfiles (Id, EnableUsenet, EnableTorrent, PreferredProtocol, UsenetDelay, TorrentDelay, "Order", Tags, BypassIfHighestQuality, BypassIfAboveCustomFormatScore, MinimumCustomFormatScore)
VALUES (1, 1, 1, 1, 0, 0, 2147483647, '[]', 1, 0, NULL);
-- DownloadClients
DELETE FROM DownloadClients;
INSERT INTO DownloadClients (Id, Enable, Name, Implementation, Settings, ConfigContract, Priority, RemoveCompletedDownloads, RemoveFailedDownloads, Tags)
VALUES
(3, 1, 'qbit-series', 'QBittorrent', '{
  "host": "localhost",
  "port": 8200,
  "useSsl": false,
  "username": "admin",
  "password": "Khaaz11!",
  "tvCategory": "series",
  "recentTvPriority": 0,
  "olderTvPriority": 0,
  "initialState": 0,
  "sequentialOrder": false,
  "firstAndLast": false,
  "contentLayout": 0
}', 'QBittorrentSettings', 1, 1, 1, '[3]'),
(4, 1, 'qbit-anime', 'QBittorrent', '{
  "host": "localhost",
  "port": 8200,
  "useSsl": false,
  "username": "admin",
  "password": "Khaaz11!",
  "tvCategory": "anime",
  "recentTvPriority": 0,
  "olderTvPriority": 0,
  "initialState": 0,
  "sequentialOrder": false,
  "firstAndLast": false,
  "contentLayout": 0
}', 'QBittorrentSettings', 1, 1, 1, '[1]');

-- Indexers
DELETE FROM Indexers;   
INSERT INTO Indexers (Id, Name, Implementation, Settings, ConfigContract, EnableRss, EnableAutomaticSearch, EnableInteractiveSearch, Priority, Tags, DownloadClientId, SeasonSearchMaximumSingleEpisodeAge)
VALUES
(1, '1337x (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/1/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000, 5040, 5030],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(2, 'The Pirate Bay (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/2/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000, 5050, 5040, 5045],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(3, 'Torrent9 (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/3/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(4, 'LimeTorrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/4/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(5, 'Badass Torrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/5/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(6, 'ExtraTorrent.st (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/7/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(7, 'EZTV (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/8/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(8, 'Internet Archive (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/9/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(9, 'kickasstorrents.ws (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/10/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(10, 'Torlock (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/11/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(11, 'BitSearch (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://localhost:9696/6/",
  "apiPath": "/api",
  "apiKey": "42dfafbdf737462597d4027ce30b0414",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0);

-- Metadata
DELETE FROM Metadata;   
INSERT INTO Metadata (Id, Enable, Name, Implementation, Settings, ConfigContract)
VALUES
(1, 0, 'Kodi (XBMC) / Emby', 'XbmcMetadata', '{
  "seriesMetadata": true,
  "seriesMetadataEpisodeGuide": false,
  "seriesMetadataUrl": false,
  "episodeMetadata": true,
  "episodeImageThumb": false,
  "seriesImages": true,
  "seasonImages": true,
  "episodeImages": true,
  "isValid": true
}', 'XbmcMetadataSettings'),
(2, 0, 'WDTV', 'WdtvMetadata', '{
  "episodeMetadata": true,
  "seriesImages": true,
  "seasonImages": true,
  "episodeImages": true,
  "isValid": true
}', 'WdtvMetadataSettings'),
(3, 0, 'Roksbox', 'RoksboxMetadata', '{
  "episodeMetadata": true,
  "seriesImages": true,
  "seasonImages": true,
  "episodeImages": true,
  "isValid": true
}', 'RoksboxMetadataSettings'),
(4, 0, 'Plex', 'PlexMetadata', '{
  "seriesPlexMatchFile": true,
  "episodeMappings": false
}', 'PlexMetadataSettings'),
(5, 0, 'Kometa', 'KometaMetadata', '{
  "seriesImages": true,
  "seasonImages": true,
  "episodeImages": true,
  "isValid": true
}', 'KometaMetadataSettings');

-- NamingConfig
DELETE FROM NamingConfig;
INSERT INTO NamingConfig (Id, MultiEpisodeStyle, RenameEpisodes, StandardEpisodeFormat, DailyEpisodeFormat, SeasonFolderFormat, SeriesFolderFormat, AnimeEpisodeFormat, ReplaceIllegalCharacters, SpecialsFolderFormat, ColonReplacementFormat, CustomColonReplacementFormat)
VALUES
(1, 5, 1, '{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', '{Series TitleYear} - {Air-Date} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', 'Season {season:00}', '{Series TitleYear} {imdb-{ImdbId}}', '{Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}[{MediaInfo VideoBitDepth}bit]{[MediaInfo VideoCodec]}[{Mediainfo AudioCodec} { Mediainfo AudioChannels}]{MediaInfo AudioLanguages}{-Release Group}', 1, 'Specials', 4, NULL);

-- QualityDefinitions
DELETE FROM QualityDefinitions;
INSERT INTO QualityDefinitions (Id, Quality, Title, MinSize, MaxSize, PreferredSize)
VALUES
(1, 0, 'Unknown', 1, 199.9, 95),
(2, 1, 'SDTV', 2, 100, 95),
(3, 12, 'WEBRip-480p', 2, 100, 95),
(4, 8, 'WEBDL-480p', 2, 100, 95),
(5, 2, 'DVD', 2, 100, 95),
(6, 13, 'Bluray-480p', 2, 100, 95),
(7, 22, 'Bluray-576p', 2, 100, 95),
(8, 4, 'HDTV-720p', 3, 125, 95),
(9, 9, 'HDTV-1080p', 4, 125, 95),
(10, 10, 'Raw-HD', 4, NULL, 95),
(11, 14, 'WEBRip-720p', 3, 130, 95),
(12, 5, 'WEBDL-720p', 3, 130, 95),
(13, 6, 'Bluray-720p', 4, 130, 95),
(14, 15, 'WEBRip-1080p', 4, 130, 95),
(15, 3, 'WEBDL-1080p', 4, 130, 95),
(16, 7, 'Bluray-1080p', 4, 155, 95),
(17, 20, 'Bluray-1080p Remux', 35, NULL, 95),
(18, 16, 'HDTV-2160p', 35, 199.9, 95),
(19, 17, 'WEBRip-2160p', 35, NULL, 95),
(20, 18, 'WEBDL-2160p', 35, NULL, 95),
(21, 19, 'Bluray-2160p', 35, NULL, 95),
(22, 21, 'Bluray-2160p Remux', 35, NULL, 95);

-- QualityProfiles
DELETE FROM QualityProfiles;    
INSERT INTO QualityProfiles (Id, Name, Cutoff, Items, UpgradeAllowed, FormatItems, MinFormatScore, CutoffFormatScore, MinUpgradeFormatScore)
VALUES
(1, 'Any', 1, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": true
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": true
      },
      {
        "quality": 8,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 2,
    "items": [],
    "allowed": true
  },
  {
    "quality": 13,
    "items": [],
    "allowed": true
  },
  {
    "quality": 22,
    "items": [],
    "allowed": true
  },
  {
    "quality": 4,
    "items": [],
    "allowed": true
  },
  {
    "quality": 9,
    "items": [],
    "allowed": true
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": true
      },
      {
        "quality": 5,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 6,
    "items": [],
    "allowed": true
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": true
      },
      {
        "quality": 3,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 7,
    "items": [],
    "allowed": true
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": false
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": false
      },
      {
        "quality": 18,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 19,
    "items": [],
    "allowed": false
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1),
(2, 'SD', 1, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": true
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": true
      },
      {
        "quality": 8,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 2,
    "items": [],
    "allowed": true
  },
  {
    "quality": 13,
    "items": [],
    "allowed": true
  },
  {
    "quality": 22,
    "items": [],
    "allowed": true
  },
  {
    "quality": 4,
    "items": [],
    "allowed": false
  },
  {
    "quality": 9,
    "items": [],
    "allowed": false
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": false
      },
      {
        "quality": 5,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 6,
    "items": [],
    "allowed": false
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": false
      },
      {
        "quality": 3,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 7,
    "items": [],
    "allowed": false
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": false
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": false
      },
      {
        "quality": 18,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 19,
    "items": [],
    "allowed": false
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1),
(3, 'HD-720p', 4, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": false
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": false
      },
      {
        "quality": 8,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 2,
    "items": [],
    "allowed": false
  },
  {
    "quality": 13,
    "items": [],
    "allowed": false
  },
  {
    "quality": 22,
    "items": [],
    "allowed": false
  },
  {
    "quality": 4,
    "items": [],
    "allowed": true
  },
  {
    "quality": 9,
    "items": [],
    "allowed": false
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": true
      },
      {
        "quality": 5,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 6,
    "items": [],
    "allowed": true
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": false
      },
      {
        "quality": 3,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 7,
    "items": [],
    "allowed": false
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": false
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": false
      },
      {
        "quality": 18,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 19,
    "items": [],
    "allowed": false
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1),
(4, 'HD-1080p', 9, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": false
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": false
      },
      {
        "quality": 8,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 2,
    "items": [],
    "allowed": false
  },
  {
    "quality": 13,
    "items": [],
    "allowed": false
  },
  {
    "quality": 22,
    "items": [],
    "allowed": false
  },
  {
    "quality": 4,
    "items": [],
    "allowed": false
  },
  {
    "quality": 9,
    "items": [],
    "allowed": true
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": false
      },
      {
        "quality": 5,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 6,
    "items": [],
    "allowed": false
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": true
      },
      {
        "quality": 3,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 7,
    "items": [],
    "allowed": true
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": false
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": false
      },
      {
        "quality": 18,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 19,
    "items": [],
    "allowed": false
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1),
(5, 'Ultra-HD', 16, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": false
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": false
      },
      {
        "quality": 8,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 2,
    "items": [],
    "allowed": false
  },
  {
    "quality": 13,
    "items": [],
    "allowed": false
  },
  {
    "quality": 22,
    "items": [],
    "allowed": false
  },
  {
    "quality": 4,
    "items": [],
    "allowed": false
  },
  {
    "quality": 9,
    "items": [],
    "allowed": false
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": false
      },
      {
        "quality": 5,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 6,
    "items": [],
    "allowed": false
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": false
      },
      {
        "quality": 3,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 7,
    "items": [],
    "allowed": false
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": true
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": true
      },
      {
        "quality": 18,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 19,
    "items": [],
    "allowed": true
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1),
(6, 'HD - 720p/1080p', 4, '[
  {
    "quality": 0,
    "items": [],
    "allowed": false
  },
  {
    "quality": 1,
    "items": [],
    "allowed": false
  },
  {
    "id": 1000,
    "name": "WEB 480p",
    "items": [
      {
        "quality": 12,
        "items": [],
        "allowed": false
      },
      {
        "quality": 8,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 2,
    "items": [],
    "allowed": false
  },
  {
    "quality": 13,
    "items": [],
    "allowed": false
  },
  {
    "quality": 22,
    "items": [],
    "allowed": false
  },
  {
    "quality": 4,
    "items": [],
    "allowed": true
  },
  {
    "quality": 9,
    "items": [],
    "allowed": true
  },
  {
    "quality": 10,
    "items": [],
    "allowed": false
  },
  {
    "id": 1001,
    "name": "WEB 720p",
    "items": [
      {
        "quality": 14,
        "items": [],
        "allowed": true
      },
      {
        "quality": 5,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 6,
    "items": [],
    "allowed": true
  },
  {
    "id": 1002,
    "name": "WEB 1080p",
    "items": [
      {
        "quality": 15,
        "items": [],
        "allowed": true
      },
      {
        "quality": 3,
        "items": [],
        "allowed": true
      }
    ],
    "allowed": true
  },
  {
    "quality": 7,
    "items": [],
    "allowed": true
  },
  {
    "quality": 20,
    "items": [],
    "allowed": false
  },
  {
    "quality": 16,
    "items": [],
    "allowed": false
  },
  {
    "id": 1003,
    "name": "WEB 2160p",
    "items": [
      {
        "quality": 17,
        "items": [],
        "allowed": false
      },
      {
        "quality": 18,
        "items": [],
        "allowed": false
      }
    ],
    "allowed": false
  },
  {
    "quality": 19,
    "items": [],
    "allowed": false
  },
  {
    "quality": 21,
    "items": [],
    "allowed": false
  }
]', 0, '[]', 0, 0, 1);
-- RemotePathMappings
DELETE FROM RemotePathMappings; 
INSERT INTO RemotePathMappings (Id, Host, RemotePath, LocalPath)
VALUES
(1, 'localhost', '/data/anime', '/data/torrents/anime/'),
(2, 'localhost', '/data/series/', '/data/torrents/series/');

-- RootFolders
DELETE FROM RootFolders;    
INSERT INTO RootFolders (Id, Path)
VALUES
(3, '/data/media/series/'),
(4, '/data/media/anime/');

-- ScheduledTasks
DELETE FROM ScheduledTasks;    
INSERT INTO ScheduledTasks (Id, TypeName, "Interval", LastExecution, LastStartTime)
VALUES
(1, 'NzbDrone.Core.Download.RefreshMonitoredDownloadsCommand', 1, '2025-01-15 22:12:38.1072735Z', '2025-01-15 22:12:38.0810045Z'),
(2, 'NzbDrone.Core.Messaging.Commands.MessagingCleanupCommand', 5, '2025-01-15 22:09:08.0506274Z', '2025-01-15 22:09:08.0441033Z'),
(3, 'NzbDrone.Core.Update.Commands.ApplicationUpdateCheckCommand', 360, '2025-01-15 21:03:39.8871483Z', '2025-01-15 21:03:39.7778351Z'),
(4, 'NzbDrone.Core.DataAugmentation.Scene.UpdateSceneMappingCommand', 180, '2025-01-15 21:03:41.4524798Z', '2025-01-15 21:03:37.2321778Z'),
(5, 'NzbDrone.Core.HealthCheck.CheckHealthCommand', 360, '2025-01-15 21:03:37.2219978Z', '2025-01-15 21:03:36.6709337Z'),
(6, 'NzbDrone.Core.Tv.Commands.RefreshSeriesCommand', 720, '2025-01-15 21:03:39.7417267Z', '2025-01-15 21:03:37.2246263Z'),
(7, 'NzbDrone.Core.Housekeeping.HousekeepingCommand', 1440, '2025-01-15 21:03:37.1243878Z', '2025-01-15 21:03:36.7170868Z'),
(8, 'NzbDrone.Core.MediaFiles.Commands.CleanUpRecycleBinCommand', 1440, '2025-01-15 21:03:36.7109034Z', '2025-01-15 21:03:36.6674313Z'),
(9, 'NzbDrone.Core.ImportLists.ImportListSyncCommand', 5, '2025-01-15 22:09:08.0498988Z', '2025-01-15 22:09:08.03872Z'),
(10, 'NzbDrone.Core.Backup.BackupCommand', 10080, '2025-01-12 18:34:15.5422287Z', '2025-01-12 18:34:14.9298165Z'),
(11, 'NzbDrone.Core.Indexers.RssSyncCommand', 15, '2025-01-15 22:05:47.0805502Z', '2025-01-15 22:05:37.9964147Z');
--- Tags
DELETE FROM Tags;
INSERT INTO Tags (Id, Label)
VALUES
(1, 'anime'),
(3, 'series');

-- Commands
DELETE FROM Commands;
INSERT INTO Commands (Id Name Body Priority Status QueuedAt StartedAt EndedAt Duration Exception Trigger Result) VALUES ('23742','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-14T20:36:40Z;
  lastStartTime: 2025-01-14T20:36:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','6','2025-01-14 20:51:54.172049Z','2025-01-14 20:51:54.1747654Z','2025-01-15 21:03:06.5605604Z','','','2','0'),('23743','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-14T20:36:40Z;
  lastStartTime: 2025-01-14T20:36:24Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6234621Z','2025-01-15 21:03:36.6510549Z','2025-01-15 21:04:05.5535055Z','00:00:28.9024506','','2','0'),('23744','CleanUpRecycleBin','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: CleanUpRecycleBin;
  lastExecutionTime: 2025-01-14T19:18:54Z;
  lastStartTime: 2025-01-14T19:18:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6597814Z','2025-01-15 21:03:36.6674313Z','2025-01-15 21:03:36.6872851Z','00:00:00.0198538','','2','0'),('23745','CheckHealth','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: CheckHealth;
  lastExecutionTime: 2025-01-14T19:18:54Z;
  lastStartTime: 2025-01-14T19:18:53Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6686482Z','2025-01-15 21:03:36.6709337Z','2025-01-15 21:03:37.2150854Z','00:00:00.5441517','','2','0'),('23746','Housekeeping','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: Housekeeping;
  lastExecutionTime: 2025-01-14T19:18:54Z;
  lastStartTime: 2025-01-14T19:18:53Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6718731Z','2025-01-15 21:03:36.7170868Z','2025-01-15 21:03:37.1143662Z','00:00:00.3972794','','2','0'),('23747','RefreshSeries','{
  seriesIds: [];
  isNewSeries: false;
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  isLongRunning: true;
  completionMessage: Completed;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RefreshSeries;
  lastExecutionTime: 2025-01-14T19:18:55Z;
  lastStartTime: 2025-01-14T19:18:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6823734Z','2025-01-15 21:03:37.2246263Z','2025-01-15 21:03:39.2738558Z','00:00:02.0492295','','2','0'),('23748','UpdateSceneMapping','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: UpdateSceneMapping;
  lastExecutionTime: 2025-01-14T19:18:55Z;
  lastStartTime: 2025-01-14T19:18:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.6917201Z','2025-01-15 21:03:37.2321778Z','2025-01-15 21:03:41.4327042Z','00:00:04.2005264','','2','0'),('23749','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-14T20:50:54Z;
  lastStartTime: 2025-01-14T20:50:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.7079058Z','2025-01-15 21:03:39.7434895Z','2025-01-15 21:03:39.7604742Z','00:00:00.0169847','','2','0'),('23750','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-14T20:50:54Z;
  lastStartTime: 2025-01-14T20:50:54Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.7137393Z','2025-01-15 21:03:39.7666015Z','2025-01-15 21:03:39.7745097Z','00:00:00.0079082','','2','0'),('23751','ApplicationUpdateCheck','{
  sendUpdatesToClient: true;
  installMajorUpdate: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ApplicationUpdateCheck;
  lastExecutionTime: 2025-01-14T19:18:53Z;
  lastStartTime: 2025-01-14T19:18:53Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:36.7192607Z','2025-01-15 21:03:39.7778351Z','2025-01-15 21:03:39.882839Z','00:00:00.1050039','','2','0'),('23752','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-14T20:51:24Z;
  lastStartTime: 2025-01-14T20:51:24Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:03:36.7247595Z','2025-01-15 21:03:37.1267097Z','2025-01-15 21:03:37.2046462Z','00:00:00.0779365','','2','0'),('23753','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:03:37.1953551Z','2025-01-15 21:03:37.2089267Z','2025-01-15 21:03:37.228658Z','00:00:00.0197313','','0','0'),('23754','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:03:37Z;
  lastStartTime: 2025-01-15T21:03:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:05:07.0830236Z','2025-01-15 21:05:07.0931828Z','2025-01-15 21:05:07.1589363Z','00:00:00.0657535','','2','0'),('23755','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:05:07.154669Z','2025-01-15 21:05:07.1612813Z','2025-01-15 21:05:07.1658825Z','00:00:00.0046012','','0','0'),('23756','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:05:07Z;
  lastStartTime: 2025-01-15T21:05:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:06:37.1045481Z','2025-01-15 21:06:37.1100216Z','2025-01-15 21:06:37.1419185Z','00:00:00.0318969','','2','0'),('23757','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:06:37.1400236Z','2025-01-15 21:06:37.1419425Z','2025-01-15 21:06:37.1458955Z','00:00:00.0039530','','0','0'),('23758','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:06:37Z;
  lastStartTime: 2025-01-15T21:06:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:08:07.1240621Z','2025-01-15 21:08:07.1293687Z','2025-01-15 21:08:07.1688396Z','00:00:00.0394709','','2','0'),('23759','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:08:07.1670448Z','2025-01-15 21:08:07.1688556Z','2025-01-15 21:08:07.1724698Z','00:00:00.0036142','','0','0'),('23760','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:03:39Z;
  lastStartTime: 2025-01-15T21:03:39Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:09:07.1439907Z','2025-01-15 21:09:07.1484033Z','2025-01-15 21:09:07.1552636Z','00:00:00.0068603','','2','0'),('23761','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:03:39Z;
  lastStartTime: 2025-01-15T21:03:39Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:09:07.1491982Z','2025-01-15 21:09:07.1530983Z','2025-01-15 21:09:07.1626348Z','00:00:00.0095365','','2','0'),('23762','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:08:07Z;
  lastStartTime: 2025-01-15T21:08:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:09:37.1600402Z','2025-01-15 21:09:37.1639577Z','2025-01-15 21:09:37.1977725Z','00:00:00.0338148','','2','0'),('23763','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:09:37.1932692Z','2025-01-15 21:09:37.1978532Z','2025-01-15 21:09:37.2034474Z','00:00:00.0055942','','0','0'),('23764','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:09:37Z;
  lastStartTime: 2025-01-15T21:09:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:11:07.1681295Z','2025-01-15 21:11:07.1717399Z','2025-01-15 21:11:07.1969801Z','00:00:00.0252402','','2','0'),('23765','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:11:07.1930952Z','2025-01-15 21:11:07.1970397Z','2025-01-15 21:11:07.2014319Z','00:00:00.0043922','','0','0'),('23766','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:11:07Z;
  lastStartTime: 2025-01-15T21:11:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:12:37.178541Z','2025-01-15 21:12:37.184033Z','2025-01-15 21:12:37.2162668Z','00:00:00.0322338','','2','0'),('23767','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:12:37.2127928Z','2025-01-15 21:12:37.2162864Z','2025-01-15 21:12:37.2192665Z','00:00:00.0029801','','0','0'),('23768','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:09:07Z;
  lastStartTime: 2025-01-15T21:09:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:14:07.190234Z','2025-01-15 21:14:07.1956919Z','2025-01-15 21:14:07.2024043Z','00:00:00.0067124','','2','0'),('23769','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:09:07Z;
  lastStartTime: 2025-01-15T21:09:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:14:07.1964943Z','2025-01-15 21:14:07.2004801Z','2025-01-15 21:14:07.2029476Z','00:00:00.0024675','','2','0'),('23770','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:12:37Z;
  lastStartTime: 2025-01-15T21:12:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:14:07.2013389Z','2025-01-15 21:14:07.2042737Z','2025-01-15 21:14:07.229496Z','00:00:00.0252223','','2','0'),('23771','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:14:07.2283563Z','2025-01-15 21:14:07.229511Z','2025-01-15 21:14:07.2316159Z','00:00:00.0021049','','0','0'),('23772','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:14:07Z;
  lastStartTime: 2025-01-15T21:14:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:15:37.2118124Z','2025-01-15 21:15:37.2251626Z','2025-01-15 21:15:37.2465594Z','00:00:00.0213968','','2','0'),('23773','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:15:37.2451848Z','2025-01-15 21:15:37.2465847Z','2025-01-15 21:15:37.2477904Z','00:00:00.0012057','','0','0'),('23774','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:15:37Z;
  lastStartTime: 2025-01-15T21:15:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:17:07.2300939Z','2025-01-15 21:17:07.2355443Z','2025-01-15 21:17:07.2680041Z','00:00:00.0324598','','2','0'),('23775','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:17:07.2665758Z','2025-01-15 21:17:07.2682159Z','2025-01-15 21:17:07.2728925Z','00:00:00.0046766','','0','0'),('23776','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:17:07Z;
  lastStartTime: 2025-01-15T21:17:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:18:37.245148Z','2025-01-15 21:18:37.2522594Z','2025-01-15 21:18:37.275902Z','00:00:00.0236426','','2','0'),('23777','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:18:37.2738189Z','2025-01-15 21:18:37.2760879Z','2025-01-15 21:18:37.2801461Z','00:00:00.0040582','','0','0'),('23778','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-15T21:04:05Z;
  lastStartTime: 2025-01-15T21:03:36Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:19:07.2574663Z','2025-01-15 21:19:07.2636805Z','2025-01-15 21:19:16.1594871Z','00:00:08.8958066','','2','0'),('23779','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:14:07Z;
  lastStartTime: 2025-01-15T21:14:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:19:07.2640927Z','2025-01-15 21:19:07.2673091Z','2025-01-15 21:19:07.2707598Z','00:00:00.0034507','','2','0'),('23780','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:14:07Z;
  lastStartTime: 2025-01-15T21:14:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:19:07.2676491Z','2025-01-15 21:19:07.271701Z','2025-01-15 21:19:07.280864Z','00:00:00.0091630','','2','0'),('23781','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:18:37Z;
  lastStartTime: 2025-01-15T21:18:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:20:07.2796723Z','2025-01-15 21:20:07.2844907Z','2025-01-15 21:20:07.3082359Z','00:00:00.0237452','','2','0'),('23782','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:20:07.3065822Z','2025-01-15 21:20:07.3082426Z','2025-01-15 21:20:07.3094009Z','00:00:00.0011583','','0','0'),('23783','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:20:07Z;
  lastStartTime: 2025-01-15T21:20:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:21:07.3261496Z','2025-01-15 21:21:07.331468Z','2025-01-15 21:21:07.3505028Z','00:00:00.0190348','','2','0'),('23784','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:21:07.3490798Z','2025-01-15 21:21:07.3505597Z','2025-01-15 21:21:07.352992Z','00:00:00.0024323','','0','0'),('23785','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:21:07Z;
  lastStartTime: 2025-01-15T21:21:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:22:37.3439533Z','2025-01-15 21:22:37.3503289Z','2025-01-15 21:22:37.3750827Z','00:00:00.0247538','','2','0'),('23786','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:22:37.3703263Z','2025-01-15 21:22:37.3751258Z','2025-01-15 21:22:37.3805413Z','00:00:00.0054155','','0','0'),('23787','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:19:07Z;
  lastStartTime: 2025-01-15T21:19:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:24:07.357483Z','2025-01-15 21:24:07.361357Z','2025-01-15 21:24:07.3670222Z','00:00:00.0056652','','2','0'),('23788','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:19:07Z;
  lastStartTime: 2025-01-15T21:19:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:24:07.3620974Z','2025-01-15 21:24:07.3659747Z','2025-01-15 21:24:07.3701781Z','00:00:00.0042034','','2','0'),('23789','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:22:37Z;
  lastStartTime: 2025-01-15T21:22:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:24:07.3665036Z','2025-01-15 21:24:07.3697413Z','2025-01-15 21:24:07.3977731Z','00:00:00.0280318','','2','0'),('23790','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:24:07.3965771Z','2025-01-15 21:24:07.3977915Z','2025-01-15 21:24:07.402755Z','00:00:00.0049635','','0','0'),('23791','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:24:07Z;
  lastStartTime: 2025-01-15T21:24:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:25:37.3794988Z','2025-01-15 21:25:37.3851372Z','2025-01-15 21:25:37.4183888Z','00:00:00.0332516','','2','0'),('23792','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:25:37.4171732Z','2025-01-15 21:25:37.4184201Z','2025-01-15 21:25:37.4241671Z','00:00:00.0057470','','0','0'),('23793','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:25:37Z;
  lastStartTime: 2025-01-15T21:25:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:27:07.3913347Z','2025-01-15 21:27:07.3971562Z','2025-01-15 21:27:07.4220446Z','00:00:00.0248884','','2','0'),('23794','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:27:07.419572Z','2025-01-15 21:27:07.4220827Z','2025-01-15 21:27:07.4282105Z','00:00:00.0061278','','0','0'),('23795','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:27:07Z;
  lastStartTime: 2025-01-15T21:27:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:28:37.4018565Z','2025-01-15 21:28:37.4059765Z','2025-01-15 21:28:37.4254895Z','00:00:00.0195130','','2','0'),('23796','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:28:37.4240635Z','2025-01-15 21:28:37.4255204Z','2025-01-15 21:28:37.4304425Z','00:00:00.0049221','','0','0'),('23797','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:24:07Z;
  lastStartTime: 2025-01-15T21:24:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:29:07.4133615Z','2025-01-15 21:29:07.416984Z','2025-01-15 21:29:07.4243227Z','00:00:00.0073387','','2','0'),('23798','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:24:07Z;
  lastStartTime: 2025-01-15T21:24:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:29:07.4182594Z','2025-01-15 21:29:07.4238404Z','2025-01-15 21:29:07.4266462Z','00:00:00.0028058','','2','0'),('23799','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:28:37Z;
  lastStartTime: 2025-01-15T21:28:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:29:37.4301635Z','2025-01-15 21:29:37.4329416Z','2025-01-15 21:29:37.4841203Z','00:00:00.0511787','','2','0'),('23800','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:29:37.4737929Z','2025-01-15 21:29:37.4841622Z','2025-01-15 21:29:37.489869Z','00:00:00.0057068','','0','0'),('23801','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:29:37Z;
  lastStartTime: 2025-01-15T21:29:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:31:07.4425603Z','2025-01-15 21:31:07.4494629Z','2025-01-15 21:31:07.4777941Z','00:00:00.0283312','','2','0'),('23802','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:31:07.4761061Z','2025-01-15 21:31:07.477814Z','2025-01-15 21:31:07.4813297Z','00:00:00.0035157','','0','0'),('23803','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:31:07Z;
  lastStartTime: 2025-01-15T21:31:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:32:37.4621155Z','2025-01-15 21:32:37.4669091Z','2025-01-15 21:32:37.4939555Z','00:00:00.0270464','','2','0'),('23804','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:32:37.4926976Z','2025-01-15 21:32:37.4939741Z','2025-01-15 21:32:37.4971862Z','00:00:00.0032121','','0','0'),('23805','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:29:07Z;
  lastStartTime: 2025-01-15T21:29:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:07.4813923Z','2025-01-15 21:34:07.4854324Z','2025-01-15 21:34:07.4929976Z','00:00:00.0075652','','2','0'),('23806','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:29:07Z;
  lastStartTime: 2025-01-15T21:29:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:07.4861948Z','2025-01-15 21:34:07.4902594Z','2025-01-15 21:34:07.4942776Z','00:00:00.0040182','','2','0'),('23807','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:32:37Z;
  lastStartTime: 2025-01-15T21:32:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:34:07.4911645Z','2025-01-15 21:34:07.4983305Z','2025-01-15 21:34:07.5271995Z','00:00:00.0288690','','2','0'),('23808','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:34:07.5250768Z','2025-01-15 21:34:07.5272553Z','2025-01-15 21:34:07.5284863Z','00:00:00.0012310','','0','0'),('23809','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-15T21:19:16Z;
  lastStartTime: 2025-01-15T21:19:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:37.498965Z','2025-01-15 21:34:37.5006042Z','2025-01-15 21:34:52.2543965Z','00:00:14.7537923','','2','0'),('23810','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:34:07Z;
  lastStartTime: 2025-01-15T21:34:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:35:37.5147289Z','2025-01-15 21:35:37.520002Z','2025-01-15 21:35:37.5368672Z','00:00:00.0168652','','2','0'),('23811','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:35:37.5354443Z','2025-01-15 21:35:37.5368824Z','2025-01-15 21:35:37.5439813Z','00:00:00.0070989','','0','0'),('23812','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:35:37Z;
  lastStartTime: 2025-01-15T21:35:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:37:07.5307894Z','2025-01-15 21:37:07.536571Z','2025-01-15 21:37:07.5574783Z','00:00:00.0209073','','2','0'),('23813','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:37:07.5558855Z','2025-01-15 21:37:07.5575197Z','2025-01-15 21:37:07.5613786Z','00:00:00.0038589','','0','0'),('23814','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:37:07Z;
  lastStartTime: 2025-01-15T21:37:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:38:37.5454295Z','2025-01-15 21:38:37.5476684Z','2025-01-15 21:38:37.5641487Z','00:00:00.0164803','','2','0'),('23815','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:38:37.5628392Z','2025-01-15 21:38:37.5641755Z','2025-01-15 21:38:37.5678117Z','00:00:00.0036362','','0','0'),('23816','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:34:07Z;
  lastStartTime: 2025-01-15T21:34:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:39:07.5509453Z','2025-01-15 21:39:07.5529915Z','2025-01-15 21:39:07.5585633Z','00:00:00.0055718','','2','0'),('23817','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:34:07Z;
  lastStartTime: 2025-01-15T21:34:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:39:07.5535893Z','2025-01-15 21:39:07.5585749Z','2025-01-15 21:39:07.562179Z','00:00:00.0036041','','2','0'),('23818','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:38:37Z;
  lastStartTime: 2025-01-15T21:38:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:39:37.5802872Z','2025-01-15 21:39:37.5840166Z','2025-01-15 21:39:37.6047291Z','00:00:00.0207125','','2','0'),('23819','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:39:37.6030788Z','2025-01-15 21:39:37.6047677Z','2025-01-15 21:39:37.6101691Z','00:00:00.0054014','','0','0'),('23820','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:39:37Z;
  lastStartTime: 2025-01-15T21:39:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:41:07.6006359Z','2025-01-15 21:41:07.605976Z','2025-01-15 21:41:07.6299229Z','00:00:00.0239469','','2','0'),('23821','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:41:07.6276537Z','2025-01-15 21:41:07.6299587Z','2025-01-15 21:41:07.637379Z','00:00:00.0074203','','0','0'),('23822','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:41:07Z;
  lastStartTime: 2025-01-15T21:41:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:42:37.6173751Z','2025-01-15 21:42:37.6199359Z','2025-01-15 21:42:37.6314721Z','00:00:00.0115362','','2','0'),('23823','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:42:37.6302873Z','2025-01-15 21:42:37.6314902Z','2025-01-15 21:42:37.6336647Z','00:00:00.0021745','','0','0'),('23824','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:39:07Z;
  lastStartTime: 2025-01-15T21:39:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:44:07.6247407Z','2025-01-15 21:44:07.6283928Z','2025-01-15 21:44:07.6356157Z','00:00:00.0072229','','2','0'),('23825','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:39:07Z;
  lastStartTime: 2025-01-15T21:39:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:44:07.6292221Z','2025-01-15 21:44:07.6335707Z','2025-01-15 21:44:07.6418461Z','00:00:00.0082754','','2','0'),('23826','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:42:37Z;
  lastStartTime: 2025-01-15T21:42:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:44:07.634396Z','2025-01-15 21:44:07.6381148Z','2025-01-15 21:44:07.6608037Z','00:00:00.0226889','','2','0'),('23827','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:44:07.6598565Z','2025-01-15 21:44:07.660835Z','2025-01-15 21:44:07.6638696Z','00:00:00.0030346','','0','0'),('23828','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:44:07Z;
  lastStartTime: 2025-01-15T21:44:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:45:37.6526975Z','2025-01-15 21:45:37.6601285Z','2025-01-15 21:45:37.7067463Z','00:00:00.0466178','','2','0'),('23829','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:45:37.7054954Z','2025-01-15 21:45:37.7067956Z','2025-01-15 21:45:37.7094581Z','00:00:00.0026625','','0','0'),('23830','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:45:37Z;
  lastStartTime: 2025-01-15T21:45:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:47:07.6651594Z','2025-01-15 21:47:07.6685211Z','2025-01-15 21:47:07.6858968Z','00:00:00.0173757','','2','0'),('23831','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:47:07.6825145Z','2025-01-15 21:47:07.6859283Z','2025-01-15 21:47:07.6900133Z','00:00:00.0040850','','0','0'),('23832','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:47:07Z;
  lastStartTime: 2025-01-15T21:47:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:48:37.6728683Z','2025-01-15 21:48:37.6762126Z','2025-01-15 21:48:37.6936609Z','00:00:00.0174483','','2','0'),('23833','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:48:37.6918833Z','2025-01-15 21:48:37.6936973Z','2025-01-15 21:48:37.6970574Z','00:00:00.0033601','','0','0'),('23834','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:44:07Z;
  lastStartTime: 2025-01-15T21:44:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:49:07.6812962Z','2025-01-15 21:49:07.6843031Z','2025-01-15 21:49:07.6908961Z','00:00:00.0065930','','2','0'),('23835','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:44:07Z;
  lastStartTime: 2025-01-15T21:44:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:49:07.6849809Z','2025-01-15 21:49:07.688629Z','2025-01-15 21:49:07.6933832Z','00:00:00.0047542','','2','0'),('23836','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-15T21:34:52Z;
  lastStartTime: 2025-01-15T21:34:37Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:50:07.7011833Z','2025-01-15 21:50:07.705292Z','2025-01-15 21:50:15.9210663Z','00:00:08.2157743','','2','0'),('23837','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:48:37Z;
  lastStartTime: 2025-01-15T21:48:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:50:07.706162Z','2025-01-15 21:50:07.7099867Z','2025-01-15 21:50:07.7375044Z','00:00:00.0275177','','2','0'),('23838','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:50:07.7351335Z','2025-01-15 21:50:07.7377532Z','2025-01-15 21:50:07.7446752Z','00:00:00.0069220','','0','0'),('23839','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:50:07Z;
  lastStartTime: 2025-01-15T21:50:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:51:37.739616Z','2025-01-15 21:51:37.7427029Z','2025-01-15 21:51:37.7563375Z','00:00:00.0136346','','2','0'),('23840','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:51:37.7553633Z','2025-01-15 21:51:37.7563774Z','2025-01-15 21:51:37.7602486Z','00:00:00.0038712','','0','0'),('23841','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:51:37Z;
  lastStartTime: 2025-01-15T21:51:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:53:07.756399Z','2025-01-15 21:53:07.7620445Z','2025-01-15 21:53:07.7898549Z','00:00:00.0278104','','2','0'),('23842','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:53:07.7882605Z','2025-01-15 21:53:07.7898885Z','2025-01-15 21:53:07.7948773Z','00:00:00.0049888','','0','0'),('23843','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:49:07Z;
  lastStartTime: 2025-01-15T21:49:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:54:07.7651822Z','2025-01-15 21:54:07.7684354Z','2025-01-15 21:54:07.7748135Z','00:00:00.0063781','','2','0'),('23844','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:49:07Z;
  lastStartTime: 2025-01-15T21:49:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:54:07.7692314Z','2025-01-15 21:54:07.7732421Z','2025-01-15 21:54:07.7780406Z','00:00:00.0047985','','2','0'),('23845','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:53:07Z;
  lastStartTime: 2025-01-15T21:53:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:54:37.7744781Z','2025-01-15 21:54:37.7770299Z','2025-01-15 21:54:37.7923029Z','00:00:00.0152730','','2','0'),('23846','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:54:37.7911393Z','2025-01-15 21:54:37.7923308Z','2025-01-15 21:54:37.7948891Z','00:00:00.0025583','','0','0'),('23847','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:54:37Z;
  lastStartTime: 2025-01-15T21:54:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:56:07.7873938Z','2025-01-15 21:56:07.7908786Z','2025-01-15 21:56:07.8190857Z','00:00:00.0282071','','2','0'),('23848','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:56:07.8164872Z','2025-01-15 21:56:07.8191689Z','2025-01-15 21:56:07.8260343Z','00:00:00.0068654','','0','0'),('23849','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:56:07Z;
  lastStartTime: 2025-01-15T21:56:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:57:37.8003495Z','2025-01-15 21:57:37.8057658Z','2025-01-15 21:57:37.8341111Z','00:00:00.0283453','','2','0'),('23850','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:57:37.8327432Z','2025-01-15 21:57:37.8341715Z','2025-01-15 21:57:37.8401592Z','00:00:00.0059877','','0','0'),('23851','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:54:07Z;
  lastStartTime: 2025-01-15T21:54:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:59:07.8441152Z','2025-01-15 21:59:07.8784434Z','2025-01-15 21:59:07.9409861Z','00:00:00.0625427','','2','0'),('23852','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:54:07Z;
  lastStartTime: 2025-01-15T21:54:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:59:07.8791204Z','2025-01-15 21:59:07.8843918Z','2025-01-15 21:59:07.9004483Z','00:00:00.0160565','','2','0'),('23853','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:57:37Z;
  lastStartTime: 2025-01-15T21:57:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 21:59:07.8850171Z','2025-01-15 21:59:07.8936536Z','2025-01-15 21:59:07.9382206Z','00:00:00.0445670','','2','0'),('23854','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 21:59:07.927831Z','2025-01-15 21:59:07.9384234Z','2025-01-15 21:59:07.9430381Z','00:00:00.0046147','','0','0'),('23855','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T21:59:07Z;
  lastStartTime: 2025-01-15T21:59:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:00:37.9080895Z','2025-01-15 22:00:37.9144673Z','2025-01-15 22:00:38.0078768Z','00:00:00.0934095','','2','0'),('23856','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:00:38.0063116Z','2025-01-15 22:00:38.0079047Z','2025-01-15 22:00:38.0118425Z','00:00:00.0039378','','0','0'),('23857','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:00:38Z;
  lastStartTime: 2025-01-15T22:00:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:02:07.9366583Z','2025-01-15 22:02:07.9419646Z','2025-01-15 22:02:07.9635848Z','00:00:00.0216202','','2','0'),('23858','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:02:07.962326Z','2025-01-15 22:02:07.963619Z','2025-01-15 22:02:07.9691361Z','00:00:00.0055171','','0','0'),('23859','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:02:07Z;
  lastStartTime: 2025-01-15T22:02:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:03:37.9572849Z','2025-01-15 22:03:37.96023Z','2025-01-15 22:03:37.9796103Z','00:00:00.0193803','','2','0'),('23860','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:03:37.9788526Z','2025-01-15 22:03:37.9796307Z','2025-01-15 22:03:37.9825242Z','00:00:00.0028935','','0','0'),('23861','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T21:59:07Z;
  lastStartTime: 2025-01-15T21:59:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:04:07.9643667Z','2025-01-15 22:04:07.9677522Z','2025-01-15 22:04:07.9719265Z','00:00:00.0041743','','2','0'),('23862','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:59:07Z;
  lastStartTime: 2025-01-15T21:59:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:04:07.9684074Z','2025-01-15 22:04:07.9720698Z','2025-01-15 22:04:07.9758836Z','00:00:00.0038138','','2','0'),('23863','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:03:37Z;
  lastStartTime: 2025-01-15T22:03:37Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:05:07.9740704Z','2025-01-15 22:05:07.9779731Z','2025-01-15 22:05:07.9981395Z','00:00:00.0201664','','2','0'),('23864','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:05:07.9971769Z','2025-01-15 22:05:07.9981575Z','2025-01-15 22:05:08.0017314Z','00:00:00.0035739','','0','0'),('23865','RssSync','{
  sendUpdatesToClient: true;
  isLongRunning: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  name: RssSync;
  lastExecutionTime: 2025-01-15T21:50:15Z;
  lastStartTime: 2025-01-15T21:50:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:05:37.9879253Z','2025-01-15 22:05:37.9964147Z','2025-01-15 22:05:47.0795683Z','00:00:09.0831536','','2','0'),('23866','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:05:07Z;
  lastStartTime: 2025-01-15T22:05:07Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:06:38.004417Z','2025-01-15 22:06:38.0096233Z','2025-01-15 22:06:38.022979Z','00:00:00.0133557','','2','0'),('23867','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:06:38.0219735Z','2025-01-15 22:06:38.0230045Z','2025-01-15 22:06:38.0269259Z','00:00:00.0039214','','0','0'),('23868','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:06:38Z;
  lastStartTime: 2025-01-15T22:06:38Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:08:08.0202922Z','2025-01-15 22:08:08.0260938Z','2025-01-15 22:08:08.0491819Z','00:00:00.0230881','','2','0'),('23869','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:08:08.047997Z','2025-01-15 22:08:08.0492127Z','2025-01-15 22:08:08.057902Z','00:00:00.0086893','','0','0'),('23870','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T22:04:07Z;
  lastStartTime: 2025-01-15T22:04:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:09:08.0355408Z','2025-01-15 22:09:08.03872Z','2025-01-15 22:09:08.0458683Z','00:00:00.0071483','','2','0'),('23871','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:04:07Z;
  lastStartTime: 2025-01-15T22:04:07Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:09:08.0396299Z','2025-01-15 22:09:08.0441033Z','2025-01-15 22:09:08.0471798Z','00:00:00.0030765','','2','0'),('23872','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:08:08Z;
  lastStartTime: 2025-01-15T22:08:08Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:09:38.0473374Z','2025-01-15 22:09:38.0507868Z','2025-01-15 22:09:38.0798955Z','00:00:00.0291087','','2','0'),('23873','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:09:38.0781185Z','2025-01-15 22:09:38.0799988Z','2025-01-15 22:09:38.0838288Z','00:00:00.0038300','','0','0'),('23874','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:09:38Z;
  lastStartTime: 2025-01-15T22:09:38Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:11:08.0593641Z','2025-01-15 22:11:08.0621055Z','2025-01-15 22:11:08.0813966Z','00:00:00.0192911','','2','0'),('23875','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:11:08.0796004Z','2025-01-15 22:11:08.081412Z','2025-01-15 22:11:08.0826581Z','00:00:00.0012461','','0','0'),('23876','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:11:08Z;
  lastStartTime: 2025-01-15T22:11:08Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:12:38.076323Z','2025-01-15 22:12:38.0810045Z','2025-01-15 22:12:38.098345Z','00:00:00.0173405','','2','0'),('23877','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:12:38.0967201Z','2025-01-15 22:12:38.0983936Z','2025-01-15 22:12:38.1039788Z','00:00:00.0055852','','0','0'),('23878','ImportListSync','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: ImportListSync;
  lastExecutionTime: 2025-01-15T22:09:08Z;
  lastStartTime: 2025-01-15T22:09:08Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:14:08.0876135Z','2025-01-15 22:14:08.0908246Z','2025-01-15 22:14:08.096915Z','00:00:00.0060904','','2','0'),('23879','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:09:08Z;
  lastStartTime: 2025-01-15T22:09:08Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:14:08.091437Z','2025-01-15 22:14:08.0957198Z','2025-01-15 22:14:08.0991439Z','00:00:00.0034241','','2','0'),('23880','RefreshMonitoredDownloads','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isLongRunning: false;
  name: RefreshMonitoredDownloads;
  lastExecutionTime: 2025-01-15T22:12:38Z;
  lastStartTime: 2025-01-15T22:12:38Z;
  trigger: scheduled;
  suppressMessages: false
}','1','2','2025-01-15 22:14:08.0966471Z','2025-01-15 22:14:08.1036816Z','2025-01-15 22:14:08.1226038Z','00:00:00.0189222','','2','0'),('23881','ProcessMonitoredDownloads','{
  requiresDiskAccess: true;
  isLongRunning: true;
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  isExclusive: false;
  name: ProcessMonitoredDownloads;
  trigger: unspecified;
  suppressMessages: false
}','1','2','2025-01-15 22:14:08.1211515Z','2025-01-15 22:14:08.1226405Z','2025-01-15 22:14:08.1258875Z','00:00:00.0032470','','0','0');

