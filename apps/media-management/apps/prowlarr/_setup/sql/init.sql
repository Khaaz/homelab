-- TODO : Table Config check pass

-- AppSyncProfiles
DELETE FROM AppSyncProfiles;
INSERT INTO AppSyncProfiles (Id, Name, EnableRss, EnableInteractiveSearch, EnableAutomaticSearch, MinimumSeeders)
VALUES
(1, 'Standard', 1, 1, 1, 1);

-- ApplicationIndexerMapping
DELETE FROM ApplicationIndexerMapping;
INSERT INTO ApplicationIndexerMapping (Id, IndexerId, AppId, RemoteIndexerId, RemoteIndexerName)
VALUES
(1, 1, 1, 1, NULL),
(2, 1, 2, 1, NULL),
(3, 2, 1, 2, NULL),
(4, 2, 2, 2, NULL),
(5, 3, 1, 3, NULL),
(6, 3, 2, 3, NULL),
(7, 4, 1, 4, NULL),
(8, 5, 1, 5, NULL),
(9, 5, 2, 4, NULL),
(10, 7, 1, 6, NULL),
(11, 7, 2, 5, NULL),
(12, 8, 1, 7, NULL),
(13, 9, 1, 8, NULL),
(14, 9, 2, 6, NULL),
(15, 10, 1, 9, NULL),
(16, 10, 2, 7, NULL),
(17, 11, 1, 10, NULL),
(18, 11, 2, 8, NULL),
(19, 1, 3, 1, NULL),
(20, 5, 3, 2, NULL),
(21, 7, 3, 3, NULL),
(22, 9, 3, 4, NULL),
(23, 10, 3, 5, NULL),
(24, 2, 3, 6, NULL),
(25, 11, 3, 7, NULL),
(26, 3, 3, 8, NULL),
(27, 6, 1, 11, NULL),
(28, 6, 2, 9, NULL),
(29, 6, 3, 9, NULL);

-- Applications
DELETE FROM Applications;
INSERT INTO Applications (Id, Name, Implementation, Settings, ConfigContract, SyncLevel, Tags)
VALUES
(1, 'Sonarr', 'Sonarr', '{
  "prowlarrUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}",
  "baseUrl": "http://${DOCKER_SUBNET}.24:${PORT_UI_SONARR}",
  "apiKey": "${API_KEY_SONARR}",
  "syncCategories": [
    5000,
    5010,
    5020,
    5030,
    5040,
    5045,
    5050,
    5090
  ],
  "animeSyncCategories": [
    5070
  ],
  "syncAnimeStandardFormatSearch": true,
  "syncRejectBlocklistedTorrentHashesWhileGrabbing": false
}', 'SonarrSettings', 2, '[]'),
(2, 'Radarr', 'Radarr', '{
  "prowlarrUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}",
  "baseUrl": "http://${DOCKER_SUBNET}.22:${PORT_UI_RADARR}",
  "apiKey": "${API_KEY_RADARR}",
  "syncCategories": [
    2000,
    2010,
    2020,
    2030,
    2040,
    2045,
    2050,
    2060,
    2070,
    2080,
    2090
  ],
  "syncRejectBlocklistedTorrentHashesWhileGrabbing": false
}', 'RadarrSettings', 2, '[]'),
(3, 'Radarr-4k', 'Radarr', '{
  "prowlarrUrl": "http://${DOCKER_SUBNET}.10:${PORT_UI_PROWLARR}",
  "baseUrl": "http://${DOCKER_SUBNET}.23:${PORT_UI_RADARR4K}",
  "apiKey": "${API_KEY_RADARR4K}",
  "syncCategories": [
    2000,
    2010,
    2020,
    2030,
    2040,
    2045,
    2050,
    2060,
    2070,
    2080,
    2090
  ],
  "syncRejectBlocklistedTorrentHashesWhileGrabbing": false
}', 'RadarrSettings', 2, '[]');

-- Config
DELETE FROM Config;
INSERT INTO Config (Id, Key, Value)
VALUES
(1, 'plexclientidentifier', '196ae8ea-d1e6-4f71-97da-1e5a5cffe79a'),
(2, 'rijndaelpassphrase', 'd341a2f5-177b-4ccc-a9fd-3754e563d8ac'),
(3, 'hmacpassphrase', '872a3f63-9bb6-4232-a3ac-25015e5e3a60'),
(4, 'rijndaelsalt', 'c6c81e73-b6e9-42ba-be1e-3a39b86cd982'),
(5, 'hmacsalt', 'bd6d2631-9808-48a9-bc3f-1ff00fde45f4'),
(6, 'downloadprotectionkey', '124b74ef8b2a4ee08bc945260e57aee4'),
(7, 'shortdateformat', 'DD MMM YYYY'),
(8, 'longdateformat', 'dddd, D MMMM YYYY'),
(9, 'timeformat', 'HH:mm');

-- DownloadClients
DELETE FROM DownloadClients;
INSERT INTO DownloadClients (Id, Enable, Name, Implementation, Settings, ConfigContract, Priority, Categories)
VALUES
(2, 1, 'qBittorrent', 'QBittorrent', '{
  "host": "localhost",
  "port": ${PORT_UI_QBITTORRENT},
  "useSsl": false,
  "username": "admin",
  "password": "admin!",
  "category": "prowlarr",
  "priority": 0,
  "initialState": 0,
  "sequentialOrder": false,
  "firstAndLast": false,
  "contentLayout": 0
}', 'QBittorrentSettings', 1, '[]');

-- IndexerProxies
DELETE FROM IndexerProxies;
INSERT INTO IndexerProxies (Id, Name, Settings, Implementation, ConfigContract, Tags)
VALUES
(1, 'FlareSolverr', '{
  "host": "http://localhost:${PORT_SERVICE_FLARESOLVERR}/",
  "requestTimeout": 60
}', 'FlareSolverr', 'FlareSolverrSettings', '[1]');

-- Indexers
DELETE FROM Indexers;
INSERT INTO Indexers (Id, Name, Implementation, Settings, ConfigContract, Enable, Priority, Added, Redirect, AppProfileId, Tags, DownloadClientId)
VALUES
(1, '1337x', 'Cardigann', '{
  "definitionFile": "1337x",
  "extraFieldData": {
    "info_flaresolverr": "This site may use Cloudflare DDoS Protection, therefore Prowlarr requires <a href=\"https://wiki.servarr.com/prowlarr/faq#can-i-use-flaresolverr-indexers\" target=\"_blank\" rel=\"noreferrer\">FlareSolverr</a> to access it.",
    "downloadlink": 0,
    "downloadlink2": 1,
    "info_download": "As the iTorrents .torrent download link on this site is known to fail from time to time, we suggest using the magnet link as a fallback. The BTCache and Torrage services are not supported because they require additional user interaction (a captcha for BTCache and a download button on Torrage.)",
    "sort": 2,
    "type": 1
  },
  "baseUrl": "https://1337x.to/",
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-14 18:30:08.1535318Z', 0, 1, '[1]', 0),
(2, 'The Pirate Bay', 'Cardigann', '{
  "definitionFile": "thepiratebay",
  "extraFieldData": {
    "info_api": "This indexer uses the API at https://apibay.org/ to get its official TPB data. Choose any site link that you can access/prefer so that you can view the torrent details page when browsing the search results for this indexer."
  },
  "baseUrl": "https://thepiratebay.org/",
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-14 18:57:29.9933339Z', 0, 1, '[]', 0),
(3, 'Torrent9', 'Cardigann', '{
  "definitionFile": "torrent9",
  "extraFieldData": {
    "multilang": false,
    "multilanguage": 1,
    "vostfr": false,
    "sort": 0
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:24:32.3401457Z', 0, 1, '[]', 0),
(4, 'LimeTorrents', 'Cardigann', '{
  "definitionFile": "limetorrents",
  "extraFieldData": {
    "downloadlink": 1,
    "downloadlink2": 0,
    "info_download": "As the .torrent download links on this site are known to fail from time to time, you can optionally set as a fallback an automatic alternate link.",
    "sort": 0,
    "info_category_8000": "LimeTorrents only returns category <b>Other</b> in its <i>Keywordless</i> search results page.<br>To pass your apps indexer TEST you will need to include the 8000(Other) category."
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:26:51.0781464Z', 0, 1, '[]', 0),
(5, 'Badass Torrents', 'Cardigann', '{
  "definitionFile": "badasstorrents",
  "extraFieldData": {
    "info_flaresolverr": "This site may use Cloudflare DDoS Protection, therefore Prowlarr requires <a href=\"https://wiki.servarr.com/prowlarr/faq#can-i-use-flaresolverr-indexers\" target=\"_blank\" rel=\"noreferrer\">FlareSolverr</a> to access it.",
    "downloadlink": 1,
    "downloadlink2": 0,
    "info_download": "You can optionally set as a fallback an automatic alternate link, so if the .torrent download link fails your download will still be successful."
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:27:07.8061553Z', 0, 1, '[]', 0),
(6, 'BitSearch', 'Cardigann', '{
  "definitionFile": "bitsearch",
  "extraFieldData": {
    "prefer_magnet_links": false,
    "sort": 0,
    "type": 1,
    "info_category_8000": "BitSearch does not properly return categories in its search results for some releases.<br>To add to your Apps Torznab indexer, you will need to include the 8000(Other) category."
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:27:15.5148844Z', 0, 1, '[]', 0),
(7, 'ExtraTorrent.st', 'Cardigann', '{
  "definitionFile": "extratorrent-st",
  "extraFieldData": {
    "info_flaresolverr": "This site may use Cloudflare DDoS Protection, therefore Prowlarr requires <a href=\"https://wiki.servarr.com/prowlarr/faq#can-i-use-flaresolverr-indexers\" target=\"_blank\" rel=\"noreferrer\">FlareSolverr</a> to access it."
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:27:26.0340891Z', 0, 1, '[]', 0),
(8, 'EZTV', 'Cardigann', '{
  "definitionFile": "eztv",
  "extraFieldData": {},
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:27:37.0766043Z', 0, 1, '[]', 0),
(9, 'Internet Archive', 'Cardigann', '{
  "definitionFile": "internetarchive",
  "extraFieldData": {
    "titleOnly": true,
    "noMagnet": false,
    "sort": 2,
    "type": 1
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:27:52.9916519Z', 0, 1, '[]', 0),
(10, 'kickasstorrents.ws', 'Cardigann', '{
  "definitionFile": "kickasstorrents-ws",
  "extraFieldData": {
    "sort": 2,
    "type": 1
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:28:15.5148885Z', 0, 1, '[]', 0),
(11, 'Torlock', 'Cardigann', '{
  "definitionFile": "torlock",
  "extraFieldData": {
    "sort": 0,
    "type": 1
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:28:30.8833762Z', 0, 1, '[]', 0),
(12, 'Torrentz2nz', 'Cardigann', '{
  "definitionFile": "torrentz2nz",
  "extraFieldData": {
    "info_category_8000": "Torrentz2nz does not return categories in its search results. To sync to your apps, include 8000(Other) in your Apps\' Sync Categories."
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:29:15.7200997Z', 0, 1, '[]', 0),
(13, 'cpasbien clone', 'Cardigann', '{
  "definitionFile": "cpasbienclone",
  "extraFieldData": {
    "info_category_8000": "cpasbien clone does not return categories in its search results. To sync to your apps, include 8000(Other) in your Apps\' Sync Categories.",
    "multilang": false,
    "multilanguage": 1,
    "vostfr": false,
    "sort": 1
  },
  "baseSettings": {
    "limitsUnit": 0
  },
  "torrentBaseSettings": {
    "preferMagnetUrl": false
  }
}', 'CardigannSettings', 1, 25, '2024-12-22 16:30:06.7809622Z', 0, 1, '[]', 0);

-- ScheduledTasks
DELETE FROM ScheduledTasks;
INSERT INTO ScheduledTasks (Id, TypeName, "Interval", LastExecution, LastStartTime)
VALUES
(1, 'NzbDrone.Core.Messaging.Commands.MessagingCleanupCommand', 5, '2025-01-15 22:25:49.3456531Z', '2025-01-15 22:25:49.3405384Z'),
(2, 'NzbDrone.Core.Update.Commands.ApplicationUpdateCheckCommand', 360, '2025-01-15 21:03:50.7706118Z', '2025-01-15 21:03:50.3715602Z'),
(3, 'NzbDrone.Core.HealthCheck.CheckHealthCommand', 360, '2025-01-15 21:03:51.5120654Z', '2025-01-15 21:03:48.3552826Z'),
(4, 'NzbDrone.Core.Housekeeping.HousekeepingCommand', 1440, '2025-01-15 21:03:50.2562537Z', '2025-01-15 21:03:48.3692602Z'),
(5, 'NzbDrone.Core.History.CleanUpHistoryCommand', 1440, '2025-01-15 21:03:50.3648172Z', '2025-01-15 21:03:50.2943057Z'),
(6, 'NzbDrone.Core.IndexerVersions.IndexerDefinitionUpdateCommand', 1440, '2025-01-15 21:03:51.2813618Z', '2025-01-15 21:03:48.3773771Z'),
(7, 'NzbDrone.Core.Applications.ApplicationIndexerSyncCommand', 360, '2025-01-15 21:04:05.2422102Z', '2025-01-15 21:03:48.3823084Z'),
(8, 'NzbDrone.Core.Backup.BackupCommand', 10080, '2025-01-12 18:34:09.2724356Z', '2025-01-12 18:34:07.8904027Z');

-- Tags
DELETE FROM Tags;
INSERT INTO Tags (Id, Label)
VALUES
(1, 'flaresolverr');