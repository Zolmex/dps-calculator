package {
import fl.rsl.RSLInfo;
import fl.rsl.RSLPreloader;
import fl.rsl.SWZInfo;

import flash.display.MovieClip;

[SWF(frameRate="60", backgroundColor="#333333", width="800", height="600")]
public class DPSCalculator__Preloader__ extends MovieClip {
    public var __rslPreloader:RSLPreloader;

    public function DPSCalculator__Preloader__() {
        super();
        this.frame1();
    }

    public function frame1():void {
        var _loc1_:RSLInfo = null;
        stop();
        this.__rslPreloader = new RSLPreloader(this);
        _loc1_ = new SWZInfo("8f903698240fe799f61eeda8595181137b996156bb176da70ad6f41645c64c74");
        _loc1_.addEntry("http://fpdownload.adobe.com/pub/swz/tlf/2.0.0.232/textLayout_2.0.0.232.swz", "http://fpdownload.adobe.com/pub/swz/crossdomain.xml");
        _loc1_.addEntry("textLayout_2.0.0.232.swz", "");
        this.__rslPreloader.addRSLInfo(_loc1_);
        this.__rslPreloader.start(DPSCalculator__LoadingAnimation__, DPSCalculator__Content__);
    }

    public function frame2():void {
        stop();
        this.__rslPreloader.loadContent();
    }
}
}

