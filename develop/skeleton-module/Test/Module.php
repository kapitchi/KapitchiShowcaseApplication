<?php

namespace Test;

use Zend\EventManager\EventInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getDir() {
        return __DIR__;
    }

    public function getNamespace() {
        return __NAMESPACE__;
    }

}