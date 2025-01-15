-- TODO : Table Config check pass
-- TODO : DownloadClients change access
-- TODO : API key to change into Indexer

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
  "prowlarrUrl": "http://localhost:9696",
  "baseUrl": "http://localhost:8989",
  "apiKey": "69f87af967a047a68fa4a74c1f441856",
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
  "prowlarrUrl": "http://localhost:9696",
  "baseUrl": "http://localhost:7878",
  "apiKey": "3ebde1f20ae54d1684a171f23cf112ea",
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
  "prowlarrUrl": "http://localhost:9696",
  "baseUrl": "http://localhost:7879",
  "apiKey": "9a6865941b224b05ab7632c4f6bbbf00",
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

-- Commands
DELETE FROM Commands;
INSERT INTO Commands (Id Name Body Priority Status QueuedAt StartedAt EndedAt Duration Exception Trigger) VALUES ('2717','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-14T20:49:59Z;
  lastStartTime: 2025-01-14T20:49:59Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.317322Z','2025-01-15 21:03:48.3426809Z','2025-01-15 21:03:48.3602435Z','00:00:00.0175626','','2'),('2718','CheckHealth','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: CheckHealth;
  lastExecutionTime: 2025-01-14T19:17:33Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3450956Z','2025-01-15 21:03:48.3552826Z','2025-01-15 21:03:51.5061093Z','00:00:03.1508267','','2'),('2719','Housekeeping','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: Housekeeping;
  lastExecutionTime: 2025-01-14T19:17:32Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3561567Z','2025-01-15 21:03:48.3692602Z','2025-01-15 21:03:50.2258927Z','00:00:01.8566325','','2'),('2720','IndexerDefinitionUpdate','{
  sendUpdatesToClient: true;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: IndexerDefinitionUpdate;
  lastExecutionTime: 2025-01-14T19:17:32Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3701309Z','2025-01-15 21:03:48.3773771Z','2025-01-15 21:03:51.2751552Z','00:00:02.8977781','','2'),('2721','ApplicationIndexerSync','{
  forceSync: false;
  sendUpdatesToClient: true;
  completionMessage: Completed;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: ApplicationIndexerSync;
  lastExecutionTime: 2025-01-14T19:17:37Z;
  lastStartTime: 2025-01-14T19:17:30Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3785858Z','2025-01-15 21:03:48.3823084Z','2025-01-15 21:04:05.2378125Z','00:00:16.8555041','','2'),('2722','CleanUpHistory','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: CleanUpHistory;
  lastExecutionTime: 2025-01-14T19:17:32Z;
  lastStartTime: 2025-01-14T19:17:32Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3835939Z','2025-01-15 21:03:50.2943057Z','2025-01-15 21:03:50.3559915Z','00:00:00.0616858','','2'),('2723','ApplicationUpdateCheck','{
  sendUpdatesToClient: true;
  installMajorUpdate: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: ApplicationUpdateCheck;
  lastExecutionTime: 2025-01-14T19:17:30Z;
  lastStartTime: 2025-01-14T19:17:29Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:03:48.3890547Z','2025-01-15 21:03:50.3715602Z','2025-01-15 21:03:50.7238821Z','00:00:00.3523219','','2'),('2724','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:03:48Z;
  lastStartTime: 2025-01-15T21:03:48Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:08:48.705449Z','2025-01-15 21:08:48.7287818Z','2025-01-15 21:08:48.7391415Z','00:00:00.0103597','','2'),('2725','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:08:48Z;
  lastStartTime: 2025-01-15T21:08:48Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:14:18.7338137Z','2025-01-15 21:14:18.7509564Z','2025-01-15 21:14:18.753864Z','00:00:00.0029076','','2'),('2726','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:14:18Z;
  lastStartTime: 2025-01-15T21:14:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:19:18.763588Z','2025-01-15 21:19:18.7742231Z','2025-01-15 21:19:18.7836843Z','00:00:00.0094612','','2'),('2727','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:19:18Z;
  lastStartTime: 2025-01-15T21:19:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:24:18.8294539Z','2025-01-15 21:24:18.8386707Z','2025-01-15 21:24:18.8434307Z','00:00:00.0047600','','2'),('2728','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:24:18Z;
  lastStartTime: 2025-01-15T21:24:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:29:18.8587299Z','2025-01-15 21:29:18.8682254Z','2025-01-15 21:29:18.8720548Z','00:00:00.0038294','','2'),('2729','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:29:18Z;
  lastStartTime: 2025-01-15T21:29:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:34:18.8998742Z','2025-01-15 21:34:18.9077842Z','2025-01-15 21:34:18.9102215Z','00:00:00.0024373','','2'),('2730','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:34:18Z;
  lastStartTime: 2025-01-15T21:34:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:39:18.9475822Z','2025-01-15 21:39:18.9633915Z','2025-01-15 21:39:18.9678706Z','00:00:00.0044791','','2'),('2731','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:39:18Z;
  lastStartTime: 2025-01-15T21:39:18Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:44:18.9935297Z','2025-01-15 21:44:19.0025855Z','2025-01-15 21:44:19.004921Z','00:00:00.0023355','','2'),('2732','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:44:19Z;
  lastStartTime: 2025-01-15T21:44:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:49:19.0381386Z','2025-01-15 21:49:19.0968299Z','2025-01-15 21:49:19.1594059Z','00:00:00.0625760','','2'),('2733','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:49:19Z;
  lastStartTime: 2025-01-15T21:49:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 21:54:49.1363107Z','2025-01-15 21:54:49.1473458Z','2025-01-15 21:54:49.1504742Z','00:00:00.0031284','','2'),('2734','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T21:54:49Z;
  lastStartTime: 2025-01-15T21:54:49Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:00:19.1748333Z','2025-01-15 22:00:19.1823416Z','2025-01-15 22:00:19.1866878Z','00:00:00.0043462','','2'),('2735','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:00:19Z;
  lastStartTime: 2025-01-15T22:00:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:05:19.2153142Z','2025-01-15 22:05:19.2182593Z','2025-01-15 22:05:19.2200081Z','00:00:00.0017488','','2'),('2736','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:05:19Z;
  lastStartTime: 2025-01-15T22:05:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:10:19.2447732Z','2025-01-15 22:10:19.2530547Z','2025-01-15 22:10:19.2582559Z','00:00:00.0052012','','2'),('2737','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:10:19Z;
  lastStartTime: 2025-01-15T22:10:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:15:19.2894804Z','2025-01-15 22:15:19.2987831Z','2025-01-15 22:15:19.3025291Z','00:00:00.0037460','','2'),('2738','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:15:19Z;
  lastStartTime: 2025-01-15T22:15:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:20:19.3210995Z','2025-01-15 22:20:19.3313541Z','2025-01-15 22:20:19.3476055Z','00:00:00.0162514','','2'),('2739','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:20:19Z;
  lastStartTime: 2025-01-15T22:20:19Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:25:49.3313671Z','2025-01-15 22:25:49.3405384Z','2025-01-15 22:25:49.3440605Z','00:00:00.0035221','','2'),('2740','MessagingCleanup','{
  sendUpdatesToClient: false;
  updateScheduledTask: true;
  requiresDiskAccess: false;
  isExclusive: false;
  isTypeExclusive: false;
  name: MessagingCleanup;
  lastExecutionTime: 2025-01-15T22:25:49Z;
  lastStartTime: 2025-01-15T22:25:49Z;
  trigger: scheduled;
  suppressMessages: false
}','-1','2','2025-01-15 22:30:49.3624635Z','2025-01-15 22:30:49.3711823Z','2025-01-15 22:30:49.3748936Z','00:00:00.0037113','','2');

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
  "port": 8200,
  "useSsl": false,
  "username": "admin",
  "password": "Khaaz11!",
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
  "host": "http://localhost:8191/",
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
    "info_category_8000": "LimeTorrents only returns category <b>Other</b> in its <i>Keywordless</i> search results page.<br>To pass your apps\' indexer TEST you will need to include the 8000(Other) category."
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
    "info_category_8000": "BitSearch does not properly return categories in its search results for some releases.<br>To add to your Apps\' Torznab indexer, you will need to include the 8000(Other) category."
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