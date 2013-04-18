<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

namespace KapTheme\Controller\Api;

use Zend\View\Model\ViewModel;

/**
 *
 * @author Matus Zeman <mz@kapitchi.com>
 */
class TemplateController extends \Zend\Mvc\Controller\AbstractActionController
{
    public function partialAction()
    {
        $name = $this->getEvent()->getRouteMatch()->getParam('name');
        $viewModel = new ViewModel(array(
            'name' => $name
        ));
        $viewModel->setTerminal(true);
        return $viewModel;
    }
}