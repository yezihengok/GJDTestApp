import promptAction from '@ohos.promptAction';
import { BannerData } from '../common/net/model/BannerData';
import { TypeBanner } from '../data/HomeDataType';

/**
 * banner 控件
 */
@Component
export default struct BannerBuilder {
  // @Link dataList:Array<BannerData>
    data?: TypeBanner;
  private swiperController: SwiperController = new SwiperController()
  @State interval: number = 3000
  @State private bannerPosition: number = 0

  build() {

    Column() {
      if (this.data?.dataSuccess) {
        Swiper(this.swiperController) {
          ForEach(this.data.dataList, (item: BannerData, index) => {

            Column() {
              Image(item.materialImg).onClick(() => {
                promptAction.showToast({ message: item.linkUrl })
              }).borderRadius(8)
            }.borderRadius(5)
          }, (item: BannerData, index: number) => JSON.stringify(item) + index)
        }.height(95)

        .autoPlay(true)
        .index(this.bannerPosition)
        .loop(true)
        .indicatorStyle({
          right: 16,
          bottom: 0,
          color: $r('app.color.up_common_text_secondary_2_color'),
          selectedColor: $r('app.color.up_common_brand_color')
        })
        .indicator(true)
        .onChange((index) => {
          this.bannerPosition = index;
        })
        .interval(this.interval)
      }
    }.width('100%')


  }
}