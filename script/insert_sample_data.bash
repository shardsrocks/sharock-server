#!/bin/bash

set -xe

{
  echo 'INSERT INTO `package`'
  echo '  (`id`, `host`, `owner`, `repo`) values (1, "github", "pine613", "Shiro");'

  echo 'INSERT INTO `package_deps`'
  echo '  (`package_id`, `version`, `deps_data`) values (1, 1, "[]");'
} | mysql -uroot sharock
