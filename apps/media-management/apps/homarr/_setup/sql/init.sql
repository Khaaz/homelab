DELETE FROM app;
INSERT INTO app VALUES('pxidynz7p14nzno09w3866in','Overseer',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/overseerr.svg','http://overseerr.l.ab'),
('qq9ip1i1m86ddutn0080hfd8','Radarr',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/radarr.svg','http://radarr.l.ab'),
('su15mjnjauzr8ah2hglx6e5v','Radarr 4k',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/radarr.svg','http://radarr4k.l.ab'),
('k5e2hgeiqxi5ntq1zfthi8z4','Sonarr 4K',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/sonarr.svg','http://sonarr4k.l.ab'),
('etdh2ag2a9x40vanrgq60mts','Sonarr',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/sonarr.svg','http://sonarr.l.ab'),
('cyobs6cgq6lh6h9pcdz64mjx','Qbittorrent',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/qbittorrent.svg','http://qbit.l.ab'),
('orgbc3hfhlq4f3rhgx884s6y','Prowlarr',NULL,'https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/prowlarr.svg','http://prowlarr.l.ab'),
('flaji8e3ijrn4phhgizsdx92','Plex',NULL,'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/plex.png','http://plex.l.ab'),
('xkerauiy02lfi9kbuzvoxmbx','Bazarr',NULL,'https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/bazarr.png','http://bazarr.l.ab'),
('l0k5fdrqyj7927g63iwg22a7','Maintainerr',NULL,'https://cdn.jsdelivr.net/gh/selfhst/icons/png/maintainerr.png','http://maintainerr.l.ab');

DELETE FROM board;
INSERT INTO board VALUES('vjek9rh6rx5ms6oa63y9u9ig','NAS',0,'vlupgbl2w26ro81hlx218xr7',NULL,NULL,NULL,NULL,NULL,'fixed','no-repeat','cover','#fa5252','#fd7e14',100,NULL,10);

DELETE FROM groupPermission;
INSERT INTO groupPermission VALUES('kpormy9ezi9pbdzin9hczsnq','admin');

DELETE FROM groupMember;
INSERT INTO groupMember VALUES('kpormy9ezi9pbdzin9hczsnq','vlupgbl2w26ro81hlx218xr7'),
('dh7hcjtp3usqelf6p8cuqtnn','vlupgbl2w26ro81hlx218xr7');

DELETE FROM "group";
INSERT INTO "group" VALUES('dh7hcjtp3usqelf6p8cuqtnn','everyone',NULL),
('kpormy9ezi9pbdzin9hczsnq','credentials-admin','vlupgbl2w26ro81hlx218xr7');

DELETE FROM user;
INSERT INTO user VALUES('vlupgbl2w26ro81hlx218xr7','dgladieux',NULL,NULL,NULL,'$2b$10$7WHLF9fZi0wHx/4q8MTN7OJYA6ph6drCnavxhQtp.nqwOrLJpR1z2','$2b$10$7WHLF9fZi0wHx/4q8MTN7O','credentials','vjek9rh6rx5ms6oa63y9u9ig','dark',1,0,NULL,'vjek9rh6rx5ms6oa63y9u9ig',1);

DELETE FROM iconRepository;
INSERT INTO iconRepository VALUES('rbmywa2b7e1yokmw6vavdz9m','homarr-labs/dashboard-icons'),
('q7ir66dljaj56m3o5ovthvtt','selfhst/icons'),
('dn7s0yztdnhi2qz0yh2z0ad0','simple-icons/simple-icons'),
('b5hmhvwrj7yol720dlsctcwt','PapirusDevelopmentTeam/papirus-icon-theme'),
('g4lghqy9v2x9o715lkrhywtn','loganmarchione/homelab-svg-assets'),
('oliwlxyajw1vzgaq9lx0wq5u','local');

DELETE FROM integration_item;
INSERT INTO integration_item VALUES('bjninlmfv3erpnaekaqdh2y9','ba5boqlkgbqz26hohqi20wg2'),
('hqds9raofstjq06nko6rmmdl','j0lnfk0qmqwjqy4ju4llxa8h'),
('h6q7chug1flgbln3wsuqomba','iu2i3pkkaub7pgdfhoapau14'),
('zv1u9i70gk9nhn82jom5r32s','j0lnfk0qmqwjqy4ju4llxa8h');


DELETE FROM integrationSecret;
INSERT INTO integrationSecret VALUES('apiKey','7e82f382e657d8e99faeca4ecb6ff194dad4afe8168a4246e143c150044507d79ce6e0aa11c6d3ea9fea8d8671bfb544.9fc575f23ec2b1fa71f7dbd6f219db3b',1738622806,'c7slsh62si6v362pjf6qhko8'),
('apiKey','0d4337ee08e648a3b632221b0dee9d1c4fa1cf8a3033f567adc97dc7ea916657bf7f5607e05cbf82c120c05ac8cfbed9.a009d8153341468be3aec5b2073fab7c',1738622852,'vcorj8fs080vri9erchhq1n9'),
('username','787148626d04e96d5d60dc5eca7094ef.8159655c8676bfc5f947e41b099f567d',1738622883,'ba5boqlkgbqz26hohqi20wg2'),
('password','769d4753ca160e8b9e4fad79f60c36a4.09f7d74b07c8a48fdfcb91e6b82d38fc',1738622883,'ba5boqlkgbqz26hohqi20wg2'),
('apiKey','04102877c705e7017ff483e0388547ed62af02bd8b1da7197868e397c168af232216c2ed3c223a85eaf60a9f2d9a45a7.dac41132117bb1b6d4d60b84f5e51d58',1738622911,'b2388yvmo1elxccy6n4m0vq4'),
('apiKey','0a1ea209db5db67d2bc441c2d85fd8965b0ccaf96dafd2e73aebde5ce16d41bc22a3ab41f87c56c7e384327bd6ed0100.f9e8b70dca57280220070bb404828b30',1738622938,'sfsgrn45218gk6bhs3ihnjbx'),
('apiKey','fa9e9deddabd21ebb4f4363a1d9ac58e3210ee9615663b6010e4f525ecf1ae713acfbcd9c33abbcd2d18e909b12e04ef.535e96461185c3f76f3267930678ba3a',1738622969,'iu2i3pkkaub7pgdfhoapau14'),
('apiKey','c4691ac9211846c581cbf4009daed215d6625e3dce53d6afd1469c5bcc9c38bce4abd102de8cfe346d93d7b76022f143fe1057f940176474dff568428e7622748b9908cfdf281390ca6979cd33f14203.8f9ab27277af13699075df0a0d073be0',1738623172,'j0lnfk0qmqwjqy4ju4llxa8h');


DELETE FROM integration;
INSERT INTO integration VALUES('c7slsh62si6v362pjf6qhko8','Sonarr','http://192.168.1.193:8989','sonarr'),
('vcorj8fs080vri9erchhq1n9','Sonarr 4K','http://192.168.1.193:8988','sonarr'),
('ba5boqlkgbqz26hohqi20wg2','qBittorrent','http://192.168.1.193:8200','qBittorrent'),
('b2388yvmo1elxccy6n4m0vq4','Radarr','http://192.168.1.193:7878','radarr'),
('sfsgrn45218gk6bhs3ihnjbx','Radarr 4K','http://192.168.1.193:7879','radarr'),
('iu2i3pkkaub7pgdfhoapau14','Prowlarr','http://192.168.1.193:9696','prowlarr'),
('j0lnfk0qmqwjqy4ju4llxa8h','Overseerr','http://192.168.1.193:5055','overseerr');


DELETE FROM item;
INSERT INTO item VALUES('a37wjfrui755c5gfkcxjl3cf','lqkpy0hut0pvnnyl3c9fklik','app',3,2,1,1,'{"json":{"appId":"pxidynz7p14nzno09w3866in","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('c6wiq7x80kypr1x2xr3yvx60','lqkpy0hut0pvnnyl3c9fklik','app',4,2,1,1,'{"json":{"appId":"flaji8e3ijrn4phhgizsdx92","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('o4fabvzin9mkvxd8k8zkzwa0','lqkpy0hut0pvnnyl3c9fklik','app',2,2,1,1,'{"json":{"appId":"orgbc3hfhlq4f3rhgx884s6y","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('nhm9rrxzqy7x33rvao774uhh','lqkpy0hut0pvnnyl3c9fklik','app',5,2,1,1,'{"json":{"appId":"cyobs6cgq6lh6h9pcdz64mjx","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('pozpcaapdfmyzznqwtn1df9m','lqkpy0hut0pvnnyl3c9fklik','app',8,3,1,1,'{"json":{"appId":"qq9ip1i1m86ddutn0080hfd8","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('vngkq5u8bevgpvymhr7s8bik','lqkpy0hut0pvnnyl3c9fklik','app',8,4,1,1,'{"json":{"appId":"su15mjnjauzr8ah2hglx6e5v","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('u0avnovwkpw6s67pmyf66el4','lqkpy0hut0pvnnyl3c9fklik','app',9,3,1,1,'{"json":{"appId":"etdh2ag2a9x40vanrgq60mts","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('jac7pgy91gmwb7obpkgkiv2c','lqkpy0hut0pvnnyl3c9fklik','app',9,4,1,1,'{"json":{"appId":"k5e2hgeiqxi5ntq1zfthi8z4","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('bjninlmfv3erpnaekaqdh2y9','lqkpy0hut0pvnnyl3c9fklik','downloads',0,3,8,3,'{"json":{"columns":["integration","name","progress","time","actions","size","type","received","sent","state","added","ratio"],"enableRowSorting":true,"defaultSort":"progress","descendingDefaultSort":false,"showCompletedUsenet":true,"showCompletedTorrent":true,"activeTorrentThreshold":0,"categoryFilter":[],"filterIsWhitelist":false,"applyFilterToRatio":true}}','{"json":{"customCssClasses":[]}}'),
('hqds9raofstjq06nko6rmmdl','lqkpy0hut0pvnnyl3c9fklik','mediaRequests-requestList',6,0,4,3,'{"json":{"linksTargetNewTab":true}}','{"json":{"customCssClasses":[]}}'),
('h6q7chug1flgbln3wsuqomba','lqkpy0hut0pvnnyl3c9fklik','indexerManager',0,0,2,3,'{"json":{"openIndexerSiteInNewTab":true}}','{"json":{"customCssClasses":[]}}'),
('zv1u9i70gk9nhn82jom5r32s','lqkpy0hut0pvnnyl3c9fklik','mediaRequests-requestStats',2,0,4,2,'{"json":{}}','{"json":{"customCssClasses":[]}}'),
('q4l4wottwx8h893lcpn61ib7','lqkpy0hut0pvnnyl3c9fklik','app',9,5,1,1,'{"json":{"appId":"l0k5fdrqyj7927g63iwg22a7","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}'),
('hzfuxznrljmqrqwzq2vunho9','lqkpy0hut0pvnnyl3c9fklik','app',8,5,1,1,'{"json":{"appId":"xkerauiy02lfi9kbuzvoxmbx","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":true,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');

DELETE FROM serverSetting;
INSERT INTO serverSetting VALUES('analytics','{"json":{"enableGeneral":false,"enableWidgetData":false,"enableIntegrationData":false,"enableUserData":false}}'),
('crawlingAndIndexing','{"json":{"noIndex":true,"noFollow":true,"noTranslate":true,"noSiteLinksSearchBox":false}}'),
('board','{"json":{"homeBoardId":null,"mobileHomeBoardId":null}}'),
('appearance','{"json":{"defaultColorScheme":"light"}}'),
('culture','{"json":{"defaultLocale":"en"}}'),
('search','{"json":{"defaultSearchEngineId":null}}');

DELETE FROM section;
INSERT INTO section VALUES('lqkpy0hut0pvnnyl3c9fklik','vjek9rh6rx5ms6oa63y9u9ig','empty',0,0,NULL,NULL,NULL,NULL);


DELETE FROM search_engine;
INSERT INTO search_engine VALUES('ycvmvrl8xhd0fyh2smpj4flb','https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons@master/png/overseerr.png','Overseerr','o',NULL,NULL,'fromIntegration','j0lnfk0qmqwjqy4ju4llxa8h');

DELETE FROM onboarding;
INSERT INTO onboarding VALUES('ns7yqyt0yhimqn9o2g6pqvef','finish','settings');
