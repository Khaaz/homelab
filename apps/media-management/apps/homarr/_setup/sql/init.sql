BEGIN TRANSACTION;

DELETE FROM app;
INSERT INTO app VALUES('qa2nftgnccmo9qphrf5fdt40','Plex',NULL,'https://cdn.jsdelivr.net/gh/PapirusDevelopmentTeam/papirus_icons//src/apps_plex.svg','http://10.0.0.193:32400',NULL);
INSERT INTO app VALUES('ie6vdpafan48jeo1loagsank','Overseerr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/overseerr.svg','http://10.0.0.193:5055',NULL);
INSERT INTO app VALUES('takcxnjag23gpex84cl03q8w','Radarr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/radarr.svg','http://10.0.0.193:7878',NULL);
INSERT INTO app VALUES('chcc8yafd4v9ohuk3ra7a1ro','Radarr 4K',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/radarr.svg','http://10.0.0.193:7879',NULL);
INSERT INTO app VALUES('pl580zvb1kfrt5pi2aof1vg0','Sonarr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/sonarr.svg','http://10.0.0.193:8989',NULL);
INSERT INTO app VALUES('ufju0qamihtujc4qtre6pukw','Sonarr 4K',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/sonarr.svg','http://10.0.0.193:8988',NULL);
INSERT INTO app VALUES('lsf1umwln5u4g445u6ik05ig','Prowlarr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/prowlarr.svg','http://10.0.0.193:9696',NULL);
INSERT INTO app VALUES('apfgo14h4bdhqs40jnda2ubg','Bazarr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/bazarr.svg','http://10.0.0.193:6767',NULL);
INSERT INTO app VALUES('mgztvkhv3uba10z9kqo9mrgq','Qbit',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/qbittorrent.svg','http://10.0.0.193:8200',NULL);
INSERT INTO app VALUES('vziul3h5f2c069yit3lq85f9','Maintainerr',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/mailinabox.svg','http://10.0.0.193:6246',NULL);
INSERT INTO app VALUES('f3zvhh5iayt7mmpl826qj9wk','Nextcloud',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/nextcloud.svg','http://10.0.0.193:8081',NULL);
INSERT INTO app VALUES('ri76cww3j34i8wfelmsyb4k1','VS Code',NULL,'https://cdn.jsdelivr.net/gh/PapirusDevelopmentTeam/papirus_icons//src/apps_visual_studio_code.svg','http://10.0.0.193:8086',NULL);
INSERT INTO app VALUES('njfvbyet5d07nydevbg05pw8','Bitwarden',NULL,'https://cdn.jsdelivr.net/gh/loganmarchione/homelab-svg-assets//assets/bitwarden.svg','http://10.0.0.193:8084',NULL);

DELETE FROM board;
INSERT INTO board VALUES('ns7hsts5suts6mxnugtms5ao','NAS',0,'u7244dlnslslgi01127mzulv',NULL,NULL,NULL,NULL,NULL,'fixed','no-repeat','cover','#fa5252','#fd7e14',100,NULL,0,'lg',NULL);

DELETE FROM integration_item;
INSERT INTO integration_item VALUES('y9zotr7w1kn3xkoditevhnto','w4ou9a186gk3o6ujvmq9h458');
INSERT INTO integration_item VALUES('ugasdlqojdb3wel6459swwz5','obwnp90fcp06jox9juw6hf7d');
INSERT INTO integration_item VALUES('wz6uck2hszuxlpzpbeaaz759','w1q6nwd974uz4z0cchrf7bwp');
INSERT INTO integration_item VALUES('ra4wpgccbf95h632fdmjhsj7','w1q6nwd974uz4z0cchrf7bwp');

DELETE FROM integrationSecret;
INSERT INTO integrationSecret VALUES('username','86c7674b9fd07d156a37b32aa74df8cc.33e03cd73e949372d08d6a9c85cf3410',1741522868,'w4ou9a186gk3o6ujvmq9h458');
INSERT INTO integrationSecret VALUES('password','cd3f6521104722c8072d893c1055646f.811c3a1e1120a9d56997e3a484f6a712',1741522868,'w4ou9a186gk3o6ujvmq9h458');
INSERT INTO integrationSecret VALUES('apiKey','16733fa1f0f7cd3013023d5199df2eb11ebc382962b8fac336495f3341f8cf2b5e2ca99a24fb1960018740dfa05aa02c.4c5b7cc9e4f00b06e6495fc8e9a57059',1741524218,'rcdwlk9xy6v2fu87o08pqncw');
INSERT INTO integrationSecret VALUES('apiKey','2594338ecd1c057ec72349f9073a254f03408a5b0788a260ad4452155948f44d0abd5620baaa2d7fa5b94e98a27e4757.a81a1c2e39ad31696a16fb9594e9e392',1741524283,'obevw2ch1hhvyf81b6l2o0lq');
INSERT INTO integrationSecret VALUES('apiKey','ae1c89c66ead614476c39023b5ef340ce1a494b73f052aed304af36037fa7cff0a140a639ec23999e1b07a85169a5931.394dc73f6cc3c84e07cf00aeecc7a674',1741524312,'fymnhsisr3yrs8r61mrld52p');
INSERT INTO integrationSecret VALUES('apiKey','bbb97178cc8338d23826dc490af8edba2b9952a2d880234e6b55a789b4471f5d67e58981d7a2084b62013c1ce1ef8d93.d41046302f60398840b8f070d7411034',1741524334,'hsalecpo5y9q1z3qm4n8xb72');
INSERT INTO integrationSecret VALUES('apiKey','a68eb05dfc21e9a6d04b8ad4863ff56edf98d3151dd3d65d9e0982ad5056a2a172ee786cf6e6a37094633ca16745469c.442161a7493aa8d5db445365405e2c3f',1741524365,'obwnp90fcp06jox9juw6hf7d');
INSERT INTO integrationSecret VALUES('apiKey','70db47c31248a396eeafeb39adb07b6ad0e9938e41a1f120a7469cb0c37126f5.11e73bf91a6d04d9d497b140a1111831',1741524440,'vbm11928bb2srvp56wbl52rq');
INSERT INTO integrationSecret VALUES('apiKey','1d33fda2276185d49c1ee1de079f18a307cb6eeb88cdc145b38d4343bbdef30ecca94c19c19acb7e0202a62cffa3d8444374c88d4d862558825673b1b3772b929279afe47f296fa724052522ab712e29.6699104d77426e5a82cf129ba66fbba7',1741524475,'w1q6nwd974uz4z0cchrf7bwp');

DELETE FROM integration;
INSERT INTO integration VALUES('w4ou9a186gk3o6ujvmq9h458','qBittorrent','http://10.0.0.193:8200','qBittorrent');
INSERT INTO integration VALUES('rcdwlk9xy6v2fu87o08pqncw','Sonarr','http://10.0.0.193:8989','sonarr');
INSERT INTO integration VALUES('obevw2ch1hhvyf81b6l2o0lq','Sonarr 4K','http://10.0.0.193:8988','sonarr');
INSERT INTO integration VALUES('fymnhsisr3yrs8r61mrld52p','Radarr','http://10.0.0.193:7878','radarr');
INSERT INTO integration VALUES('hsalecpo5y9q1z3qm4n8xb72','Radarr 4K','http://10.0.0.193:7879','radarr');
INSERT INTO integration VALUES('obwnp90fcp06jox9juw6hf7d','Prowlarr','http://10.0.0.193:9696','prowlarr');
INSERT INTO integration VALUES('vbm11928bb2srvp56wbl52rq','Plex','http://10.0.0.193:32400','plex');
INSERT INTO integration VALUES('w1q6nwd974uz4z0cchrf7bwp','Overseerr','http://10.0.0.193:5055','overseerr');

DELETE FROM serverSetting;
INSERT INTO serverSetting VALUES('analytics','{"json":{"enableGeneral":false,"enableWidgetData":false,"enableIntegrationData":false,"enableUserData":false}}');
INSERT INTO serverSetting VALUES('crawlingAndIndexing','{"json":{"noIndex":true,"noFollow":true,"noTranslate":true,"noSiteLinksSearchBox":false}}');
INSERT INTO serverSetting VALUES('board','{"json":{"homeBoardId":null,"mobileHomeBoardId":null,"enableStatusByDefault":true,"forceDisableStatus":false}}');
INSERT INTO serverSetting VALUES('appearance','{"json":{"defaultColorScheme":"dark"}}');
INSERT INTO serverSetting VALUES('culture','{"json":{"defaultLocale":"en"}}');
INSERT INTO serverSetting VALUES('search','{"json":{"defaultSearchEngineId":null}}');

DELETE FROM search_engine;
INSERT INTO search_engine VALUES('yvviq23bbyr0mikdnfxomm6z','https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons@master/svg/overseerr.svg','Overseerr','o',NULL,NULL,'fromIntegration','w1q6nwd974uz4z0cchrf7bwp');

DELETE FROM groupMember;
INSERT INTO groupMember VALUES('k0v3k22ukrrq19semg7c7rtj','u7244dlnslslgi01127mzulv');
INSERT INTO groupMember VALUES('obt4z0lc32m17se4oh8hu3zr','u7244dlnslslgi01127mzulv');

DELETE FROM groupPermission;
INSERT INTO groupPermission VALUES('k0v3k22ukrrq19semg7c7rtj','admin');

DELETE FROM session;
INSERT INTO session VALUES('586c908fe9afe381a786c6b29c2580eac9bf2bbcde5286f23b07bc4c7067c5d9785fb1f5e44583034212d99e999abb90','u7244dlnslslgi01127mzulv',1744114704082);

DELETE FROM onboarding;
INSERT INTO onboarding VALUES('lc2eihxk3fmrtmlyxxu65crv','finish','settings');

DELETE FROM user;
INSERT INTO user VALUES('u7244dlnslslgi01127mzulv','dgladieux',NULL,NULL,NULL,'$2b$10$75yxqb.feX3VuABSy/G2F.pPq9Qs5uH4eKW5ISP/6AMgXqIFN1owi','$2b$10$75yxqb.feX3VuABSy/G2F.','credentials','ns7hsts5suts6mxnugtms5ao','ns7hsts5suts6mxnugtms5ao','yvviq23bbyr0mikdnfxomm6z',1,'dark',1,0);

DELETE FROM group;
INSERT INTO "group" VALUES('obt4z0lc32m17se4oh8hu3zr','everyone',NULL,NULL,NULL,-1);
INSERT INTO "group" VALUES('k0v3k22ukrrq19semg7c7rtj','credentials-admin','u7244dlnslslgi01127mzulv',NULL,NULL,0);

DELETE FROM item_layout;
INSERT INTO item_layout VALUES('y9zotr7w1kn3xkoditevhnto','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',0,0,4,3);
INSERT INTO item_layout VALUES('ugasdlqojdb3wel6459swwz5','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',4,0,2,3);
INSERT INTO item_layout VALUES('wz6uck2hszuxlpzpbeaaz759','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',6,0,4,3);
INSERT INTO item_layout VALUES('ra4wpgccbf95h632fdmjhsj7','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',0,3,3,3);
INSERT INTO item_layout VALUES('xnhv66z6cwj90xs0isnm0fo8','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',9,4,1,1);
INSERT INTO item_layout VALUES('qqe8vldaj2rvznsnvahldcn4','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',4,3,1,1);
INSERT INTO item_layout VALUES('h7hd0lctwh6i1tqub8ot3hxi','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',3,3,1,1);
INSERT INTO item_layout VALUES('viltqbl3tjk9z202eglpfna9','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',5,3,1,1);
INSERT INTO item_layout VALUES('jix5venp7tvfy9m9jh2vktcf','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',7,3,1,1);
INSERT INTO item_layout VALUES('mu6nf4zes8k6ye5vdpvbt3qu','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',6,3,1,1);
INSERT INTO item_layout VALUES('gzl6q6y17tl74rejyyhr0bqj','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',9,3,1,1);
INSERT INTO item_layout VALUES('ljjfvs6h87cl88d9w5roz228','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',8,3,1,1);
INSERT INTO item_layout VALUES('dr9rn67vrws3zqlxynhjvb7l','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',3,4,1,1);
INSERT INTO item_layout VALUES('gmcbi98k1wmlyc7nohydwcln','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',7,4,1,1);
INSERT INTO item_layout VALUES('jxc7xtfcegp6h10oowumt1s5','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',5,4,1,1);
INSERT INTO item_layout VALUES('waypi3vgb0kojfui4z03ndap','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',8,4,1,1);
INSERT INTO item_layout VALUES('qumdwdmhlhe6vuf6ifd1awoo','bltv81juwo31qs328mdnymzm','rb0u4pizeyaj0p31xwi11wpw',4,4,1,1);

DELETE FROM layout;
INSERT INTO layout VALUES('rb0u4pizeyaj0p31xwi11wpw','Base','ns7hsts5suts6mxnugtms5ao',10,0);

DELETE FROM item;
INSERT INTO item VALUES('y9zotr7w1kn3xkoditevhnto','ns7hsts5suts6mxnugtms5ao','downloads','{"json":{"columns":["integration","name","progress","time","actions"],"enableRowSorting":true,"defaultSort":"type","descendingDefaultSort":false,"showCompletedUsenet":true,"showCompletedTorrent":true,"activeTorrentThreshold":0,"categoryFilter":[],"filterIsWhitelist":false,"applyFilterToRatio":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('ugasdlqojdb3wel6459swwz5','ns7hsts5suts6mxnugtms5ao','indexerManager','{"json":{"openIndexerSiteInNewTab":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('wz6uck2hszuxlpzpbeaaz759','ns7hsts5suts6mxnugtms5ao','mediaRequests-requestList','{"json":{"linksTargetNewTab":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('ra4wpgccbf95h632fdmjhsj7','ns7hsts5suts6mxnugtms5ao','mediaRequests-requestStats','{"json":{}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('xnhv66z6cwj90xs0isnm0fo8','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"apfgo14h4bdhqs40jnda2ubg","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('qqe8vldaj2rvznsnvahldcn4','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"ie6vdpafan48jeo1loagsank","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('h7hd0lctwh6i1tqub8ot3hxi','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"qa2nftgnccmo9qphrf5fdt40","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('viltqbl3tjk9z202eglpfna9','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"lsf1umwln5u4g445u6ik05ig","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('jix5venp7tvfy9m9jh2vktcf','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"takcxnjag23gpex84cl03q8w","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('mu6nf4zes8k6ye5vdpvbt3qu','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"chcc8yafd4v9ohuk3ra7a1ro","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('gzl6q6y17tl74rejyyhr0bqj','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"pl580zvb1kfrt5pi2aof1vg0","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('ljjfvs6h87cl88d9w5roz228','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"ufju0qamihtujc4qtre6pukw","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('dr9rn67vrws3zqlxynhjvb7l','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"njfvbyet5d07nydevbg05pw8","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('gmcbi98k1wmlyc7nohydwcln','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"vziul3h5f2c069yit3lq85f9","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('jxc7xtfcegp6h10oowumt1s5','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"f3zvhh5iayt7mmpl826qj9wk","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('waypi3vgb0kojfui4z03ndap','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"mgztvkhv3uba10z9kqo9mrgq","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');
INSERT INTO item VALUES('qumdwdmhlhe6vuf6ifd1awoo','ns7hsts5suts6mxnugtms5ao','app','{"json":{"appId":"ri76cww3j34i8wfelmsyb4k1","openInNewTab":true,"showTitle":true,"showDescriptionTooltip":false,"pingEnabled":true}}','{"json":{"customCssClasses":[]}}');

DELETE FROM section;
INSERT INTO section VALUES('bltv81juwo31qs328mdnymzm','ns7hsts5suts6mxnugtms5ao','empty',0,0,NULL,'{"json": {}}');

COMMIT;
