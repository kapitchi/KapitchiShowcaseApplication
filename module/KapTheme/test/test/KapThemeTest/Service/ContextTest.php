<?php

/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

namespace KapThemeTest\Service;

/**
 *
 * @author Matus Zeman <mz@kapitchi.com>
 */
class ContextTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var \KapitchiEntity\Service\EntityService
     */
    protected $service;
    
    public function setUp()
    {
        $mapper = $this->getMock('KapitchiEntity\Mapper\EntityMapperInterface');
        $hydrator = new \Zend\Stdlib\Hydrator\ClassMethods(false);
        $this->service = new \KapitchiEntity\Service\EntityService(
                $mapper,
                $this->createEntity(),
                $hydrator
            );
        $eventManager = $this->getMockForAbstractClass('Zend\EventManager\EventManager');
        $this->service->setEventManager($eventManager);
    }
    
    protected function createEntity(array $data = array())
    {
        $entity = $this->getMockForAbstractClass('KapitchiEntityStub\Entity');
        if(!empty($data)) {
            $hydrator = new \Zend\Stdlib\Hydrator\ClassMethods(false);
            $hydrator->hydrate($data, $entity);
        }
        return $entity;
    }
    
    public function testPersistEvent()
    {
        $entity = $this->createEntity();
        $event = $this->service->persist($entity);
        $this->assertInstanceOf('KapitchiEntity\Service\Event\PersistEvent', $event);
    }
    
    public function testPersistCreateEntity()
    {
        $entity = $this->createEntity();
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('persist')
                ->with($this->equalTo($entity));
        
        $event = $this->service->persist($entity);
        $this->assertSame($entity, $event->getEntity());
    }
    
    public function testPersistUpdateEntity()
    {
        $entity = $this->createEntity(array(
            'id' => 1,
            'name' => 'Kapitchi',
        ));
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('persist')
                ->with($this->equalTo($entity));
        //@deprecated
//        $mapper->expects($this->once())
//                ->method('find')
//                ->with($this->equalTo(1))
//                ->will($this->returnValue($entity));
        
        $event = $this->service->persist($entity);
        $this->assertSame($entity, $event->getEntity());
        //@deprecated
        //$this->assertEquals($entity, $event->getParam('origEntity'));
    }
    
    public function testPersistCreateArray()
    {
        $data = array(
            'name' => 'Kapitchi'
        );
        
        $event = $this->service->persist($data);
        $this->assertInstanceOf('KapitchiEntityStub\Entity', $event->getEntity());
        $this->assertSame($data, $event->getParam('data'));
    }
    
    public function testPersistWithData()
    {
        $entity = $this->createEntity();
        $data = array(
            'name' => 'Kapitchi'
        );
        $event = $this->service->persist($entity, $data);
        $this->assertInstanceOf('KapitchiEntityStub\Entity', $event->getEntity());
        $this->assertSame($data, $event->getParam('data'));
    }

    /**
     * @expectedException KapitchiEntity\Exception\NotEntityException
     */
    public function testPersistInvalidArgument()
    {
        $this->service->persist(new \stdClass());
        $this->service->persist('');
        $this->service->persist(123);
        $this->service->persist(null);
    }
    
    public function testFindEntityFound()
    {
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(1))
                ->will($this->returnValue($this->createEntity()));
        
        $entity = $this->service->find(1);
        $this->assertInstanceOf('KapitchiEntityStub\Entity', $entity);
    }
    
    public function testFindEntityNotFound()
    {
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(999))
                ->will($this->returnValue(null));
        
        $entity = $this->service->find(999);
        $this->assertNull($entity);
    }
    
    public function testGetEntityFound()
    {
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(1))
                ->will($this->returnValue($this->createEntity()));
        
        $entity = $this->service->get(1);
        $this->assertInstanceOf('KapitchiEntityStub\Entity', $entity);
    }
    
    /**
     * @expectedException KapitchiEntity\Exception\EntityNotFoundException
     */
    public function testGetEntityNotFound()
    {
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(999))
                ->will($this->returnValue(null));
        
        $entity = $this->service->get(999);
    }
    
    public function testIsEntityInstanceTrue()
    {
        $this->assertTrue($this->service->isEntityInstance($this->createEntity()));
    }
    
    public function testIsEntityInstanceFalse()
    {
        $this->assertFalse($this->service->isEntityInstance(''));
        $this->assertFalse($this->service->isEntityInstance(array()));
        $this->assertFalse($this->service->isEntityInstance(123));
    }
    
    public function testPartialUpdateById()
    {
        $entity = $this->createEntity(array(
            'id' => 1,
            'name' => 'Kapitchi',
        ));
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(1))
                ->will($this->returnValue($entity));
        
        $mapper->expects($this->once())
                ->method('persist')
                ->with($this->equalTo($entity));
        
        $event = $this->service->partialUpdate(1, array(
            'name' => 'new'
        ));
        
        $newEntity = $event->getEntity();
        $this->assertEquals('new', $newEntity->getName());
    }
    
    /**
     * @expectedException InvalidArgumentException
     */
    public function testPartialUpdateNothingToUpdateException()
    {
        $entity = $this->createEntity(array(
            'id' => 1,
            'name' => 'Kapitchi',
        ));
        
        $this->service->partialUpdate($entity, array(
            'xxx' => 'Kapitchi'
        ));
    }
    
    /**
     * @expectedException KapitchiEntity\Exception\EntityNotFoundException
     */
    public function testPartialUpdateByIdNotFoundException()
    {
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('find')
                ->with($this->equalTo(999))
                ->will($this->returnValue(null));
        
        $this->service->partialUpdate(999, array(
            'name' => 'new'
        ));
    }
    
    public function testCreatePersistEvent()
    {
        $event = $this->service->createPersistEvent(array(
            'param' => 'test'
        ));
        $this->assertInstanceOf('KapitchiEntity\Service\Event\PersistEvent', $event);
        $this->assertEquals('test', $event->getParam('param'));
    }
    
    public function testCreateRemoveEvent()
    {
        $event = $this->service->createRemoveEvent(array(
            'param' => 'test'
        ));
        $this->assertInstanceOf('KapitchiEntity\Service\Event\RemoveEvent', $event);
        $this->assertEquals('test', $event->getParam('param'));
    }
    
    public function testGetPaginatorAdapter()
    {
        $filter = array('column' => 'xxx');
        $order = array('column' => 'ASC');
        
        $adapter = new \Zend\Paginator\Adapter\ArrayAdapter(array());
        $mapper = $this->service->getMapper();
        $mapper->expects($this->once())
                ->method('getPaginatorAdapter')
                ->with($this->equalTo($filter), $this->equalTo($order))
                ->will($this->returnValue($adapter));
        
        $paginator = $this->service->getPaginator($filter, $order);
        $this->assertInstanceOf('Zend\Paginator\Paginator', $paginator);
    }
    
    public function testGetPaginatorArray()
    {
        $this->markTestIncomplete('There are also other methods which need to be covered');
    }
}