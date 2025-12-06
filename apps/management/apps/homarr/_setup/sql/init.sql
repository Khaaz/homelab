-- onboarding
DELETE FROM "onboarding";
INSERT INTO onboarding (id, step, previous_step) VALUES
('bim2uon2s8jmgouep7qp2nmo', 'finish', 'settings');

-- serverSetting
DELETE FROM serverSetting;
INSERT INTO serverSetting (setting_key, value) 
VALUES 
('analytics', '{"json":{"enableGeneral":false,"enableWidgetData":false,"enableIntegrationData":false,"enableUserData":false}}'),
('crawlingAndIndexing', '{"json":{"noIndex":true,"noFollow":true,"noTranslate":true,"noSiteLinksSearchBox":true}}'),
('board', '{"json":{"homeBoardId":null,"mobileHomeBoardId":null,"enableStatusByDefault":true,"forceDisableStatus":false}}'),
('appearance', '{"json":{"defaultColorScheme":"dark"}}'),
('culture', '{"json":{"defaultLocale":"en"}}'),
('search', '{"json":{"defaultSearchEngineId":"hsdagj9xrz90rz5a4jzf5f32"}}');

-- user
INSERT INTO "user" (
    id, name, email, email_verified, image, password, salt, provider,
    home_board_id, mobile_home_board_id, default_search_engine_id,
    open_search_in_new_tab, color_scheme, first_day_of_week, ping_icons_enabled
) VALUES (
    '3e757717-4897-4869-8744-749eed57b3f8', 'admin_default', 'admin_default@${INTERNAL_DOMAIN}', NULL,
    NULL, NULL, NULL, 'oidc', NULL, NULL, NULL, 1, 'dark', 1, 0
);

-- group
DELETE FROM "group";
INSERT INTO "group" 
	(id, name, owner_id, home_board_id, mobile_home_board_id, position) 
VALUES
('cz6k28cl66l4jl15akp7wdcd', 'everyone', NULL,  NULL, NULL, -1),
('wdo2ozpg62t2wfnrt7mq4jfi', 'admin', '3e757717-4897-4869-8744-749eed57b3f8', NULL, NULL, 0);

-- groupPermission
DELETE FROM groupPermission;
INSERT INTO groupPermission (group_id, permission) VALUES
('wdo2ozpg62t2wfnrt7mq4jfi', 'admin');

-- board
DELETE FROM board;
INSERT INTO board (
    id, name, is_public, creator_id, page_title, meta_title, logo_image_url,
    favicon_image_url, background_image_url, background_image_attachment,
    background_image_repeat, background_image_size, primary_color,
    secondary_color, opacity, custom_css, disable_status, item_radius, icon_color
) VALUES (
    'b0snu3zaxpw9eem4cwzeobf2', 'Dashboard', 0, '3e757717-4897-4869-8744-749eed57b3f8',
    NULL, NULL, NULL, NULL, NULL, 'fixed', 'no-repeat', 'cover',
    '#fa5252', '#fd7e14', 100, NULL, 0, 'lg', NULL
);

-- layout
DELETE FROM layout;
INSERT INTO layout (id, name, board_id, column_count, breakpoint) VALUES
('cphzq8b4czuru9rg5g7tb6ku', 'Base', 'b0snu3zaxpw9eem4cwzeobf2', 10, 0);

-- section
DELETE FROM section;
INSERT INTO section (id, board_id, kind, x_offset, y_offset, name, options) VALUES
('fto52sd4i6ollxds0637r0w1', 'b0snu3zaxpw9eem4cwzeobf2', 'empty', 0, 0, NULL, '{"json": {}}');

--- group / default board
UPDATE "group"
SET home_board_id = 'b0snu3zaxpw9eem4cwzeobf2',
    mobile_home_board_id = 'b0snu3zaxpw9eem4cwzeobf2'
WHERE id = 'wdo2ozpg62t2wfnrt7mq4jfi';
