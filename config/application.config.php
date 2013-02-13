<?php
return array(
    'modules' => array(
        'KapShowcaseApp',
        'KapitchiBase',
        'KapitchiApp',
        'KapTheme',
        'KapAngularTheme',
        //'AsseticBundle',
        'KapitchiEntity',
        'KapitchiIdentity',
        'KapitchiProcess',
    ),
    'module_listener_options' => array(
        'config_glob_paths'    => array(
            'config/autoload/{,*.}{global,local}.php',
        ),
        'module_paths' => array(
            './module',
            './vendor',
        ),
    ),
    'service_manager' => array(
        'use_defaults' => true,
        'factories'    => array(
        ),
    ),
);
