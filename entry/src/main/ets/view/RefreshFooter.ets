/**
 * 通用上拉加载底部布局
 */
@Component
export struct RefreshFooter {
  @Prop showFooter: boolean

  build() {
    Row() {
      Text("数据加载中，请稍后...").fontColor('#80333333').fontSize($r('app.float.size_text_15'))
    }
    .width("100%")
    .height($r('app.float.size_50'))
    .backgroundColor('#80f8f8f8')
    .visibility(this.showFooter ? Visibility.Visible : Visibility.None)
    .justifyContent(FlexAlign.Center)
  }
}