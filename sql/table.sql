-- package
CREATE TABLE `package` (
  `id`        INTEGER        NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `host`      ENUM('github') NOT NULL DEFAULT 'github',
  `owner`     VARCHAR(256)   NOT NULL,
  `repo`      VARCHAR(256)   NOT NULL,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX `package_host_owner_repo_uniq`
  ON `package`(`host`, `owner`, `repo`);

-- package_deps
CREATE TABLE `package_deps` (
  `id`         INTEGER   NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `package_id` INTEGER   NOT NULL,
  `version`    BIGINT    NOT NULL,
  `deps_data`  TEXT      NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`package_id`) REFERENCES `package`(`id`)
);

CREATE UNIQUE INDEX `package_deps_package_id_version_uniq`
  ON `package_deps`(`package_id`, `version`);
