
import router from '@ohos.router';
import Logger from './Logger';
export class RouterUtil{

  static toWeb(link?: string){
    router.pushUrl({
      url: 'pages/WebPage',
      params: {
        url: link
      }
    });
  }

  static push(url: string, params?: Object) {
    router.pushUrl({ url: url, params: params }, router.RouterMode.Standard, (err) => {
      if (err) {
        Logger.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      Logger.info('pushUrl success' + url);
    })
  }


}