@Component
export struct NoMoreFooter {
  @Prop show: boolean

  build() {
    Row() {
      Divider().strokeWidth(1).color($r('app.color.up_common_divider_strong_color')).width($r('app.float.size_50'))
      Text("我是有底线的")
        .margin({ left: 15, right: 15 })
        .fontColor($r('app.color.up_common_text_secondary_color'))
        .fontSize($r('app.float.size_text_15'))
      Divider().strokeWidth(1).color($r('app.color.up_common_divider_strong_color')).width($r('app.float.size_50'))
    }
    .height($r('app.float.size_50'))
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .visibility(this.show ? Visibility.Visible : Visibility.None)
    .width("100%")
  }
}