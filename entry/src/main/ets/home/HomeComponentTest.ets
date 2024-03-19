// import Api from '../common/net/Api';
// import { BannerData } from '../common/net/model/BannerData';
// import Logger from '../common/utils/Logger';
// import { toast } from '../common/utils/Toast';
// import BannerBuilder from '../view/BannerBuilder';
// import { PageLoading } from '../widget/PageLoading';
// import router from '@ohos.router';
// import { FunctionData, MFunction } from '../common/net/model/FunctionData';
//
// import { CommonUtil } from '../common/constants/CommonUtil';
// import FunctionBuilder from '../view/FunctionBuilder';
// import { ContentArticle } from '../common/net/model/ContentArticle';
// import { ContentListReq } from '../common/net/model/Request';
// import { IndexMainTab } from './index/IndexMainTab';
// import { Config } from '../common/constants/Config';
//
//
// // It's not a recommended way to export struct with @Entry decorator
// // , which may cause ACE Engine error in component preview mode.
//
// // @Entry
// @Component
// export struct HomeComponentTest {
//   @State bannerList: Array<BannerData> = [];
//   @State bannerSuccess: boolean = false
//   @State functionList: Array<MFunction> = [];
//   @State functionSuccess: boolean = false
//   @State functions: Array<Array<MFunction>> = [];
//   private TAG = "HomeComponent";
//   @State showSCJJSwiper: boolean = false
//   @State SCJJList: Array<ContentArticle> = [];
//   private scroller: Scroller = new Scroller();//下拉刷新需要绑定的scroller
//   async getData() {
//     this.loadBannerData('gjd_sy_banner').then((data: BannerData[]) => {
//       this.bannerList = data;
//       this.bannerSuccess = data.length > 0
//
//     }).catch((err: string) => {
//       toast(err)
//     })
//
//     this.loadFunctionData('gjd_sy_jgq').then((data: FunctionData[]) => {
//       //处理数据 10个分一组，最多分2组
//       this.functions = new Array<Array<MFunction>>();
//
//       if (data.length > 0 && data[0] != null && data[0].secondNavbars.length > 0) {
//         this.functionList = data[0].secondNavbars; //code 只穿一个列表只会返回1个
//         //如果功能超过10个就把更多换到第10个
//         if (this.functionList.length > 10) {
//           for (var i = 0; i <= this.functionList.length; i++) {
//             if (this.functionList[i].link == Config.HOME_ICON_NAVIGATION) {
//               CommonUtil.arrIndexExchange(this.functionList, i, 9);
//               break;
//             }
//           }
//           this.functions.push(this.functionList.slice(0, 10))
//           this.functions.push(this.functionList.slice(10))
//         } else {
//           this.functions.push(this.functionList)
//         }
//       }
//
//       this.functionSuccess = this.functions.length > 0
//     })
//
//     this.loadSCJJData().then((data: ContentArticle[]) => {
//       this.SCJJList = data;
//       this.showSCJJSwiper = data.length > 0
//     })
//
//   }
//
//   async loadBannerData(bannerCode: string): Promise<Array<Object>> {
//     return new Promise<Array<Object>>(async (resolve, reject) => {
//       let bannerRsp = await Api.get().getBanner(bannerCode);
//       if (bannerRsp.isSuccess()) {
//         let bannerDataList = bannerRsp.data;
//         resolve(bannerDataList);
//       } else {
//         reject();
//       }
//     })
//   }
//
//   async loadFunctionData(code: string): Promise<Array<Object>> {
//     return new Promise<Array<Object>>(async (resolve, reject) => {
//       let bannerRsp = await Api.get().getFunction(code);
//       if (bannerRsp.isSuccess()) {
//         let functionList = bannerRsp.data;
//         resolve(functionList);
//       } else {
//         reject();
//       }
//     })
//   }
//
//   async loadSCJJData(): Promise<Array<Object>> {
//     let req: ContentListReq = {
//       categoryIdList: [818, 819, 820, 821, 911],
//       pageSize: 10
//     };
//     return new Promise<Array<Object>>(async (resolve, reject) => {
//       let rsp = await Api.get().queryContentList(req);
//       if (rsp.isSuccess()) {
//         let list = rsp.data;
//         resolve(list);
//       } else {
//         reject();
//       }
//     })
//   }
//
//   aboutToAppear() {
//     this.getData()
//   }
//
//   build() {
//     Scroll() {
//       Column() {
//         Stack({ alignContent: Alignment.Top }) {
//           Image($r('app.media.home_top_bg'))
//             .width('100%')
//               // .height('220vp')
//             .objectFit(ImageFit.Auto)
//           Column() {
//             Row() {
//               Image($r('app.media.up_common_mine_default_ic'))
//                 .width('26vp').height('26vp')
//
//               Row() {
//                 Image($r('app.media.home_search_icon'))
//                   .width('20vp').height('20vp')
//                 Text('搜索股票/资讯/功能').fontColor(Color.White).fontSize(14).margin({ left: 5 })
//               }
//               .height('28vp')
//               .borderRadius(20)
//               .backgroundColor('#45ffffff')
//               .layoutWeight(1)
//               .padding({ left: 12, right: 12 })
//               .margin({ left: 12, right: 12 })
//
//               Image($r('app.media.home_customer_service_light_icon'))
//                 .width($r('app.float.vp_twenty_four'))
//                 .height($r('app.float.vp_twenty_four'))
//
//               Image($r('app.media.home_message_light_icon'))
//                 .width($r('app.float.vp_twenty_four'))
//                 .height($r('app.float.vp_twenty_four'))
//                 .margin({ left: $r('app.float.vp_twenty') }).onClick(() => {
//                 // this.bannerSuccess=true
//                 this.getData()
//
//               })
//
//             }.margin({ top: 5, bottom: 10 })
//             .width('100%')
//
//             if (this.functionSuccess) {
//               FunctionBuilder({ dataList: this.functions })
//             }
//             if (this.bannerSuccess) {
//               BannerBuilder({ dataList: $bannerList })
//             }
//
//             KanBoard()
//             if (this.showSCJJSwiper) {
//               //$数据 初始化@Link
//               SCJJSwiper({ dataList: $SCJJList })
//             }
//             IndexMainTab().margin({ top: 10 })
//
//
//           }.padding({ left: $r('app.float.vp_component_left_right'), right: $r('app.float.vp_component_left_right') })
//         }.width('100%')
//
//       }.height('100%')
//     }
//   }
// }
//
//
// @Component
// struct TabTest2 {
//   build() {
//
//     Tabs() {
//       TabContent() {
//         Text('首页的内容').fontSize(30)
//       }.backgroundColor(Color.Pink)
//       .tabBar('首页')
//
//       TabContent() {
//         Text('推荐的内容').fontSize(30)
//       }
//       .tabBar('推荐')
//
//       TabContent() {
//         Text('发现的内容').fontSize(30)
//       }
//       .tabBar('发现')
//
//     }
//
//   }
// }
//
// /**
//  * 今日看板
//  */
// @Component
// struct KanBoard {
//   private marginLeft: number = 3
//
//   build() {
//     Column() {
//       Row() {
//         Text('今日看板').fontWeight(FontWeight.Bold).fontSize(18)
//         Blank()
//         Text('更多').fontSize(14)
//         Image($r('app.media.home_today_kanban_more_arrow')).objectFit(ImageFit.Cover)
//           .height(14).width(7).margin({ left: 5 })
//       }.width('100%').margin({ top: 15, bottom: 10 })
//
//       Row() {
//         this.BoardItem(0)
//         this.BoardItem(this.marginLeft)
//         this.BoardItem(this.marginLeft)
//       }
//
//       Row() {
//         this.BoardItem(0)
//         this.BoardItem(this.marginLeft)
//         this.BoardItem(this.marginLeft)
//         this.BoardItem(this.marginLeft)
//       }.margin({ top: this.marginLeft })
//     }.width('100%')
//   }
//
//   @Builder BoardItem(marginLeft: number) {
//     Column() {
//       Text('--').fontSize(16)
//       Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
//       Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
//     }.borderRadius(5)
//     .layoutWeight(1)
//     .backgroundColor($r('app.color.home_today_kanban_rise_color'))
//     .margin({ left: marginLeft })
//   }
// }
//
// @Component
// struct SCJJSwiper {
//   @Link dataList: Array<ContentArticle>;
//
//   getContent(bean: ContentArticle) {
//     return CommonUtil.isEmpty(bean.title) ? bean.summary : bean.title;
//   }
//
//   build() {
//     Row() {
//       Image($r('app.media.home_market_juejing_icon')).objectFit(ImageFit.Cover)
//         .height(30).width(43)
//
//       Swiper() {
//         ForEach(this.dataList, (item: ContentArticle) => {
//           Row() {
//             Text(item.secondCategoryName)
//               .fontSize(12)
//               .backgroundColor('#14ff7f00')
//               .fontColor('#FF7F00')
//               .borderRadius(3)
//               .padding({ left: 5, right: 5, top: 2, bottom: 2 })
//             Text(this.getContent(item))
//               .fontSize(14)
//               .fontColor(Color.Black)
//               .maxLines(1)
//               .textOverflow({ overflow: TextOverflow.Ellipsis })
//               .height(30)
//               .margin({ left: 10 })
//               .layoutWeight(1)
//           }
//           // .alignItems(HorizontalAlign.Start)
//         }, (item: ContentArticle) => JSON.stringify(item))
//       }.autoPlay(true)
//       .loop(true)
//       .vertical(true)
//       .indicator(false)
//     }.margin({ top: 10 })
//     .padding(5)
//     .borderRadius(5)
//     .backgroundColor('#fff8f8f8')
//   }
// }
//
//
//
//
