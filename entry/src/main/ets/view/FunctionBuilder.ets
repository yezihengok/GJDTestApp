import { FunctionData, MFunction } from '../common/net/model/FunctionData';
import Logger from '../common/utils/Logger';
import { toast } from '../common/utils/Toast';

import { RouterUtil } from '../common/utils/RouterUtil';
import { TypeJGQ } from '../data/HomeDataType';

/**
 * 功能金刚区
 */
@Component
export default struct FunctionBuilder {
  //private dataList:Array<Array<MFunction>>=[];
  private data: TypeJGQ;
  private swiperController: SwiperController = new SwiperController()
  @State color: string = "Color.White";

  build() {
    Column() {
       if (this.data.dataSuccess) {

         Swiper(this.swiperController) {
           ForEach(this.data.dataList, (item: Array<MFunction>, index) => {

             Column() {
               Grid() {

                 ForEach(item, (data: MFunction, index) => {
                   GridItem() {
                     this.mFucItem(data, index)
                   }.width('100%')
                 }, data => JSON.stringify(data))

               }
               .rowsTemplate('1fr 1fr')
               .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
               .rowsGap(10)
               .columnsGap(10)
               .height(140)
             }.padding({left:5,right:5})
           }, (item: Array<FunctionData>, index: number) => JSON.stringify(item) + index)
         }
         .autoPlay(false)
         .loop(false)
         .indicatorStyle({
           color: $r('app.color.up_common_text_secondary_2_color'),
           selectedColor: $r('app.color.up_common_brand_color')
         })
         .indicator(true)
         .itemSpace(5)
         .padding({ bottom: 25 })

       }
    }.width('100%').cardStyle()

  }

  @Builder mFucItem(fuc: MFunction, index: number) {
    Column() {
      Image(fuc.icon).width(30).height(30)
      Text(fuc.categoryName).fontSize(13).textAlign(TextAlign.Center).margin({ top: 5 })
    }.width('100%')
    .padding({ left: 5, right: 5, top: 8, bottom: 8 })
    .onClick(() => {
      toast(fuc.link)
      Logger.info(`点击了=======>${JSON.stringify(fuc)}`)
      RouterUtil.toWeb(fuc.link)

    })
    // .backgroundColor(CommonUtil.getTestColor(index))

  }

  @Styles
  cardStyle(){
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_twelve'))
    // .margin({ bottom: $r('app.float.vp_twelve') })
  }
}