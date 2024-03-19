

import { indexTabInfo, TabModel } from '../../data/HomeTabData';
import { IndexDynamicsComponent } from './IndexDynamicsComponent';

/**
 * 首页推荐关注等tab
 */
@Component
export struct IndexMainTab {
  //自定义样式时 需要定义TabsController控制切换滑动
  private tabsController : TabsController = new TabsController()
  @State currentIndex:number=0

  // @ts-ignore
 private refreshConfig: PullToRefreshConfigurator
  @Builder TabBuilders(info:TabModel) {

    Column() {

      Text(info.title)
        .fontSize(15)
        .fontSize(this.currentIndex === info.index ?17:14)
        .fontWeight(this.currentIndex === info.index ?FontWeight.Medium:FontWeight.Normal)
        .fontColor(this.currentIndex === info.index ? '#000000' : '#6B6B6B')
      if(this.currentIndex === info.index ){
        Rect().width(25).height(5).fill('#ff2200')
        .radius([[20, 20], [20, 20]])
          .margin({top:3})
      }
    }.onClick(() => {
      this.currentIndex = info.index;
      this.tabsController.changeIndex(this.currentIndex);
      this.refreshConfig.setHasLoadMore(this.currentIndex==0||this.currentIndex==3)
      this.refreshConfig.setHasRefresh(true)
    })
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column(){
      Tabs({controller:this.tabsController}){
        TabContent(){
          Text('0').height('10%')
        }.tabBar(this.TabBuilders(indexTabInfo[0]))

        TabContent(){
          Text('1').height('10%')
        }.tabBar(this.TabBuilders(indexTabInfo[1]))

        TabContent(){
          Text('2').height('10%')
        }.tabBar(this.TabBuilders(indexTabInfo[2]))

        TabContent(){
          IndexDynamicsComponent()
        }.tabBar(this.TabBuilders(indexTabInfo[3]))


      }.scrollable(false).height('100%')
    }.backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_twelve'))
    .width('100%')

  }

}
