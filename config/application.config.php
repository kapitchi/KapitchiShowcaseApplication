<?php
return array(
    'modules' => array(
        'KapShowcaseApp',
        'KapitchiBase',
        'KapitchiApp',
        //'AsseticBundle',
        'KapitchiEntity',
        'KapitchiIdentity',
        'KapitchiContact',
        'KapitchiProcess',
        'KapTheme',
        //'KapAngularTheme',
    ),
    'module_listener_options' => array(
        'config_glob_paths'    => array(
            'config/autoload/{,*.}{global,local}.php',
        ),
        'module_paths' => array(
            './module',
            './module-dev',
            './vendor',
        ),
    ),
    'service_manager' => array(
        'use_defaults' => true,
        'factories'    => array(
        ),
    ),
);
