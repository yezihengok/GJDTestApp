
import { BXJJData, NiuSanJHBData, StrategyPool, StrategyTools } from '../common/net/model/StrategyTools'
import { BaseItemType } from './BaseItemType'

export class NSPools extends BaseItemType{
  name="牛散新进股池"

  data: Array<NiuSanJHBData>
  constructor(hasPermission: boolean,data: Array<NiuSanJHBData>) {
    super(hasPermission,data)
    this.data=data;
  }


}

export class BXPools extends BaseItemType {
  name:string="北向风口"
   data:BXJJData
  constructor(hasPermission: boolean,data: BXJJData) {
    super(hasPermission,data)
    this.data=data;
  }
}

export class CDXH extends BaseItemType {
  name="超跌信号"
  // data:any
  // constructor(data: any) {
  //   this.data=data
  // }
}
export class LTQB extends BaseItemType {
  name="龙头起爆"
  // data:any
  // constructor(data: any) {
  //   this.data=data
  // }
}
export class QSLT extends BaseItemType {
  name="趋势龙头"
  // data:any
  // constructor(data: any) {
  //   this.data=data
  // }
}



export class ZYDGPools extends BaseItemType {
  name:string="优质低估策略"
  data:Array<StrategyPool>=new Array();
  constructor(hasPermission: boolean,data: Array<StrategyPool>) {
    super(hasPermission,data)
    this.data=data;
  }
}


export class PEGPools extends BaseItemType {
  name:string="PEG策略"
  data:Array<StrategyPool>
  constructor(hasPermission: boolean,data: Array<StrategyPool>) {
    super(hasPermission,data)
    this.data=data;
  }
}
