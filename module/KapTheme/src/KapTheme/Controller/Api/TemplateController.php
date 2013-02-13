<?php

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