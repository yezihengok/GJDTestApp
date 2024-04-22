export enum UPEmptyType {
  UPEmptyTypeData = 0,
  UPEmptyTypeNetwork = 1,
  UPEmptyType404 = 2,
  UPEmptyTypeMessage = 3
}

@Component
export struct EmptyView {
  @State msg: string = '暂无数据';
  @State menuIcon: Resource = $r("app.media.up_common_icon_empty_no_data")
  onMyClick?: () => void;
  @Link @Watch('setStatus') emptyType: UPEmptyType

  @Styles pressedStyles() {
    .opacity(0.7)
  }

  @Styles normalStyles(){
    .opacity(1)
  }

  aboutToAppear() {
    this.setStatus()
  }

  setStatus() {
    if (this.emptyType === UPEmptyType.UPEmptyTypeData) {
      this.msg = '暂无数据';
      this.menuIcon = $r("app.media.up_common_icon_empty_no_data")
    } else if (this.emptyType === UPEmptyType.UPEmptyTypeNetwork) {
      this.msg = '努力加载失败，请检查网络';
      this.menuIcon = $r("app.media.up_common_icon_empty_no_network")
    } else if (this.emptyType === UPEmptyType.UPEmptyType404) {
      this.msg = '抱歉，您访问的页面不存在';
      this.menuIcon = $r("app.media.up_common_icon_empty_404")
    }
  }

  build() {
    Column() {

      Image(this.menuIcon)
        .width(200)
        .height(100)
        .objectFit(ImageFit.Cover)
        .stateStyles({ pressed: this.pressedStyles, normal:this.normalStyles })
        .onClick((event) => {
          if (this.onMyClick !== undefined) {
            this.onMyClick();
          }
        })
      Text(this.msg)
        .layoutWeight(1)
        .fontSize(17)
        .fontColor($r("app.color.up_common_text_secondary_0_color"))
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({ left: 16, right: 16 })
        .alignSelf(ItemAlign.Center)
        .textAlign(TextAlign.Center)
        .stateStyles({ pressed: this.pressedStyles, normal:this.normalStyles })

    }.height(200).padding({ top: 10, bottom: 10 })
  }
}