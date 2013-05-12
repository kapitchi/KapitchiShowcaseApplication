<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/GPL-3.0 GPL 3.0
 */

namespace KapShowcaseApp\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{
    public function indexAction()
    {
        return new ViewModel();
    }
    
    public function manualAction()
    {
        return array(
            'embedUrl' => 'https://docs.google.com/document/d/1SwVkie9X-ftCo7zpfzM1crdsiQGT0aXmSue4vHIlnH4/pub?embedded=true'
        );
    }
}
