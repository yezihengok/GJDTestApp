import router from '@ohos.router';
import CopyrightComponent from '../view/CopyrightComponent';
import { Config } from '../common/constants/Config';

/**
 * SplashScreenPage is the entry of the application and shows how to develop a front page.
 * Stay in SplashScreenPage for seconds to jump to the MainPage.
 * Developers can replace background images with advertising videos.
 */
@Entry
@Component
struct SplashScreenPage {
  @State pageShowTime: number = Config.TIME_DEFAULT_VALUE;
  @State intervalID: number = Config.INTERVAL_ID_DEFAULT;

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.ic_splash_page_background'))
          .width(Config.IMAGE_WIDTH)
          .height(Config.IMAGE_HEIGHT)

     //   AdvertiseIcon()

        SkipButton({ secondsCount: (Config.DELAY_SECONDS - this.pageShowTime) })
      }
      .layoutWeight(Config.STACK_LAYOUT_WEIGHT)
      .width(Config.STACK_WIDTH)

      CopyrightComponent()
    }
    .alignItems(HorizontalAlign.Start)
    .width(Config.COLUMN_WIDTH)
    .height(Config.COLUMN_HEIGHT)
  }

  /**
   * When the SplashScreenPage is displayed, switch to the next page after 3 seconds.
   */
  onPageShow() {
    this.intervalID = setInterval(() => {
      this.pageShowTime += Config.INCREMENT_VALUE;
      if (this.pageShowTime > Config.DELAY_SECONDS) {
        router.replaceUrl({
          url: Config.MAIN_PAGE_URL
        });
      }
    }, Config.INTERVAL_DELAY);
  }

  /**
   * When the SplashScreenPage is hide, clear interval.
   */
  onPageHide() {
    clearInterval(this.intervalID);
  }
}

@Component
struct SkipButton {
  @Prop secondsCount: number;

  build() {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.End
    }) {
      Text($r('app.string.skip', this.secondsCount))
        .backgroundColor($r('app.color.rect_area_background'))
        .borderRadius(Config.SKIP_BUTTON_RADIUS)
        .fontColor(Color.White)
        .width($r('app.float.skip_text_width'))
        .height($r('app.float.skip_text_height'))
        .fontSize($r('app.float.skip_text_size'))
        .margin({
          right: $r('app.float.skip_text_margin_right'),
          top: $r('app.float.skip_text_margin_top')
        })
        .textAlign(TextAlign.Center)
        .border({ width: Config.SKIP_TEXT_BORDER_WIDTH })
        .borderColor($r('app.color.rect_stroke'))
        .onClick(() => {
          router.replaceUrl({
            url: Config.MAIN_PAGE_URL
          });
        })
    }
  }
}

@Component
struct AdvertiseIcon {
  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.End
    }) {
      Image($r('app.media.ic_advertise'))
        .objectFit(ImageFit.Cover)
        .width($r('app.float.advertise_button_width'))
        .height($r('app.float.advertise_button_height'))
    }
    .margin($r('app.float.advertise_icon_margin'))
  }
}