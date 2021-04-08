<?php

/**
 * @file
 * Example unit test.
 */
use \Drupal\node\Entity\Node;

/**
 * Class ExampleUnitTest
 *
 * @package unit
 */
class ExampleUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    /**
     * Test that module is disabled.
     */
    public function testModulesDisabled()
    {
        $modules = array();
        $modules[] = 'devel';

        foreach ($modules as $module_name) {
            $this->assertEquals(false, Drupal::moduleHandler()->moduleExists($module_name));
        }
    }

    /**
     * Test that article get extra text to title.
     */
    public function testArticleTitle()
    {
        $data = array(
            'type' => 'article',
            'title' => 'My new title',
            'uid' => 1,
            'enforceIsNew' => TRUE
        );
        $node = Drupal::entityManager()
            ->getStorage('node')
            ->create($data);

        $node->save();
        $title = $node->getTitle();
        $this->assertEquals($title, 'My new title Test');
    }
}
