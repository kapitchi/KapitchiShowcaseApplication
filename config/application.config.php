<?php
return array(
    'modules' => array(
        //'ZfcTwig',$this->partial() did not work? why was it so?
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
        'KapCalendar',
        'KapitchiLocation',
        'KapLayout',
        'KapMessage',
        'KapShowcaseApp',
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
