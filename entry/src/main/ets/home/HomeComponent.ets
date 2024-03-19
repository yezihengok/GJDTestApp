import Api from '../common/net/Api';
import { BannerData } from '../common/net/model/BannerData';
import Logger from '../common/utils/Logger';
import { toast } from '../common/utils/Toast';
import BannerBuilder from '../view/BannerBuilder';
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh'
import { FunctionData, MFunction } from '../common/net/model/FunctionData';
import { Config } from '../common/constants/Config';
import { CommonUtil } from '../common/constants/CommonUtil';
import FunctionBuilder from '../view/FunctionBuilder';
import { ContentArticle } from '../common/net/model/ContentArticle';
import { ContentListReq } from '../common/net/model/Request';
import { IndexMainTab } from './index/IndexMainTab';
import { TypeBanner, TypeIndexTab, TypeJGQ, TypeJRKB, TypeSCJJ } from '../data/HomeDataType';


// It's not a recommended way to export struct with @Entry decorator
// , which may cause ACE Engine error in component preview mode.

// @Entry
@Component
export struct HomeComponent {
  @State data: Array<Object> = []; //下拉刷新总数据源

  @State functionList: Array<MFunction> = [];
  @State functionSuccess: boolean = false
  @State bannerList: Array<BannerData> = [];
  @State bannerSuccess: boolean = false
  @State functions: Array<Array<MFunction>> = [];
  private TAG = "HomeComponent";
  @State showSCJJSwiper: boolean = false
  @State SCJJList: Array<ContentArticle> = [];
  private scroller: Scroller = new Scroller(); //下拉刷新需要绑定的scroller
  private refreshConfigurator: PullToRefreshConfigurator = new PullToRefreshConfigurator();

  async refreshData(): Promise<Array<Object>> {
    return new Promise<Array<Object>>(async (resolve, reject) => {
      //获取功能区
      let fucRsp = await Api.get().getFunction('gjd_sy_jgq');
      let data = fucRsp.data;
      if (fucRsp.isSuccess()) {
        //处理数据 10个分一组，最多分2组
        this.functions = new Array<Array<MFunction>>();

        if (data.length > 0 && data[0] != null && data[0].secondNavbars.length > 0) {
          this.functionList = data[0].secondNavbars; //code 只穿一个列表只会返回1个
          //如果功能超过10个就把更多换到第10个
          if (this.functionList.length > 10) {
            for (var i = 0; i <= this.functionList.length; i++) {
              if (this.functionList[i].link == Config.HOME_ICON_NAVIGATION) {
                CommonUtil.arrIndexExchange(this.functionList, i, 9);
                break;
              }
            }
            this.functions.push(this.functionList.slice(0, 10))
            this.functions.push(this.functionList.slice(10))
          } else {
            this.functions.push(this.functionList)
          }
        }
        this.functionSuccess = this.functions.length > 0
      }
      //获取banner
      let bannerRsp = await Api.get().getBanner('gjd_sy_banner');
      if (bannerRsp.isSuccess()) {
        this.bannerList = bannerRsp.data;
        this.bannerSuccess = this.bannerList.length > 0
      }

      //获取市场掘金
      let req: ContentListReq = {
        categoryIdList: [818, 819, 820, 821, 911],
        pageSize: 10
      };
      let rsp = await Api.get().queryContentList(req);
      if (rsp.isSuccess()) {
        this.SCJJList = rsp.data;
        this.showSCJJSwiper = rsp.data.length > 0

      }

      this.functionSuccess = this.functions.length > 0
      this.data[0] = new TypeJGQ(this.functions)
      this.data[1] = new TypeBanner(this.bannerList)
      this.data[2] = new TypeJRKB()
      this.data[3] = new TypeSCJJ(this.SCJJList)
      this.data[4] = new TypeIndexTab()
      resolve(this.data);

    })
  }


  /*
   async loadBannerData(bannerCode: string): Promise<Array<Object>> {
      return new Promise<Array<Object>>(async (resolve, reject) => {
        let bannerRsp = await Api.get().getBanner(bannerCode);
        if (bannerRsp.isSuccess()) {
          let bannerDataList = bannerRsp.data;

          this.bannerList = bannerDataList;
          this.bannerSuccess = this.bannerList.length > 0
          resolve(bannerDataList);
        } else {
          reject();
        }
      })
    }

    async loadFunctionData(code: string): Promise<Array<Object>> {
      return new Promise<Array<Object>>(async (resolve, reject) => {
        let bannerRsp = await Api.get().getFunction(code);
        if (bannerRsp.isSuccess()) {
          let data = bannerRsp.data;

          //处理数据 10个分一组，最多分2组
          this.functions = new Array<Array<MFunction>>();

          if (data.length > 0 && data[0] != null && data[0].secondNavbars.length > 0) {
            this.functionList = data[0].secondNavbars; //code 只穿一个列表只会返回1个
            //如果功能超过10个就把更多换到第10个
            if (this.functionList.length > 10) {
              for (var i = 0; i <= this.functionList.length; i++) {
                if (this.functionList[i].link == Config.HOME_ICON_NAVIGATION) {
                  CommonUtil.arrIndexExchange(this.functionList, i, 9);
                  break;
                }
              }
              this.functions.push(this.functionList.slice(0, 10))
              this.functions.push(this.functionList.slice(10))
            } else {
              this.functions.push(this.functionList)
            }
          }

          this.functionSuccess = this.functions.length > 0
          resolve(data);
        } else {
          reject();
        }
      })
    }

    async loadSCJJData(): Promise<Array<Object>> {
      let req: ContentListReq = {
        categoryIdList: [818, 819, 820, 821, 911],
        pageSize: 10
      };
      return new Promise<Array<Object>>(async (resolve, reject) => {
        let rsp = await Api.get().queryContentList(req);
        if (rsp.isSuccess()) {
          let list = rsp.data;

          this.SCJJList = list;
          this.showSCJJSwiper = list.length > 0

          resolve(list);
        } else {
          reject();
        }
      })
    }
    */

  aboutToAppear() {
    // 设置属性
    this.refreshConfigurator
      .setHasRefresh(true) // 是否具有下拉刷新功能
      .setHasLoadMore(false) // 是否具有上拉加载功能
      .setMaxTranslate(150) // 可下拉上拉的最大距离
      .setSensitivity(1) // 下拉上拉灵敏度
      .setListIsPlacement(false) // 滑动结束后列表是否归位
      .setAnimDuration(300) // 滑动结束后，回弹动画执行时间
      .setRefreshHeight(30) // 下拉动画高度
      .setRefreshColor('#ff0000') // 下拉动画颜色
        // .setRefreshBackgroundColor('#ffbbfaf5') // 下拉动画区域背景色
      .setRefreshTextColor(Color.Black) // 下拉加载完毕后提示文本的字体颜色
      .setRefreshTextSize(15) // 下拉加载完毕后提示文本的字体大小
      .setRefreshAnimDuration(1000) // 下拉动画执行一次的时间
      .setLoadImgHeight(30) // 上拉图片高度
        // .setLoadBackgroundColor('#ffbbfaf5') // 上拉动画区域背景色
        // .setLoadTextColor('blue') // 上拉文本的字体颜色
      .setLoadTextSize(15) // 上拉文本的字体大小
      .setLoadTextPullUp1('请继续上拉...') // 上拉1阶段文本
      .setLoadTextPullUp2('释放即可刷新') // 上拉2阶段文本
      .setLoadTextLoading('加载中...') // 上拉加载更多中时的文本

    this.refreshData()
  }

  @Builder
  private getListView() {

    List({ space: 0, scroller: this.scroller }) {
      ForEach(this.data, (item: object, index) => {
        ListItem() {
          if (item instanceof TypeJGQ) {
            FunctionBuilder({ data: item })
          } else if (item instanceof TypeJRKB) {
            KanBoard()
          }
          else if (item instanceof TypeBanner) {
            BannerBuilder({ data: item })
          } else if (item instanceof TypeSCJJ) {
            //$数据 初始化@Link
            SCJJSwiper({ data: item })
          } else if (item instanceof TypeIndexTab) {
            IndexMainTab({ refreshConfig: this.refreshConfigurator }).margin({ top: 10 })

          }

        }
        // .backgroundColor(CommonUtil.getTestColor(index))
      })
    }.width('100%').height('100%')
    .listDirection(Axis.Vertical)
    .backgroundColor(Color.Transparent)
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果

  }

  build() {
    Scroll() {
      Column() {
        Stack({ alignContent: Alignment.Top }) {
          Image($r('app.media.home_top_bg'))
            .width('100%')
              // .height('220vp')
            .objectFit(ImageFit.Auto)
          Column() {
            Row() {
              Image($r('app.media.up_common_mine_default_ic'))
                .width('26vp').height('26vp').borderRadius(20)

              Row() {
                Image($r('app.media.home_search_icon'))
                  .width('20vp').height('20vp')
                Text('搜索股票/资讯/功能').fontColor(Color.White).fontSize(14).margin({ left: 5 })
              }
              .height('28vp')
              .borderRadius(20)
              .backgroundColor('#45ffffff')
              .layoutWeight(1)
              .padding({ left: 12, right: 12 })
              .margin({ left: 12, right: 12 })

              Image($r('app.media.home_customer_service_light_icon'))
                .width($r('app.float.vp_twenty_four'))
                .height($r('app.float.vp_twenty_four'))

              Image($r('app.media.home_message_light_icon'))
                .width($r('app.float.vp_twenty_four'))
                .height($r('app.float.vp_twenty_four'))
                .margin({ left: $r('app.float.vp_twenty') }).onClick(() => {
                // this.bannerSuccess=true
                this.refreshData()

              })

            }.margin({ top: 5, bottom: 10 })
            .width('100%')

            /*  if (this.functionSuccess) {
                          FunctionBuilder({ dataList: this.functions })
                        }
                        if (this.bannerSuccess) {
                          BannerBuilder({ dataList: $bannerList })
                        }

                        KanBoard()
                        if (this.showSCJJSwiper) {
                          //$数据 初始化@Link
                          SCJJSwiper({ dataList: $SCJJList })
                        }
                        IndexMainTab().margin({ top: 10 })*/

            PullToRefresh({
              // 必传项，列表组件所绑定的数据
              data: $data,
              // 必传项，需绑定传入主体布局内的列表或宫格组件
              scroller: this.scroller,
              // 必传项，自定义主体布局，内部有列表或宫格组件
              customList: this.getListView,
              // 可选项，组件属性配置，具有默认值
              refreshConfigurator: this.refreshConfigurator,
              // 可选项，下拉刷新回调
              onRefresh: () => {
                toast("onRefresh")
                this.refreshData()
                return new Promise<string>((resolve, reject) => {
                  // 模拟网络请求网络2秒后得到数据，通知组件，变更列表数据
                  setTimeout(() => {
                    resolve('刷新成功');
                    //this.data = this.dataNumbers;
                  }, 2000);
                });
              },
              // 可选项，上拉加载更多回调
              onLoadMore: () => {
                return new Promise<string>((resolve, reject) => {
                  // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
                  setTimeout(() => {
                    resolve('');
                    // this.data.push("增加的条目" + this.data.length);
                  }, 2000);
                });
              },
              customLoad: null,
              customRefresh: null,
            })

          }.padding({ left: $r('app.float.vp_component_left_right'), right: $r('app.float.vp_component_left_right') })
        }.width('100%')

      }.height('100%')
    }
  }
}


/**
 * 今日看板
 */
@Component
struct KanBoard {
  private marginLeft: number = 3

  build() {
    Column() {
      Row() {
        Text('今日看板').fontWeight(FontWeight.Bold).fontSize(18)
        Blank()
        Text('更多').fontSize(14)
        Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.ScaleDown)
          .height(14).width(7).margin({ left: 5 })
      }.width('100%').margin({ top: 15, bottom: 10 })

      Row() {
        this.BoardItem(0)
        this.BoardItem(this.marginLeft)
        this.BoardItem(this.marginLeft)
      }

      Row() {
        this.BoardItem(0)
        this.BoardItem(this.marginLeft)
        this.BoardItem(this.marginLeft)
        this.BoardItem(this.marginLeft)
      }.margin({ top: this.marginLeft })
    }.width('100%')
  }

  @Builder BoardItem(marginLeft: number) {
    Column() {
      Text('--').fontSize(16)
      Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
      Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
    }.borderRadius(5)
    .layoutWeight(1)
    .backgroundColor($r('app.color.home_today_kanban_rise_color'))
    .margin({ left: marginLeft })
  }
}

@Component
struct SCJJSwiper {
  // @Link dataList: Array<ContentArticle>;
  data: TypeSCJJ

  getContent(bean: ContentArticle) {
    return CommonUtil.isEmpty(bean.title) ? bean.summary : bean.title;
  }

  build() {
    Row() {
      Image($r('app.media.home_market_juejing_icon')).objectFit(ImageFit.Contain)
        .height(30).width(43)
      if (this.data.dataSuccess) {
        Swiper() {
          ForEach(this.data.dataList, (item: ContentArticle) => {
            Row() {
              Text(item.secondCategoryName)
                .fontSize(12)
                .backgroundColor('#14ff7f00')
                .fontColor('#FF7F00')
                .borderRadius(3)
                .padding({ left: 5, right: 5, top: 2, bottom: 2 })
              Text(this.getContent(item))
                .fontSize(14)
                .fontColor(Color.Black)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .height(30)
                .margin({ left: 10 })
                .layoutWeight(1)
            }
            // .alignItems(HorizontalAlign.Start)
          }, (item: ContentArticle) => JSON.stringify(item))
        }.autoPlay(true)
        .loop(true)
        .vertical(true)
        .indicator(false)
      }
    }.margin({ top: 10 })
    .padding(5)
    .borderRadius(5)
    .backgroundColor('#fff8f8f8')
  }
}




