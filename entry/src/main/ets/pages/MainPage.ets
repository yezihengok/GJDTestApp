
import { homeTabInfo, TabInfoModel } from '../data/HomeTabData';
import { HomeComponent } from '../home/HomeComponent';
import { DQComponent } from '../home/DQComponent';
import { JCComponent } from '../home/JCComponent';
import { HQComponent } from '../home/HQComponent';
import { ZXComponent } from '../home/ZXComponent';
import { Headers } from '../data/HeadersData';
import promptAction from '@ohos.promptAction';
import hilog from '@ohos.hilog';
/**
 * The MainPage that is routed as the SplashScreenPage.
 */
@Entry
@Component
struct MainPage {
  //自定义样式时 需要定义TabsController控制切换滑动
  private tabsController : TabsController = new TabsController()
  @State currentIndex:number=0

  //
  @Builder TabBuilder(info:TabInfoModel) {
    Column() {
      Image(this.currentIndex === info.index ? info.selectImg : info.img)
        .size({ width: 25, height: 25 })
      Text(info.title)
        .fontSize(15)
        .fontColor(this.currentIndex === info.index ? '#f75c5b' : '#6B6B6B')
    }.onClick(() => {
      this.currentIndex = info.index;
      this.tabsController.changeIndex(this.currentIndex);
    })
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column(){
      Tabs({barPosition:BarPosition.End,controller:this.tabsController}){
        TabContent(){
          HomeComponent()
        }.tabBar(this.TabBuilder(homeTabInfo[0]))

        TabContent(){
          DQComponent()
        }.tabBar(this.TabBuilder(homeTabInfo[1]))

        TabContent(){
          JCComponent()
        }.tabBar(this.TabBuilder(homeTabInfo[2]))

        TabContent(){
          HQComponent()
        }.tabBar(this.TabBuilder(homeTabInfo[3]))

        TabContent(){
          ZXComponent()
        }.tabBar(this.TabBuilder(homeTabInfo[4]))

      }.scrollable(false)
    }.backgroundColor(Color.White).width('100%')

  }

  aboutToAppear(){
    // let userId='gjd078000057'
    let userId='gjd745000008'
    Headers.dgUserName=userId;
    Headers.dgUid=userId;
    hilog.info(0, "TAG",`组件即将出现时回调:${JSON.stringify(Headers)}`);

  }
}