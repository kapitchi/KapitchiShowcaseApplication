<?php

namespace Test;

use Zend\EventManager\Event,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
{

	public function onBootstrap(Event $e) {
		parent::onBootstrap($e);
		
	}
	
    public function getDir() {
        return __DIR__;
    }

    public function getNamespace() {
        return __NAMESPACE__;
    }

}