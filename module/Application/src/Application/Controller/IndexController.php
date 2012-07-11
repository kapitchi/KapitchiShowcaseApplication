<?php

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{
    public function indexAction()
    {
        $ret = $this->getServiceLocator()->get('KapitchiAuction\Service\RoundState');
        $x = $ret->getPaginator();
        var_dump($x->getCurrentItems());
//        $x = $ret->persist(array(
//            'refNumber' => 'XXXX',
//            'state' => 'active'
//        ));
        var_dump($x);
        exit;
        return new ViewModel();
    }
}
