-- TODO : Table Config check pass

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
  "host": "${DOCKER_SUBNET}.10",
  "port": ${PORT_UI_QBITTORRENT},
  "useSsl": false,
  "username": "admin",
  "password": "admin!",
  "tvCategory": "series",
  "recentTvPriority": 0,
  "olderTvPriority": 0,
  "initialState": 0,
  "sequentialOrder": false,
  "firstAndLast": false,
  "contentLayout": 0
}', 'QBittorrentSettings', 1, 1, 1, '[3]'),
(4, 1, 'qbit-anime', 'QBittorrent', '{
  "host": "${DOCKER_SUBNET}.10",
  "port": ${PORT_UI_QBITTORRENT},
  "useSsl": false,
  "username": "admin",
  "password": "admin!",
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
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/1/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000, 5040, 5030],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(2, 'The Pirate Bay (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/2/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000, 5050, 5040, 5045],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(3, 'Torrent9 (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/3/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(4, 'LimeTorrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/4/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(5, 'Badass Torrents (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/5/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(6, 'ExtraTorrent.st (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/7/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(7, 'EZTV (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/8/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(8, 'Internet Archive (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/9/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(9, 'kickasstorrents.ws (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/10/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(10, 'Torlock (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/11/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
  "categories": [5000],
  "animeCategories": [5070],
  "animeStandardFormatSearch": true,
  "multiLanguages": []
}', 'TorznabSettings', 1, 1, 1, 25, '[]', 0, 0),
(11, 'BitSearch (Prowlarr)', 'Torznab', '{
  "minimumSeeders": 1,
  "seedCriteria": {},
  "rejectBlocklistedTorrentHashesWhileGrabbing": false,
  "baseUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}/6/",
  "apiPath": "/api",
  "apiKey": "${API_KEY_PROWLARR}",
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
INSERT INTO NamingConfig (Id, MultiEpisodeStyle, RenameEpisodes, StandardEpisodeFormat, DailyEpisodeFormat, SeasonFolderFormat, SeriesFolderFormat, AnimeEpisodeFormat, ReplaceIllegalCharacters, SpecialsFolderFormat, ColonReplacementFormat)
VALUES
(1, 5, 1, '{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', '{Series TitleYear} - {Air-Date} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', 'Season {season:00}', '{Series TitleYear} {imdb-{ImdbId}}', '{Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}[{MediaInfo VideoBitDepth}bit]{[MediaInfo VideoCodec]}[{Mediainfo AudioCodec} { Mediainfo AudioChannels}]{MediaInfo AudioLanguages}{-Release Group}', 1, 'Specials', 4);

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
(1, '${DOCKER_SUBNET}.10', '/data/anime', '/data/torrents/anime/'),
(2, '${DOCKER_SUBNET}.10', '/data/series/', '/data/torrents/series/');

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
