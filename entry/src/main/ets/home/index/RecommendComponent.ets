import Api from '../../common/net/Api';
import { TypeDQDT, TypeDQRecommend } from '../../data/RecommendDataType';
@Component
export struct RecommendComponent {
  build() {

  }
}

/**
 * 鼎圈推荐
 */
@Component
struct DQRecommend {
  @State data: Array<Object> = [];

  /**
   *
   * @param lastTimestamp 非0 上拉加载
   * @returns
   */
  async refreshData(lastTimestamp: number): Promise<Array<Object>> {
    return new Promise<Array<Object>>(async (resolve, reject) => {

      if(lastTimestamp===0){
        let recRsp = await Api.get().getRecommendCircle(3);
        if (recRsp.isSuccess()) {
          this.data[0] = new TypeDQRecommend(recRsp.data)
        }

        let circleRsp = await Api.get().getCircleTrends(lastTimestamp,10);
        if (circleRsp.isSuccess()) {
          this.data[1] = new TypeDQDT(circleRsp.data)
        }
        resolve(this.data);
      }else{
        let circleRsp = await Api.get().getCircleTrends(lastTimestamp,10);

          if(circleRsp.isSuccess() && this.data[1] instanceof TypeDQDT){
            let list=this.data[1] as TypeDQDT
            list.dataList.concat(circleRsp.data)
          }
      }

    })
  }


  private marginLeft: number = 3

  build() {
    Column() {
      Row() {
        Text('鼎圈推荐').fontWeight(FontWeight.Bold).fontSize(18)
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
      Image($r('app.media.ic_launcher')).width('26vp').height('26vp').borderRadius(20)
      Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
      Text('--').fontSize(14).fontColor($r('app.color.up_common_rise_color'))
    }.borderRadius(5)
    .layoutWeight(1)
    .backgroundColor($r('app.color.home_today_kanban_rise_color'))
    .margin({ left: marginLeft })
  }
}
