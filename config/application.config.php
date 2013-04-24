<?php
return array(
    'modules' => array(
        'ZfcTwig',
        'KapitchiBase',
        'KapitchiApp',
        //'AsseticBundle',
        'KapitchiEntity',
        'KapitchiIdentity',
        'KapitchiContact',
        'KapitchiProcess',
        'KapitchiFileManager',
        'KapTheme',
        'KapAngularTheme',
        'KapShowcaseApp',
        'KapCalendar',
        'KapitchiLocation',
        'KapLayout'
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
