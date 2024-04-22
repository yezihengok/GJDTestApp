import { CommonUtil } from '../../utils/CommonUtil'
export class StrategyTools{
  nsPools:Array<NiuSanJHBData>
  bxPools:BXJJData=null
  zydgPools:Array<StrategyPool>
  pegPools:Array<StrategyPool>

  static  isEmpty(bean:StrategyTools ){
    return CommonUtil.isListNull(bean.nsPools)
    &&bean.bxPools===null
    &&CommonUtil.isListNull(bean.zydgPools)
    &&CommonUtil.isListNull(bean.pegPools);
  }
}


export class NiuSanJHBData {
  innerCode: string = ""; // 股票 603178.sh
  holderName: string = ""; // 牛散
  marketValue: number; //公开股票资产
  zjRatio: number=0;
  stockCode: string = "";
  stockName: string = "";
}

export class BXJJData {
   copyBottom: number=0;//抄底精选
   increasePosition: number=0; //增仓精选
   openPosition: number=0; //建仓精选
   resonance: number=0; //共振精选
  updatedAd: string = ""; //日期
}

export class StrategyPool {
  code: string = "";
  stockName: string = "";
  market: number=0;
  //行情数据
  // public UPMarketData marketData;
  // public Map<String, Double> fieldData = null;
}