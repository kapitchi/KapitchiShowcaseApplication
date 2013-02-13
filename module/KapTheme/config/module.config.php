<?php
return array(
    'assetic_configuration' => array(
        'default' => array(
            'assets' => array(
                //'@base_css',
                //'@base_js',
            ),
            'options' => array(
                'mixin' => true,
            ),
        ),
        'modules' => array(
            'kaptheme' => array(
                'root_path' => __DIR__ . '/../assets',
                'collections' => array(
                    'base_css' => array(
                        'assets' => array(
                            'css/bootstrap-responsive.min.css',
                            //'css/style.css',
                            'css/bootstrap.min.css'
                        ),
                        'filters' => array(
                            /*'CssRewriteFilter' => array(
                                'name' => 'Assetic\Filter\CssRewriteFilter'
                            )*/
                        ),
                    ),
                    'base_js' => array(
                        'assets' => array(
                            'js/jquery.min.js',
                            'js/bootstrap.min.js',
                        ),
                    ),
                    'base_images' => array(
                        'assets' => array(
                            'img/*.png',
                            'img/*.jpg',
                        ),
                        'options' => array(
                            'move_raw' => true,
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
            'theme' => __DIR__ . '/../view',
        ),
        'helper_map' => array(
            //'js'        => 'Test\View\Helper\Js',
        ),

    ),
    'router' => array(
        'routes' => require 'routes.config.php'
    ),
);
