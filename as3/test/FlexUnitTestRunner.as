package
{

import flash.display.Sprite;

public class FlexUnitTestRunner extends Sprite
{
    import asunit.core.FlexUnitCICore;
    import asunit.core.TextCore;

    import mx.core.UIComponent;
    import mx.events.FlexEvent;

    private var core:TextCore;

    public function FlexUnitTestRunner()
    {
        core = new FlexUnitCICore();
        core.start(AllTests);
    }
}
}
