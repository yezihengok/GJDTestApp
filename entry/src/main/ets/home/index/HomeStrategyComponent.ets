import Api from '../../common/net/Api';
import HashMap from '@ohos.util.HashMap';
import { LoadState, PageLoading } from '../../widget/PageLoading';
import hilog from '@ohos.hilog';
import { CommonUtil } from '../../common/utils/CommonUtil';
import { BXPools, CDXH, LTQB, NSPools, PEGPools, QSLT, ZYDGPools } from '../../data/HomeStrategyToolData';
import { UPServiceConfig } from '../../common/constants/UPServiceConfig';
import { BaseItemType } from '../../data/BaseItemType';
import { toast } from '../../common/utils/Toast';
import { BXJJData, StrategyPool, StrategyTools } from '../../common/net/model/StrategyTools';
import Logger from '../../common/utils/Logger';
import { EmptyView, UPEmptyType } from '../../widget/EmptyView';
import { RouterUtil } from '../../common/utils/RouterUtil';
import { H5Address } from '../../common/constants/H5Address';

/**
 * 策略
 */
@Component
export struct HomeStrategyComponent {
  @State loadState: LoadState = LoadState.LOADING;
  @State showLoading: boolean = false;
  hashMap = new HashMap();
  private TAG = "IndexDynamicsComponent"
  @State data: Array<BaseItemType> = []
  @State strategy: StrategyTools = null;
  private scrollerForList: Scroller = new Scroller()
  private parentScroller: Scroller = new Scroller()
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部
  @Consume homeReachEnd:boolean
  aboutToAppear() {
    this.loadData(true)

  }

  async loadData(firstTime: boolean) {
    if (firstTime) this.loadState = LoadState.LOADING

    //获取功能区(有返回则有权限)
    let fucRsp = await Api.get().getFunctionData('gjd_sy_cl_pc');
    let strategyRsp = await Api.get().getStrategyTools();
    this.strategy = strategyRsp.data;
    // this.loadState = LoadState.FAIL;

    if (fucRsp.isSuccess() && strategyRsp.isSuccess() && fucRsp.data.length > 0) {
      fucRsp.data[0].secondNavbars.forEach(element => {
        this.hashMap.set(element.code, element.categoryName)
      });

      this.hashMap.forEach((value, key) => {
        Logger.error(`key=${key} value=${value}`)
      })


      this.data[0] = new NSPools(this.hashMap.hasKey(UPServiceConfig.SY_CL_NSXJGC), this.strategy.nsPools)
      this.data[1] = new BXPools(this.hashMap.hasKey(UPServiceConfig.SY_CL_BXFC), this.strategy.bxPools)
      //依赖UP TAF接口 暂时无法拿到 ,
      this.data[2] = new CDXH(this.hashMap.hasKey(UPServiceConfig.SY_CL_CDXH), null)
      this.data[3] = new LTQB(this.hashMap.hasKey(UPServiceConfig.SY_CL_LTQB), null)
      this.data[4] = new QSLT(this.hashMap.hasKey(UPServiceConfig.SY_CL_QSZS), null)

      this.data[5] = new ZYDGPools(this.hashMap.hasKey(UPServiceConfig.SY_CL_ZYDGCL), this.strategy.zydgPools)
      this.data[6] = new PEGPools(this.hashMap.hasKey(UPServiceConfig.SY_CL_PEGCL), this.strategy.pegPools)

      //为了看到页面UI效果暂时屏蔽，目前接口配置的几乎都没权限了，
      //过滤掉没有权限的项
      // this.data = this.data.filter(item => {
      //   return item.hasPermission == true
      // })

      if (firstTime) this.loadState = LoadState.SUCCESS;
    } else {
      if (firstTime) this.loadState = LoadState.EMPTY;
    }

  }

  build() {

    PageLoading({
      loadState: $loadState,
      showLoading: $showLoading,
      onReload: () => {
        hilog.debug(0, this.TAG, "onReload");
        this.loadData(true);
      }
    }) {
      Column() {
        List({ space: 0 ,scroller:this.scrollerForList}) {
          ForEach(this.data, (item: BaseItemType) => {
            ListItem() {
              if (item instanceof NSPools) {
                NSItem({ bean: item, onCallBack: () => {
                  Logger.error(JSON.stringify(this.hashMap))
                  this.loadData(false);
                } })
              } else if (item instanceof BXPools) {
                BXItem({ bean: item })
              } else if (item instanceof CDXH) {
                CDXHItem({ bean: item, onCallBack: () => this.loadData(false) })
              } else if (item instanceof LTQB) {
                LTQBItem({ bean: item })
              } else if (item instanceof QSLT) {
                QSLTItem({ bean: item })
              } else if (item instanceof ZYDGPools) {
                YZDGItem({ bean: item })
              } else if (item instanceof PEGPools) {
                PEGItem({ bean: item })
              }
            }
          })
        }.width('100%').height('100%')
        .padding({bottom:50})
        .edgeEffect(EdgeEffect.None)
        .onReachStart(() => {
          this.listPosition = 0
          //toast('滚动到Start了')
        })
        .onReachEnd(() => {
          this.listPosition = 2
           //toast('滚动到End了')
        })
        //onScrollFrameBegin实现嵌套滑动，
        .onScrollFrameBegin((offset: number) => {
          //如果滚动到list顶部了还往下滚动或 滚动到list底部了还往下滚动，则让父Scroll去滚动
          // if ((this.listPosition == 0 && offset <= 0) || (this.listPosition == 2 && offset >= 0)) {
            if ( this.listPosition!=2&&offset>0 && !this.homeReachEnd || this.listPosition===0&&offset<0) {
            if(this.parentScroller!== undefined){
              this.parentScroller.scrollBy(0, offset)
            }
            return { offsetRemain: 0 }
          }
          this.listPosition = 1
          return { offsetRemain: offset };
        })
      }.width('100%').height('100%')

    }
  }
}

@Component
struct NSItem {
  @State bean: NSPools = null
  @State emptyType: UPEmptyType = UPEmptyType.UPEmptyTypeData
  onCallBack?: () => void;

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => RouterUtil.toWeb(H5Address.HOME_NSDR_URL))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })

      Row() {
        Text('名称/代码').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('40%');
        Text('牛散').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
        Text('持股金额').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
        Text('季度收益率').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
      }

      if (CommonUtil.isListNotNull(this.bean.data)) {
        Text('列表数据不为空,UI待完成').fontSize(16)
      } else {
        EmptyView({
          emptyType: $emptyType,
          onMyClick: () => {
            Logger.error('点击了')
            this.emptyType = UPEmptyType.UPEmptyType404
            if (this.onCallBack !== undefined) {
              this.onCallBack();
            }
          }
        }).height(200)
      }

    }
  }
}


@Component
struct BXItem {
  bean: BXPools

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => RouterUtil.toWeb(H5Address.HOME_BXJJ_MORE_URL))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })

      Grid() {
        GridItem() {
          this.bXCardItem({
            title: `增仓精选池${CommonUtil.getDefaultNumber(this.bean.data.increasePosition)}只`,
            date: this.bean.data.updatedAd,
            content: '北向资金又有哪些持了'
          })
        }

        GridItem() {
          this.bXCardItem({
            title: `抄底精选池${CommonUtil.getDefaultNumber(this.bean.data.copyBottom)}只`,
            date: this.bean.data.updatedAd,
            content: '哪个股票被北向抄了底？'
          })
        }

        GridItem() {
          this.bXCardItem({
            title: `共振精选池${CommonUtil.getDefaultNumber(this.bean.data.resonance)}只`,
            date: this.bean.data.updatedAd,
            content: '主力持仓在买的股票'
          })
        }

        GridItem() {
          this.bXCardItem({
            title: `建仓精选池${CommonUtil.getDefaultNumber(this.bean.data.openPosition)}只`,
            date: this.bean.data.updatedAd,
            content: '北向资金最近买了啥？'
          })
        }
      }
      .rowsTemplate('1fr 1fr')
      .columnsTemplate('1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
      .height(195)
    }
  }

  @Styles
  cardStyle(){
    // .margin(4)
    .height(85)
    .padding({ left: 8, right: 8 })
    .width('100%')
    .backgroundColor(Color.White)
    // .backgroundImage('images/home_recommend_item_today_live_bg.9.png')
    .borderRadius(8)
    // .border({color:Color.Blue,width:2})
    .shadow({ radius: $r('app.float.vp_four'), color: '#dcdcdc', offsetX: 1, offsetY: 1 })
  }

  @Builder bXCardItem($$: {
    title: string,
    date: string,
    content: string
  }) {
    //外面套一层设置padding 为了让shadow显示完整
    Stack() {
      Column() {
        Text($$.title).fontSize(15).fontColor('#C48B00').margin({ top: 5 })
        Text('更新时间').fontSize(13).fontColor('#657180').margin({ top: 2 })
        Text($$.date).fontSize(15).fontColor(Color.Black).margin({ top: 2 })
        Text($$.content).fontSize(13).fontColor('#9BA5B8').margin({ bottom: 5 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .cardStyle()
    }.padding(3)

  }
}


@Component
struct CDXHItem {
  bean: CDXH
  @State emptyType: UPEmptyType = UPEmptyType.UPEmptyTypeData
  onCallBack?: () => void;

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => toast('暂无内容'))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })

      Row() {
        Text('名称/代码').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('40%');
        Text('现价').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
        Text('涨跌幅').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
        Text('信号').fontSize(13).fontColor($r('app.color.up_common_text_secondary_color')).width('20%');
      }

      if (CommonUtil.isListNotNull(this.bean.data)) {
        Text('列表数据不为空,UI待完成').fontSize(16)
      } else {
        EmptyView({
          emptyType: $emptyType,
          onMyClick: () => {
            Logger.error('点击了')
            this.emptyType = UPEmptyType.UPEmptyType404
            if (this.onCallBack !== undefined) {
              this.onCallBack();
            }
          }
        }).height(200)
      }

    }
  }
}


@Component
struct LTQBItem {
  bean: LTQB

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => toast('暂无内容'))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })
    }
  }
}


@Component
struct QSLTItem {
  bean: QSLT

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => toast('暂无内容'))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })
    }
  }
}

@Component
struct YZDGItem {
  bean: ZYDGPools

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => RouterUtil.toWeb(H5Address.STOCK_POOL_STRATEGY_ZYDG))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })
      //if(CommonUtil.isListNotNull(this.bean.data)){
        Flex({ direction: FlexDirection.Row }) {
          ChildItem({ strategyPool: this.bean.data[0], icon: $r('app.media.icon_lt_mx_first') })
          ChildItem({ strategyPool: this.bean.data[1], icon: $r('app.media.icon_lt_mx_second'),marginLeft:8 })
          ChildItem({ strategyPool: this.bean.data[2], icon: $r('app.media.icon_lt_mx_third'),marginLeft:8  })
        }
     // }

    }
  }
}

@Component
struct ChildItem {
  @State strategyPool: StrategyPool = null
  icon: Resource
  marginLeft: number
  build() {
    RelativeContainer() {

      Image(this.icon)
        .objectFit(ImageFit.Auto)
        .width(18.5)
        .height(20)
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        }).id("icon")

      if (this.strategyPool != null && !CommonUtil.isEmpty(this.strategyPool.stockName)) {
        Text(this.strategyPool.stockName)
          .fontSize(14)
          .fontColor($r('app.color.up_common_text_primary_color'))
          .margin({top:15})
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            // left: { anchor: '__container__', align: HorizontalAlign.Start },
            //   center: { anchor: '__container__', align: VerticalAlign.Center }, //以父组件为锚点，竖直方向底端对齐
            middle: { anchor: '__container__', align: HorizontalAlign.Center } //以父组件为锚点，水平方向开头对齐

          }).id("stockName")
        Text(this.strategyPool.code)
          .fontSize(11)
          .fontColor('#A6AEC1')
          .padding({ left: 5, right: 5 })
          .margin({top:5})
          .alignRules({
            top: { anchor: 'stockName', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          }).id("code")
        Text('--')
          .fontSize(14)
          .fontColor('#F55459')
          .padding({ left: 5, right: 5 })
          .alignRules({
            top: { anchor: 'code', align: VerticalAlign.Bottom },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          }).id("ratio")
      } else {
        Text('未入选…')
          .fontSize(14)
          .fontColor('#999999')
          .padding({ left: 5, right: 5 })
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          }).id('default')
      }

    }.borderRadius(5).height(75).width('33.333%')
    .backgroundColor('#F9F9F9')
    .margin({ left: this.marginLeft })
  }
}

@Component
struct PEGItem {
  bean: PEGPools

  build() {
    Column() {
      Row() {
        Text(this.bean.name).fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14).onClick(() => RouterUtil.toWeb(H5Address.STOCK_POOL_STRATEGY_PEG))
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })
      Flex({ direction: FlexDirection.Row }) {
        ChildItem({ strategyPool: this.bean.data[0], icon: $r('app.media.icon_lt_mx_first') })
        ChildItem({ strategyPool: this.bean.data[1], icon: $r('app.media.icon_lt_mx_second'),marginLeft:8 })
        ChildItem({ strategyPool: this.bean.data[2], icon: $r('app.media.icon_lt_mx_third'),marginLeft:8  })
      }
    }
  }
}