/**
 * 首页banner类型数据
 */
import { CircleInfo } from '../common/net/model/CircleInfo';
import { CircleTrendData } from '../common/net/model/CircleTrendData';
export class TypeDQRecommend {
  dataList: Array<CircleInfo> = [];
  dataSuccess: boolean = false
  constructor(dataList: Array<CircleInfo>) {
    this.dataList=dataList;
    this.dataSuccess=dataList.length>0
  }
}

export class TypeDQDT {
  dataList: Array<CircleTrendData> = [];
  dataSuccess: boolean = false
  constructor(dataList: Array<CircleTrendData>) {
    this.dataList=dataList;
    this.dataSuccess=dataList.length>0
  }
}