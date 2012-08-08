<?php

namespace Test;

use Zend\EventManager\EventInterface,
    Zend\ModuleManager\Feature\ControllerProviderInterface,
    Zend\ModuleManager\Feature\ServiceProviderInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule implements ServiceProviderInterface, ControllerProviderInterface
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getControllerConfig()
    {
        return array(
            'factories' => array(
                'Test\Controller\Index' => function($sm) {
                    $cont = new Controller\TestController();
                    return $cont;
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
//                'KapitchiAuction\ModuleOptions' => function ($sm) {
//                    $config = $sm->get('Configuration');
//                    return new ModuleOptions(isset($config['KapitchiAuction']) ? $config['KapitchiAuction'] : array());
//                },
//                'KapitchiAuction\Form\Auction' => function ($sm) {
//                    $form = new Form\Auction();
//                    return $form;
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