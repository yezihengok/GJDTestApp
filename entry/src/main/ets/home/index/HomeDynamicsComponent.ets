import Api from '../../common/net/Api';
import { MarketNew } from '../../common/net/model/MarketNew'
import { LoadState, PageLoading } from '../../widget/PageLoading';
import hilog from '@ohos.hilog';
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh';
import { MarketNewType } from '../../common/constants/CommEnum';
import { DateUtil } from '../../common/constants/DateUtil';
import Logger from '../../common/utils/Logger';
import { toast } from '../../common/utils/Toast';
import { CommonUtil } from '../../common/utils/CommonUtil';
import { TypeDynamics1, TypeDynamics2 } from '../../data/HomeDataType';
import { RefreshFooter } from '../../view/RefreshFooter';
import { NoMoreFooter } from '../../view/NoMoreFooter';

/**
 * 动态
 */
@Component
export struct HomeDynamicsComponent {
  private TAG = "HomeDynamicsComponent"
  private scrollerForList: Scroller = new Scroller();
  private refreshConfig = new PullToRefreshConfigurator();
  private parentScroller: Scroller
  @State data: Array<Object> = []
  private lastTimestamp: number = 0;
  @State hasMore: boolean = true;
  @State loadState: LoadState = LoadState.LOADING;
  @State showLoading: boolean = false;
  /**0代表滚动到List顶部，1代表中间值，2代表滚动到List底部**/
  @State listPosition: number = 0;
  @State showLoadMore: boolean = false
  @Consume homeReachEnd:boolean
  @Consume homeReachStart:boolean
  // @Consume reviewVotes: number;
  @State scrollDown: boolean = false
  aboutToAppear() {
    // 设置属性
    this.refreshConfig
      .setHasRefresh(false) // 是否具有下拉刷新功能
      .setHasLoadMore(true) // 是否具有上拉加载功能
    this.loadData();

  }

  private loadData() {
    this.loadState = LoadState.LOADING
    this.loadDataByPage(0).then((data) => {

      // this.data = data;
      if (data.length === 0) {
        this.loadState = LoadState.EMPTY;
        this.data = null
      } else {
        this.loadState = LoadState.SUCCESS;
        data.forEach(element => {
          if (element.type === 1) {
            this.data.push(new TypeDynamics1(element))
          } else {
            this.data.push(new TypeDynamics2(element))
          }
        });
      }
    },
      (error) => {
        this.loadState = LoadState.FAIL;
      })
  }

  private async loadDataByPage(lastTimestamp: number): Promise<Array<MarketNew>> {
    let res = await Api.get().marketNews(lastTimestamp, 10);
    return new Promise<Array<MarketNew>>((resolve, reject) => {
      if (res.isSuccess()) {
        let list = res.data;
        resolve(list);
      } else {
        reject();
      }
    })
  }

  async loadMore() {
    return new Promise<string>((resolve, reject) => {
      if (this.hasMore) {
        this.loadDataByPage(this.lastTimestamp).then(
          (data) => {
            if (data.length > 0) {

              //this.data = this.data.concat(data);
              data.forEach(element => {
                if (element.type === 1) {
                  this.data.push(new TypeDynamics1(element))
                } else {
                  this.data.push(new TypeDynamics2(element))
                }
              });

              let item = this.data[this.data.length-1];
              if (item instanceof TypeDynamics1) {
                this.lastTimestamp = DateUtil.dateToStamp(item.marketNew.publishTime);
              } else if (item instanceof TypeDynamics2) {
                this.lastTimestamp = DateUtil.dateToStamp(item.marketNew.publishTime);
              }

              resolve('加载成功');
            } else {
              this.hasMore = false;
              resolve('没有更多了');
            }
          },
          (error) => {
            resolve('加载失败');
          }
        )
      } else {
        resolve('没有更多了');
      }
    });
  }

  build() {
    Column() {
      PageLoading({
        loadState: $loadState,
        showLoading: $showLoading,
        onReload: () => {
          hilog.debug(0, this.TAG, "onReload");
          this.loadData();
        }
      }) {

        Column() {
          this.ListViewBuilder()
          //第三方 PullToRefresh控件 与内部嵌套滑动后有冲突， 目前 api 9 官方暂无向android那样的标准嵌套滑动控件
          // PullToRefresh({
          //   data: $data,
          //   scroller: this.scrollerForList,
          //   refreshConfigurator: this.refreshConfig,
          //   customList: this.ListViewBuilder,
          //   onLoadMore: this.loadMore,
          //   customLoad: null,
          //   customRefresh: null,
          // })
        }
        .padding({ bottom: 50 })
        .width('100%')
        .height('100%')
      }
    }
  }

  @Builder
  ListViewBuilder() {
    List({ scroller: this.scrollerForList }) {
      // ListItem(){
      //   Button(`reviewVotes(${this.reviewVotes}), give +1`)
      //     .onClick(() => this.reviewVotes += 1)
      // }
      ForEach(this.data, (item: MarketNew) => {
        ListItem() {
          // if(this.dataBean!=null &&this.dataBean==undefined) {
          //   if (item.type===1) {
          if (item instanceof TypeDynamics1) {
            MarketNewItemBuilder1({ dataBean: item, onItemClick: (marketNew: MarketNew) => {
              toast(`marketNew.type:${marketNew.type}`)
            } })
          } else if (item instanceof TypeDynamics2) {
            MarketNewItemBuilder2({ dataBean: item, onItemClick: (marketNew: MarketNew) => {
              toast(`marketNew.type:${marketNew.type}`)
            } })
          }
          //}
        }
      })
      ListItem() {
        RefreshFooter({ showFooter: this.showLoadMore })
      }
      ListItem() {
        NoMoreFooter({ show: !this.hasMore })
      }
    }
    .width('100%')
    .height('100%')
    .listDirection(Axis.Vertical)
    .divider({
      strokeWidth: 1,
      color: $r("app.color.divider"),
      startMargin: 1,
      endMargin: 1
    })
     .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
    .onReachStart(() => {
      this.listPosition = 0
    })
    .onReachEnd(() => {
      this.listPosition = 2
      if(this.hasMore){
        this.showLoadMore = true
        //上拉加载消失的太快延迟0.5s再去请求接口
        setTimeout(() => {
          // this.scrollerForList.scrollEdge(Edge.Bottom)
          this.scrollerForList.scrollBy(0, $r('app.float.size_50'))
          this.loadMore().then(() => {
            this.showLoadMore = false
          })
        }, 200)
      }
    })
    .onScrollFrameBegin((offset: number) => {//offset>0  往上滚动
      this.scrollDown=offset<0;
      // if ((this.listPosition == 0 && offset <= 0) || (this.listPosition == 2 && offset >= 0)) {

      Logger.info(`homeReachEnd>>>${this.homeReachEnd} offset>>>${offset} listPosition===${this.listPosition}}`)
      //父没有滚动到最底部情况下如果子滚动到list顶部了还往上滚动 或 父滚动到顶部了子往上滚动。 则交给父去滑动
      if ( this.listPosition!=2&&offset>0 && !this.homeReachEnd || this.listPosition===0&&offset<0) {
        if (this.parentScroller !== undefined) {
          this.parentScroller.scrollBy(0, offset)

        } else {
          toast('onScrollFrameBegin:' + this.parentScroller)
        }
        return { offsetRemain: 0 }
      }
      this.listPosition = 1
      return { offsetRemain: offset };
    })

  }
}


@Builder function TagTimeLayout(strTag: string, strTime: string) {
  Row() {
    Text(strTag).width(56).fontSize(13).fontColor($r('app.color.up_common_brand_color'))
    Line().width(1).height(10).backgroundColor('#a6a6a6').margin({ left: 5 })
    Text(strTime).fontSize(13).fontColor('#9BA5B8').margin({ left: 5 })
  }.margin({ top: 10 }).width('100%')
}

/**
 * 动态item样式1
 */
@Component
struct MarketNewItemBuilder1 {
  dataBean: TypeDynamics1;
  onItemClick: (MarketNew) => void;

  build() {
    Column() {
      Text(this.dataBean.marketNew.summary).maxLines(3).fontSize(14)
        .fontColor($r('app.color.up_common_text_primary_color'))
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.NoWrap }) {
        if (MarketNew.getPicList(this.dataBean.marketNew).length > 0) {
          ForEach(MarketNew.getPicList(this.dataBean.marketNew), (item: string, index) => {
            //多个将会平分显示
            if (index > 0) {
              Image(item)
                .width('40%')
                .height(80)
                .borderRadius(5)
                .objectFit(ImageFit.Cover)
                .margin({ top: 5, left: 5 })
            } else {
              Image(item)
                .width('40%')
                .height(80)
                .borderRadius(5)
                .objectFit(ImageFit.Cover)
                .margin({ top: 5 })
            }
          }, item => JSON.stringify(item))
        }
      }

      TagTimeLayout(this.dataBean.marketNew.secondCategoryName, this.dataBean.marketNew.publishTime)
    }.height(MarketNew.getPicList(this.dataBean.marketNew).length > 0 ? 180 : 110)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.onItemClick(this.dataBean.marketNew);
    })

  }
}

/**
 * 动态item样式2
 */
@Component
struct MarketNewItemBuilder2 {
  dataBean: TypeDynamics2;
  onItemClick: (MarketNew) => void;

  build() {
    Row() {
      Column() {
        Text(this.dataBean.marketNew.title)
          .width('100%')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.dataBean.marketNew.summary)
          .fontSize(13)
          .width('100%')
          .fontColor('#657180')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 5 })
        TagTimeLayout(this.dataBean.marketNew.secondCategoryName, this.dataBean.marketNew.publishTime)
      }
      .layoutWeight(1)

      Image(this.dataBean.marketNew.coverImage)
        .width(100)
        .height(70)
        .margin({ top: 15, bottom: 15, left: 5 })
        .objectFit(ImageFit.Cover)
        .id('coverImg')
        .borderRadius(5)
        .visibility(CommonUtil.isEmpty(this.dataBean.marketNew.coverImage) ? Visibility.None : Visibility.Visible)

    }.padding({ top: 10, bottom: 10 })
    .width('100%').height(110).onClick(() => {
      this.onItemClick(this.dataBean.marketNew);
    })
  }
}
