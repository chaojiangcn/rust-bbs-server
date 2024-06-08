-- ----------------------------
-- Table structure for ums_member
-- ----------------------------
DROP TABLE IF EXISTS `ums_user`;
CREATE TABLE `ums_user`
(
    `id`                 bigint NOT NULL AUTO_INCREMENT,
    `username`           varchar(32)     DEFAULT NULL,
    `email`              varchar(128)    DEFAULT NULL,
    `email_verified`     tinyint(1) NOT NULL DEFAULT '0',
    `nickname`           varchar(16)     DEFAULT NULL,
    `avatar`             text,
    `gender`             varchar(16)     DEFAULT '',
    `birthday`           datetime(3) DEFAULT NULL,
    `background_image`   text,
    `password`           varchar(512)    DEFAULT NULL,
    `home_page`          varchar(1024)   DEFAULT NULL,
    `description`        text,
    `score`              int    NOT NULL,
    `status`             int    NOT NULL,
    `topic_count`        int    NOT NULL,
    `comment_count`      int    NOT NULL,
    `follow_count`       int    NOT NULL,
    `fans_count`         int    NOT NULL,
    `roles`              text,
    `create_time`        bigint          DEFAULT NULL,
    `update_time`        bigint          DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`),
    UNIQUE KEY `email` (`email`),
    KEY                  `idx_user_score` (`score`),
    KEY                  `idx_user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 初始化用户数据（用户名：admin、密码：123456）
INSERT INTO ums_user (
    `id`,
    `username`,
    `nickname`,
    `avatar`,
    `email`,
    `password`,
    `status`,
    `create_time`,
    `update_time`,
    `roles`,
    `description`,
    `topic_count`,
    `comment_count`,
    `score`,
    `follow_count`,
    `fans_count`
  )
SELECT 1,
       'admin',
       'rust-bbs站长',
       '',
       'a@example.com',
       '$2a$10$ofA39bAFMpYpIX/Xiz7jtOMH9JnPvYfPRlzHXqAtLPFpbE/cLdjmS',
       0,
       (UNIX_TIMESTAMP(now()) * 1000),
       (UNIX_TIMESTAMP(now()) * 1000),
       'owner',
       '轻轻地我走了，正如我轻轻的来。',
       0,
       0,
       0,
       0,
       0
FROM DUAL
WHERE NOT EXISTS(SELECT *
                 FROM `ums_user`
                 WHERE `id` = 1);