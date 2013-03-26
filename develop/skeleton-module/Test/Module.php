<?php

namespace Test;

use Zend\EventManager\EventInterface,
    Zend\ModuleManager\Feature\ControllerProviderInterface,
    Zend\ModuleManager\Feature\ServiceProviderInterface,
    Zend\ModuleManager\Feature\ViewHelperProviderInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
    implements ServiceProviderInterface, ControllerProviderInterface, ViewHelperProviderInterface
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getControllerConfig()
    {
        return array(
            'factories' => array(
                'Test\Controller\Index' => function($sm) {
                    $ins = new Controller\IndexController();
                    return $ins;
                },
            )
        );
    }
    
    public function getViewHelperConfig()
    {
        return array(
            'factories' => array(
                'test' => function($sm) {
                    $ins = new View\Helper\Test();
                    return $ins;
                },
            )
        );
    }
    
    public function getServiceConfig()
    {
        return array(
            'invokables' => array(
                //'KapitchiAuction\Entity\Auction' => 'KapitchiAuction\Entity\Auction',
            ),
            'factories' => array(
//                'KapitchiAuction\Form\Auction' => function ($sm) {
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