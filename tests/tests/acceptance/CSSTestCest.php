<?php

/**
 * @file
 * CSS test cest.
 */

/**
 * Class CSSTestCest
 */
class CSSTestCest 
{
    /**
     * CSS themes test.
     *
     * @param AcceptanceTester $I
     */
    public function cssThemes(AcceptanceTester $I) 
    {
        $I->wantTo('See css themes files');
        $I->amOnPage('/profiles/contrib/droopler/themes/custom/droopler_theme/css/style.css');
        $I->seeResponseCodeIs(200);
    }

    /**
     * CSS subtheme test.
     *
     * @param SmokeTester $I
     */
    public function cssSubtheme(AcceptanceTester $I) 
    {
        $I->wantTo('See css subtheme files');
        $I->amOnPage('/themes/custom/droopler_subtheme/css/style.css');
        $I->seeResponseCodeIs(200);
    }
}


