import emitter from "@ohos.events.emitter"

/**
 * 展示Loading的Event
 * @param showLoading
 * @param "
 * @returns
 */
export function LoadingDialogEvent(showLoading: boolean, loadingTips: string = "加载中...") : emitter.EventData {
  return {
    data: {
      "showLoading": showLoading,
      "loadingTips": loadingTips
    }
  }
}
