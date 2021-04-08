<?php

/**
 * @file
 * Example js_capable test.
 */

/**
 * Class JSCentreTestsCest
 *
 * @package js_capable
 */
class JSCentreTestsCest
{

    /**
     * Setup environment before each test.
     *
     * @param \JSCapableTester $I
     */
    public function _before(JSCapableTester $I)
    {
        $I->amOnPage('/user');
        $I->fillField('#edit-name', 'admin_user');
        $I->fillField('#edit-pass', '123');
        $I->click('#edit-submit');
    }

    /**
     * Setup environment after each test.
     *
     * @param \JSCapableTester $I
     */
    public function _after(JSCapableTester $I)
    {
        $I->amOnPage('/user/logout');
    }

    /**
     * Test - I add article.
     *
     * @param \JSCapableTester $I
     */
    public function addArticle(JSCapableTester $I)
    {
        $I->wantTo('Test - I add article');
        $I->amOnPage('/node/add/article');
        $I->fillField('#edit-title-0-value', 'Test article');
        $I->selectOption('select[id^=edit-body-0-format]', 'restricted_html');
        $I->fillField('#edit-body-0-value', 'Test text in body article');
        $I->click('#edit-submit');
        $I->see('Article Test article Test has been created.');
        $I->see('Test text in body article');

    }

    /**
     * Test - I add page.
     *
     * @param \JSCapableTester $I
     */
    public function addPage(JSCapableTester $I)
    {
        $I->wantTo('Test - I add page');
        $I->amOnPage('/node/add/page');
        $I->fillField('#edit-title-0-value', 'Test basic page');
        $I->selectOption('select[id^=edit-body-0-format]', 'restricted_html');
        $I->fillField('#edit-body-0-value', 'Test text in body page');
        $I->click('#edit-submit');
        $I->see('Basic page Test basic page has been created.');
        $I->see('Test text in body page');
    }

}
