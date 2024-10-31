import http from '@ohos.net.http';
import hilog from '@ohos.hilog';

import uri from '@ohos.uri';
import PersistentCookieJar from './cookie/PersistentCookieJar';
import CookieJar from './cookie/CookieJar';
import CookieUtils from './cookie/CookieUtils';
import { BaseRsp } from './model/BaseRsp';
import EntryContext from '../utils/EntryContext';
import { Headers } from '../../data/HeadersData';
import { BannerData } from './model/BannerData';
import { Constant } from '../constants/Constant';
import Logger from '../utils/Logger';
import { FunctionData } from './model/FunctionData';
import { ContentListReq } from './model/Request';
import { ContentArticle } from './model/ContentArticle';
import { MarketNew } from './model/MarketNew';
import { CircleInfo } from './model/CircleInfo';
import { CircleTrendData } from './model/CircleTrendData';
import { StrategyTools } from './model/StrategyTools';
import { UPServiceConfig } from '../constants/UPServiceConfig';
import { CommonUtil } from '../utils/CommonUtil';


let TAG = "Api";
// let BASE_URL: string = "https://www.wanandroid.com";
let context = EntryContext.getContext() as Context;
let cookieJar: CookieJar = new PersistentCookieJar(context);

function parseUri(url: string): uri.URI {
  return new uri.URI(url);
}

async function requestSync<T>(url: string, method: http.RequestMethod, extraData?: Object): Promise<BaseRsp<T>> {
  // await cookieJar.init();
  //  cookieJar.init();
  return new Promise<BaseRsp<T>>((resolve, reject) => {
    let uri = parseUri(url);

    // let header = {};
    let header = Headers;
    let cookies = cookieJar.loadForRequest(uri);
    if (cookies.length > 0) {
      // header["Cookie"] = CookieUtils.cookieHeader(cookies);
      header.Cookie = CookieUtils.cookieHeader(cookies);
    }
    if (method === http.RequestMethod.POST) {
      // header["Content-Type"] = "application/x-www-form-urlencoded";
      // header["Content-Type"] = "application/json";

      if (!extraData) {
        // POST 必须有请求体，否则会报 Parameter error
        // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
        extraData: "data to send"
      }
    }
    let httpRequest = http.createHttp();
    Logger.warn(TAG, `start request, url: ${url}, method: ${method}, extraData: ` + JSON.stringify(extraData));
    httpRequest.request(
      url,
      {
        method: method,
        // expectDataType: http.HttpDataType.OBJECT,
        // 可选，默认无此字段
        expectDataType: http.HttpDataType.STRING ,
        // 可选，默认为60s
        connectTimeout: 15000,
        // 可选，默认为60s
        readTimeout: 15000,
        header: header,
        extraData: extraData
      },
      (err, data) => {
        let res = new BaseRsp<T>()
        let resObj: Record<string, Object>
        if (!err && data.responseCode === 200) {
          cookieJar.saveFromResponse(uri, CookieUtils.parseHttpRequestCookies(data.cookies))
          if (typeof data.result === 'string') {
            //Object.assign(res, JSON.parse(data.result));
            res = JSON.parse(data.result)
          } else {
            //Object.assign(res, data.result);
            res = JSON.parse(JSON.stringify(data.result))
            /*            resObj=shallowCopy(data.result);
                        res.code=resObj['code']as number;
                        res.msg=resObj['msg']as string;
                        res.data=resObj['data'] as T;*/
          }


          Logger.warn(TAG, `url: ${url} header:${JSON.stringify(header)}
          result: ${JSON.stringify(res)}`);

        } else {
          hilog.error(0, TAG, `request error, url: ${url}, error: ${JSON.stringify(err)}`)
          res.code = data?.responseCode ?? -1
          res.msg = err?.message ?? ""
        }
        //todo 测试用~~~~~~~~~~~~~~~~~~~~~~~~
        //if(data.result===null){
        if (url.startsWith(Constant.REQ_BANNER_URL)) {
          Logger.warn("banner接口无数据，，添加测试默认banner数据")
          //Object.assign(res, JSON.parse(UPServiceConfig.test_banner_data));
          res = JSON.parse(UPServiceConfig.test_banner_data)
          res.code = 200
        } else {
          Logger.warn(`请求:${url}`)
        }
        // }

        resolve(res);
      }
    )
  })
}

// function shallowCopy(obj: object): object {
//  let newObj = {};
//  Object.assign(newObj, obj);
//  return newObj;
// }
//浅拷贝
function shallowCopy(obj: object): Record<string, Object> {
  let newObj: Record<string, Object> = {};
  for (let key of Object.keys(obj)) {
    newObj[key] = obj[key];
  }
  return newObj;
}

export default class Api {
  private static instance: Api;

  private constructor() {
  }

  static get(): Api {
    if (Api.instance === undefined) {
      Api.instance = new Api();
    }
    return Api.instance;
  }

  clearCookie() {
    cookieJar.clear();
  }

  async getBanner(bannerCode: string): Promise<BaseRsp<Array<BannerData>>> {
    return requestSync(`${Constant.REQ_BANNER_URL}?bannerCode=${bannerCode}`, http.RequestMethod.GET);
  }

  /**
   * 根据功能区编码查询 (金刚区返回的是已编辑的)
   * @param codes 功能区编码(多个使用,分隔)
   */
  async getFunctionData(codes: string): Promise<BaseRsp<Array<FunctionData>>> {
    return requestSync(`${Constant.REQ_FUNCTION_URL}?codes=${codes}`, http.RequestMethod.GET);
  }

  async queryContentList(req: ContentListReq): Promise<BaseRsp<Array<ContentArticle>>> {
    return requestSync(Constant.GET_ARTICLE_CONTENT, http.RequestMethod.POST, req);
  }

  /**
   * 市场动态
   * @param lastTimestamp 上一页最后一条时间戳 首页 0
   */
  async marketNews(lastTimestamp: number, pageSize: number): Promise<BaseRsp<Array<MarketNew>>> {
    let url = `${Constant.REQ_HOME_MARKET_NEWS_URL}?platformId=3001&dgUserName=${Headers.dgUid}&pageSize=${pageSize}`
    if (lastTimestamp > 0) {
      //首页不传此参数
      url = url.concat('&lastTimestamp=', lastTimestamp.toString())
    }
    return requestSync(url, http.RequestMethod.GET);
  }

  /**
   * 首页-鼎圈推荐
   * @param pageSize
   * @returns
   */
  async getRecommendCircle(pageSize: number): Promise<BaseRsp<Array<CircleInfo>>> {
    return requestSync(`${Constant.HOME_RECOMMEND_CIRCLE}?limit=${pageSize}`, http.RequestMethod.GET);
  }

  /**
   * 首页-推荐 鼎圈动态
   * @param pageSize
   * @returns
   */
  async getCircleTrends(lastTimestamp: number, pageSize: number): Promise<BaseRsp<Array<CircleTrendData>>> {
    let url = `${Constant.HOME_RECOMMEND_CIRCLE_TRENDS}?pageSize=${pageSize}`
    if (lastTimestamp > 0) {
      //首页不传此参数
      url = url.concat('&lastTimestamp=', lastTimestamp.toString())
    }

    return requestSync(`${Constant.HOME_RECOMMEND_CIRCLE_TRENDS}?pageSize=${pageSize}`, http.RequestMethod.GET);
  }

  async getStrategyTools(): Promise<BaseRsp<StrategyTools>> {
    return requestSync(`${Constant.GET_STRATEGY_TOOLS}?code=stratagy`, http.RequestMethod.GET);
  }

  /*  async getHomeArticleList(page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/article/list/${page}/json`, http.RequestMethod.GET);
    }

    async getTopArticle(): Promise<BaseRsp<Array<Article>>> {
      return requestSync("/article/top/json", http.RequestMethod.GET);
    }

    async getHomeBanner(): Promise<BaseRsp<Array<HomeBannerData>>> {
      return requestSync("/banner/json", http.RequestMethod.GET);
    }

    async getSquareArticleList(page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/user_article/list/${page}/json`, http.RequestMethod.GET);
    }

    async getWeChatAuthorList(): Promise<BaseRsp<Array<WeChatAuthor>>> {
      return requestSync("/wxarticle/chapters/json", http.RequestMethod.GET)
    }

    async getWeChatArticleList(id: number, page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/wxarticle/list/${id}/${page}/json`, http.RequestMethod.GET);
    }

    async login(username: string, password: string): Promise<BaseRsp<User>> {
      return requestSync("/user/login", http.RequestMethod.POST, `username=${username}&password=${password}`);
    }

    async logout(): Promise<BaseRsp<string>> {
      return requestSync("/user/logout/json", http.RequestMethod.GET);
    }

    async getUserInfo(): Promise<BaseRsp<User>> {
      return requestSync("/lg/coin/userinfo/json", http.RequestMethod.GET);
    }

    async getSearchHotKey(): Promise<BaseRsp<Array<HotKey>>> {
      return requestSync("/hotkey/json", http.RequestMethod.GET)
    }

    async search(keyword: string, page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/article/query/${page}/json`, http.RequestMethod.POST, `k=${keyword}`)
    }

    async collect(id: number): Promise<BaseRsp<Object>> {
      return requestSync(`/lg/collect/${id}/json`, http.RequestMethod.POST)
    }

    async unCollect(id: number): Promise<BaseRsp<Object>> {
      return requestSync(`/lg/uncollect_originId/${id}/json`, http.RequestMethod.POST)
    }

    async getCollectList(page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/lg/collect/list/${page}/json`, http.RequestMethod.GET)
    }

    async getTree(): Promise<BaseRsp<Array<Tree>>> {
      return requestSync(`/tree/json`, http.RequestMethod.GET)
    }

    async getTreeArticleList(cid: number, page: number): Promise<BaseRsp<ArticleList>> {
      return requestSync(`/article/list/${page}/json?cid=${cid}`, http.RequestMethod.GET)
    }*/
}