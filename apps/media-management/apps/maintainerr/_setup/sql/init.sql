-- Settings for Plex & Overseerr
DELETE FROM settings;
INSERT INTO settings (id, clientId, applicationTitle, applicationUrl, apikey, overseerr_url, locale, cacheImages, plex_name, plex_hostname, plex_port, plex_ssl, plex_auth_token, overseerr_api_key, collection_handler_job_cron, rules_handler_job_cron, tautulli_url, tautulli_api_key) VALUES
(1, '4a7c22b5-ff4a-4e9c-a350-438b11bee4b3', 'Maintainerr', '${HOST_IP}', '${API_KEY_MAINTAINERR}', '${HOST_IP}:${PORT_UI_OVERSEERR}/', 'en', 1, 'Home Lab', '${HOST_IP}', '${PORT_UI_PLEX}', 0, '${PLEX_CLAIM}', '${API_KEY_OVERSEERR}', '0 0-23/12 * * *', '0 0-23/8 * * *', NULL, NULL);

-- Radarr Configuration
DELETE FROM radarr_settings;
INSERT INTO radarr_settings (id, serverName, url, apiKey) VALUES
(1, 'Radarr 4K', '${HOST_IP}:${PORT_UI_RADARR4K}', '${API_KEY_RADARR4K}'),
(2, 'Radarr', '${HOST_IP}:${PORT_UI_RADARR}', '${API_KEY_RADARR}');

-- Sonarr Configuration
DELETE FROM sonarr_settings;
INSERT INTO sonarr_settings (id, serverName, url, apiKey) VALUES
(1, 'Sonarr', '${HOST_IP}:${PORT_UI_SONARR}', '${API_KEY_SONARR}'),
(2, 'Sonarr 4K', '${HOST_IP}:${PORT_UI_SONARR4K}', '${API_KEY_SONARR4K}');