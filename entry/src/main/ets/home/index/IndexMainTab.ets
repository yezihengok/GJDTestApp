import { PullToRefreshConfigurator } from '@ohos/pulltorefresh';
import { indexTabInfo, TabModel } from '../../data/HomeTabData';
import { HomeDynamicsComponent } from './HomeDynamicsComponent';
import { HomeStrategyComponent } from './HomeStrategyComponent';
import { RecommendComponent } from './RecommendComponent';

/**
 * 首页推荐关注等tab
 */
@Component
export struct IndexMainTab {
  private parentScroller?: Scroller

  //自定义样式时 需要定义TabsController控制切换滑动
  private tabsController : TabsController = new TabsController()
  @State currentIndex:number=0


 private refreshConfig: PullToRefreshConfigurator|null=null
  @Builder TabBuilders(info:TabModel) {

    Column() {

      Text(info.title)
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
      // this.refreshConfig.setHasLoadMore(this.currentIndex==0||this.currentIndex==3)
      this.refreshConfig?.setHasRefresh(true)
    })
    .width('100%')
    // .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column(){
      Tabs({controller:this.tabsController}){
        TabContent(){
          RecommendComponent()
        }.tabBar(this.TabBuilders(indexTabInfo[0]))

        TabContent(){
          Text('1').height('10%')
        }.tabBar(this.TabBuilders(indexTabInfo[1]))

        TabContent(){
          // Text('2').height('10%')
          HomeStrategyComponent({parentScroller:this.parentScroller})
        }.tabBar(this.TabBuilders(indexTabInfo[2]))

        TabContent(){
          HomeDynamicsComponent({parentScroller:this.parentScroller})
        }.tabBar(this.TabBuilders(indexTabInfo[3]))


      }.scrollable(false).height('100%')
       // .constraintSize({minHeight:'90%',maxHeight:Infinity})
    }.backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_twelve'))
    .width('100%')
    .padding({ left: 15, right: 15 })
  }

}
