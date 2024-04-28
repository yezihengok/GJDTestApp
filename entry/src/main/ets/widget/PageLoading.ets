import { MaterialProgressBar, MaterialProgressStyle } from '@ohos/materialprogressbar'
import { toast } from '../common/utils/Toast';

export enum LoadState {
  LOADING,
  SUCCESS,
  FAIL,
  EMPTY
}

@Component
export struct PageLoading {
  @Link  @Watch('changeState')loadState: LoadState;
  onReload?: () => void;
  @Link showLoading: boolean;
  @BuilderParam content: () => void;
  @State rotateAngle: number = 0

  changeState() {
    if(this.loadState === LoadState.LOADING ||this.loadState === LoadState.SUCCESS){
      setTimeout(()=>{
        this.rotateAngle = 360
        toast("开始")
      },100)

    }

  }
  build() {
    Stack() {
      if (this.loadState === LoadState.LOADING) {
        // MaterialProgressBar({ style: MaterialProgressStyle.MaterialCircular,
        //   modelBuild: {
        //     color: $r("app.color.main"),
        //     bgColor: $r("app.color.divider"),
        //     indeterminate: true,
        //     strokeWidth: 4
        //   } })
        //   .margin({ left: 16, top: 16 })
        //   .align(Alignment.Center)
        Image($r('app.media.common_loading'))
          .height($r('app.float.size_45'))
          .width($r("app.float.size_45"))
          .rotate({ angle: this.rotateAngle })
          .animation({
            duration: 300,
            iterations: -1,
            curve: Curve.Linear,
          }).align(Alignment.Center)

      } else if (this.loadState === LoadState.SUCCESS) {
        this.content();
        if (this.showLoading) {
          Stack() {
            Stack() {
              // MaterialProgressBar({ style: MaterialProgressStyle.MaterialCircular,
              //   modelBuild: {
              //     color: $r("app.color.white"),
              //     bgColor: Color.Transparent,
              //     indeterminate: true,
              //     strokeWidth: 4,
              //   } })
              //   .margin({ left: 16, top: 16 })
              //   .align(Alignment.Center)
              Image($r('app.media.common_loading'))
                .height($r('app.float.size_45'))
                .width($r("app.float.size_45"))
                .rotate({ angle: this.rotateAngle })
                .animation({
                  duration: 500,
                  iterations: -1,
                  curve: Curve.Friction,
                }).align(Alignment.Center)
            }
            .width(100)
            .height(100)
            .align(Alignment.Center)
            .backgroundColor($r("app.color.translucent_black_50"))
            .borderRadius(8)
          }
          .width('100%')
          .height('100%')
          .onClick((e) => {
          })
        }
      } else if (this.loadState === LoadState.FAIL) {
        Stack() {
          Text("加载失败，点击重试")
            .align(Alignment.Center)
        }
        .width('100%')
        .height('100%')
        .onClick((event) => {
          if (this.onReload !== undefined) {
            this.onReload();
          }
        })
      } else {
        Stack() {
          Text("这里什么都没有")
            .align(Alignment.Center)
        }
        .width('100%')
        .height('100%')
        .onClick((event) => {
          if (this.onReload !== undefined) {
            this.onReload();
          }
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}

