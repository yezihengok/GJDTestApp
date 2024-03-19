
import router from '@ohos.router';
export class RouterUtil{

  static toWeb(link?: string){
    router.pushUrl({
      url: 'pages/WebPage',
      params: {
        url: link
      }
    });
  }
}