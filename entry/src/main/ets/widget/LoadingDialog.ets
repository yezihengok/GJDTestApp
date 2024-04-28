/**
 * 通用loading
 */



@CustomDialog
export struct LoadingDialog {
  @Prop loadingTips: string
  @State rotateAngle: number = 0
  //弹窗控制器
  controller: CustomDialogController

  build() {
    Stack() {
      Column() {
        Image($r('app.media.common_loading')).objectFit(ImageFit.Contain)
          .height($r('app.float.size_40'))
          .width($r("app.float.size_40"))
          .rotate({ angle: this.rotateAngle })
          .animation({
            duration: 800,
            iterations: -1,
            curve: Curve.Linear
          })
        Text(this.loadingTips)
          .fontSize($r('app.float.size_text_15'))
          .margin({ top: $r('app.float.size_10') })
      }
      .justifyContent(FlexAlign.Center)
      .height($r('app.float.size_140'))
      .width($r('app.float.size_140'))
      .aspectRatio(1.0)
      .backgroundColor($r('app.color.white'))
      .border({ radius: $r('app.float.size_5') })
      // 通过设置ratios为[0.0, 1.0]，实现当组件完全显示或完全消失在屏幕中时触发回调
      .onVisibleAreaChange([0.0, 1.0], (isVisible: boolean, currentRatio: number) => {
        console.info('Test Text isVisible: ' + isVisible + ', currentRatio:' + currentRatio)
        if (isVisible && currentRatio >= 1.0) {//currentRatio：触发回调时，组件可见面积与自身面积的比
          console.info('Test Text is fully visible. currentRatio:' + currentRatio)
          this.rotateAngle = 360
          //控件可见时更改角度触发刷新
        }
        if (!isVisible && currentRatio <= 0.0) {
          console.info('Test Text is completely invisible.')
          this.rotateAngle = 0
        }
      })
    }
  }
}