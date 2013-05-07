<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

namespace KapBootstrapTheme;

use Zend\EventManager\EventInterface,
    Zend\ModuleManager\Feature\ServiceProviderInterface,
    Zend\ModuleManager\Feature\ViewHelperProviderInterface,
    Zend\ModuleManager\Feature\ControllerPluginProviderInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
    implements ServiceProviderInterface, ViewHelperProviderInterface, ControllerPluginProviderInterface
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getControllerPluginConfig()
    {
        return array(
            'factories' => array(
                'asdfdsngular' => function($sm) {
                    $ins = new Mvc\Controller\Plugin\Angular();
                    return $ins;
                },
            )
        );
    }
    
    public function getControllerConfig()
    {
        return array(
            'factories' => array(
                //API
                'KdsfsdfdsapTfsdfheme\Controller\Api\Template' => function($sm) {
                    $cont = new Controller\Api\TemplateController();
                    return $cont;
                },
            )
        );
    }
    
    public function getViewHelperConfig()
    {
        return array(
            'factories' => array(
                   
            )
        );
    }
    
    public function getServiceConfig()
    {
        return array(
            'invokables' => array(
                //'KapAuction\Entity\Auction' => 'KapAuction\Entity\Auction',
            ),
            'factories' => array(
//                'KapAuction\Form\Auction' => function ($sm) {
//                    $ins = new Form\Auction();
//                    return $ins;
//                },
            )
        );
    }
    
    public function getDir() {
        return __DIR__;
    }

    public function getNamespace() {
        return __NAMESPACE__;
    }
}