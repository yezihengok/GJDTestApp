
import { Constant } from '../common/constants/Constant';
import { BannerData } from '../common/net/model/BannerData';
import { httpRequestGet } from '../common/utils/HttpUtil';
import Logger from '../common/utils/Logger';


class BannerViewModel{

  getBannerList(bannerCode: string): Promise<BannerData[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = Constant.REQ_BANNER_URL;
      url += '?bannerCode=' + bannerCode ;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Constant.SERVER_CODE_SUCCESS) {
          resolve(data.data);
          Logger.warn('getBannerList success', JSON.stringify(data));
        } else {
          Logger.error('getBannerList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg')+JSON.stringify(data));
        }
      }).catch((err: Error) => {
        Logger.error('getBannerList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}


let newsViewModel = new BannerViewModel();
export default newsViewModel as BannerViewModel;





