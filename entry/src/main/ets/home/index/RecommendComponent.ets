import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh';
import { DateUtil } from '../../common/constants/DateUtil';
import Api from '../../common/net/Api';
import { CircleInfo } from '../../common/net/model/CircleInfo';
import { CircleTrendData } from '../../common/net/model/CircleTrendData';
import Logger from '../../common/utils/Logger';
import { TypeDQDT, TypeDQRecommend } from '../../data/RecommendDataType';
import { LoadState, PageLoading } from '../../widget/PageLoading';
import hilog from '@ohos.hilog';



@Component
export struct RecommendComponent {
  private TAG = "RecommendComponent"

  private refreshConfig = new PullToRefreshConfigurator();
  private scroller: Scroller = new Scroller();
  @State loadState: LoadState = LoadState.LOADING;
  @State data: Array<Object> = [];
  @State circleInfoList: Array<CircleInfo> = []
  private hasMore: boolean = true;
  @State showLoading: boolean = false;
  private lastTimestamp: number = 0;
  aboutToAppear() {
    // 设置属性
    this.refreshConfig
      .setHasRefresh(false) // 是否具有下拉刷新功能
      .setHasLoadMore(true) // 是否具有上拉加载功能
    this.loadData();
  }

  private loadData() {
    this.loadState = LoadState.LOADING
    this.loadDataByPage(0).then(
      (data) => {
        this.data = data;
        if (this.data.length === 0) {
          this.loadState = LoadState.EMPTY;
        } else {
          this.loadState = LoadState.SUCCESS;

        }
      },
      (error) => {
        this.loadState = LoadState.FAIL;
      })
  }

  /**
   *
   * @param lastTimestamp 非0 上拉加载
   * @returns
   */
  async loadDataByPage(lastTimestamp: number): Promise<Array<Object>> {
    return new Promise<Array<Object>>(async (resolve, reject) => {

      if (lastTimestamp === 0) {
        let recRsp = await Api.get().getRecommendCircle(3);
        if (recRsp.isSuccess()) {
          this.circleInfoList = recRsp.data;
          this.data[0] = new TypeDQRecommend(recRsp.data)
        }

        let circleRsp = await Api.get().getCircleTrends(lastTimestamp, 10);
        if (circleRsp.isSuccess()) {
          this.data[1] = new TypeDQDT(circleRsp.data)
        }
        resolve(this.data);

      } else {
        let circleRsp = await Api.get().getCircleTrends(lastTimestamp, 10);

        if (circleRsp.isSuccess() && this.data[1] instanceof TypeDQDT) {
          let list = this.data[1] as TypeDQDT
          list.dataList.concat(circleRsp.data)
        }
        resolve(this.data);
      }

    })
  }

  build() {
    Column() {
      PageLoading({
        loadState: $loadState,
        showLoading: $showLoading,
        onReload: () => {
          this.loadData();
        }
      }) {
        Column(){
          PullToRefresh({
            data: $data,
            scroller: this.scroller,
            refreshConfigurator: this.refreshConfig,
            customList: this.ListViewBuilder,
            onLoadMore: () => {
              return new Promise<string>((resolve, reject) => {
                if (this.hasMore) {
                  this.loadDataByPage(this.lastTimestamp).then((data) => {
                      if (data.length > 0) {

                       // this.data = this.data.concat(data);
                        let typeDQDT: TypeDQDT = this.data[this.data.length-1] as TypeDQDT;
                        let marketNew: CircleTrendData = typeDQDT.dataList[this.data.length-1];
                        this.lastTimestamp = DateUtil.dateToStamp(marketNew.publishTime);
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
            },
            customLoad: null,
            customRefresh: null,
          })
        }
      }
    }

  }

  @Builder
  ListViewBuilder() {
    List({ space: 0, scroller: this.scroller }) {
      ForEach(this.data, (item: object, index) => {
        ListItem() {
          if (item instanceof TypeDQRecommend) {
            DQRecommend({ dataList:item.dataList})
          }


        }
        // .backgroundColor(CommonUtil.getTestColor(index))
      })
    }
    .width('100%')
    .height('100%')
    .listDirection(Axis.Vertical)
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }

}

/**
 * 鼎圈推荐
 */
@Component
struct DQRecommend {
   data:TypeDQRecommend
  private marginLeft: number = 8
  @State dataList: Array<CircleInfo> = [];
/*  @State dataList: Array<CircleInfo> = [
    new CircleInfo(15,0,'趋势为王',false),
    new CircleInfo(156,0,'短线追踪',true),
    new CircleInfo(88,1,'融资融券',false),
    new CircleInfo(10086,1,'价值成长',true),
  ];*/
  build(){
    Column() {
      Row() {
        Text('鼎圈推荐').fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(()=>{
          Logger.info('RecommendComponent','点击')
          hilog.info(0x0000, 'RecommendComponent', '点击了');
        })

        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })

      Scroll() {
        Row() {
          ForEach(this.dataList, (item: CircleInfo, index) => {
            DQItem({ marginLeft: index > 0 ? this.marginLeft : 0
            , info: item
            , clickFollow: (info: CircleInfo) => {
                info.followFlag = !info.followFlag;
                //替换原对象 @State会触发刷新
                this.dataList = this.dataList.map(item => item);
              }
            })
              .onAppear(() => {
                console.info("appear:" + item)
              })
          }, (item: CircleInfo, index?: number) => index + JSON.stringify(item))

        }
      }.scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

    }.width('100%')
  }
}

@Component
struct DQItem {
  marginLeft: number
  info: CircleInfo
  clickFollow: (CircleInfo) => void;

  build() {

    Column() {
      Stack() {
        Image(this.info.circleAvatar).width('30vp').height('30vp').borderRadius(25)
        Image($r('app.media.top_circle_article_avatar_living_icon'))
          .width('16vp').height('16vp')
          .margin({ right: -5, top: -5 })
          .visibility(this.info.liveStatus === 1 ? Visibility.Visible : Visibility.Hidden)
      }.alignContent(Alignment.TopEnd)

      Text(this.info.circleName).fontSize(13)
        .fontColor($r('app.color.up_common_text_title_color'))
        .margin({ top: 4 })
      Text(`粉丝数 ${this.info.followCount}`)
        .fontSize(11).fontColor('#8B8B8B').margin({ top: 3 })
      Text(this.info.followFlag ? '已关注' : '关注')
        .fontSize(11)
        .margin({ top: 3 })
        .borderRadius(15)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .fontColor(this.info.followFlag ? '#838383' : '#F54949')
        .backgroundColor(this.info.followFlag ? '#f0f0f0' : '#fff4f4')
        .onClick(() => {
          this.clickFollow(this.info)
        })

    }
    .width('33%')
    .borderRadius(8)
    .backgroundColor('#f9f9f9')
    .margin({ left: this.marginLeft })
    .padding(10)
  }
}
