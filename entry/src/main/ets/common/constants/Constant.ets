
export class Constant{

  static readonly SERVER_CODE_SUCCESS: string = '200';

  static readonly H5_BASE_URL: string = 'https://estock.gjdapp.wlstock.com';
  static readonly H5_BASE_URL2: string = 'https://operate.gjdapp.wlstock.com';
  static readonly H5_BASE_URL3: string = 'http://static.gjdapp.wlstock.com';
  public static readonly WL_BASE_URL: string = Constant.H5_BASE_URL2+"/back";


  static readonly REQ_BANNER_URL: string = Constant.WL_BASE_URL + "/system/app/banner";
  /**功能区**/
  static readonly REQ_FUNCTION_URL: string = Constant.WL_BASE_URL + "/system/app/navbar/secondFunc";
  static readonly  GET_ARTICLE_CONTENT: string = Constant.WL_BASE_URL + "/article/app/article/contentList";
  /**首页市场动态**/
  static readonly  REQ_HOME_MARKET_NEWS_URL: string = Constant.WL_BASE_URL + "/article/app/article/index/marketNews";
  /**
   * 首页-鼎圈推荐
   */
  static readonly HOME_RECOMMEND_CIRCLE: string =  Constant.WL_BASE_URL +  "/user/app/circle/recommend";
  /**
   * 首页-鼎圈动态
   */
  static readonly  HOME_RECOMMEND_CIRCLE_TRENDS: string =  Constant.WL_BASE_URL +  "/article/app/article/index/recommendList";
   static readonly  GET_STRATEGY_TOOLS: string  = Constant.WL_BASE_URL + "/stockpool/app/strategy/tools";
}