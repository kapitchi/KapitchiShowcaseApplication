<?php
return array(
    'assetic_configuration' => array(
        'default' => array(
            'assets' => array(
                //'@angular_js',
            ),
        ),
        'modules' => array(
            'kapangulartheme' => array(
                'root_path' => __DIR__ . '/../assets',
                'collections' => array(
                    'angular_js' => array(
                        'assets' => array(
                            'http://cdn.jsdelivr.net/angularjs/1.1.2/angular.js',
                            'http://cdn.jsdelivr.net/angularjs/1.1.2/angular-resource.js',
                            'js/KapitchiIdentity.js',
                        ),
                        'options' => array(
                            //'move_raw' => true,
                        )
                    ),
                ),
            ),
        ),
    ),
    'view_manager' => array(
        'template_map' => array(
            //'test/index/index'   => __DIR__ . '/../view/test/index/index.phtml',
        ),
        'template_path_stack' => array(
            'angular-theme' => __DIR__ . '/../view',
        ),
        'helper_map' => array(
            //'js'        => 'Test\View\Helper\Js',
        ),

    ),
    'router' => array(
        'routes' => require 'routes.config.php'
    ),
);
