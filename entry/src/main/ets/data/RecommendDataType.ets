/**
 * 首页banner类型数据
 */
import { CircleInfo } from '../common/net/model/CircleInfo';
import { CircleTrendData } from '../common/net/model/CircleTrendData';

//Class被@Observed装饰，其成员变量的赋值的变化是可以被观察到的

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