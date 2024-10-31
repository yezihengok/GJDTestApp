import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import { TitleLayout } from '../widget/TitleLayout';

export class WebBean{
  title:string =''
  url:string=''

  constructor(title:string,url:string) {
    this.title=title
    this.url=url
  }
}

@Entry
@Component
export struct WebPage {
  private webController: web_webview.WebviewController = new web_webview.WebviewController()
  private params= router.getParams() as WebBean
  private url: string = this.params.url

  @State title: string = "加载中…"
  @State progress: number = 0

  onBackPress() {
    if (this.webController.accessBackward()) {
      this.webController.backward()
    } else {
      router.back()
    }
  }

  build() {
    Column() {
      TitleLayout({
        title: $title,
        onBack: () => {
          this.onBackPress()
        }
      })
      Stack({ alignContent: Alignment.Top }) {
        Web({
          src: this.url,
          controller: this.webController,
          renderMode: RenderMode.SYNC_RENDER // 设置为同步渲染模式

        })
          .width('100%')
          .height('100%')
          .onlineImageAccess(true)
          .javaScriptAccess(true)
          .domStorageAccess(true)
          .databaseAccess(true)
          .mixedMode(MixedMode.All)

          .onTitleReceive((event) => {
            this.title = event.title
          })
          .onProgressChange((event) => {
            this.progress = event.newProgress
          })
        if (this.progress != 100) {
          Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
            .width('100%')
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}