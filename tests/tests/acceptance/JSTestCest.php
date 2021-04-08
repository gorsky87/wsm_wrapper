<?php

/**
 * @file
 * CSS test cest.
 */

/**
 * Class JSTestCest
 */
class JSTestCest 
{
    /**
     * JS themes test.
     *
     * @param AcceptanceTester $I
     */
    public function jsThemes(AcceptanceTester $I) 
    {
        $I->wantTo('See js themes files');
        $I->amOnPage('/profiles/contrib/droopler/themes/custom/droopler_theme/js/vendor/bootstrap.bundle.min.js');
        $I->seeResponseCodeIs(200);
        $I->amOnPage('/profiles/contrib/droopler/themes/custom/droopler_theme/js/min/global.min.js');
        $I->seeResponseCodeIs(200);
    }

    /**
     * JS subtheme test.
     *
     * @param AcceptanceTester $I
     */
    public function jsSubtheme(AcceptanceTester $I) 
    {
        $I->wantTo('See js subtheme files');
        $I->amOnPage('/themes/custom/droopler_subtheme/js/min/global.min.js');
        $I->seeResponseCodeIs(200);
    }
}


