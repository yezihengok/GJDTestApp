import { Constant } from './Constant';
export class H5Address{
  //牛散达人
   static readonly   HOME_NSDR_URL = Constant.H5_BASE_URL + "/ns_stock/#/";
   static readonly   HOME_BXJJ_MORE_URL = Constant.H5_BASE_URL3 + "/h5/north/index.html#/stockselectpool";
   static readonly   STOCK_POOL_STRATEGY_ZYDG = Constant.H5_BASE_URL3 + "/h5/operate/index.html#/stability/strategySelectionList?up_immersive=1";
   static readonly   STOCK_POOL_STRATEGY_PEG = Constant.H5_BASE_URL3 + "/h5/operate/index.html#/valueGrowth/strategySelectionList?up_immersive=1";
}