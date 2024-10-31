
import router from '@ohos.router';
import { WebBean } from '../../pages/WebPage';
import Logger from './Logger';
export class RouterUtil{

  static toWeb(link: string){
   let web:WebBean=new WebBean('',link)
    router.pushUrl({
      url: 'pages/WebPage',
      params: {
        url: web.url
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