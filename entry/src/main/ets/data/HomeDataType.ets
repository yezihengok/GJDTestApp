
import { BannerData } from '../common/net/model/BannerData';
import { ContentArticle } from '../common/net/model/ContentArticle';
import { MFunction } from '../common/net/model/FunctionData';


/**
 * 首页金刚区类型数据
 */
export class TypeJGQ {
   dataList: Array<Array<MFunction>> = [];
   dataSuccess: boolean = false

  constructor(dataList: Array<Array<MFunction>>) {
    this.dataList=dataList;
    this.dataSuccess=dataList.length>0
  }
}

/**
 * 首页banner类型数据
 */
export class TypeBanner {
  dataList: Array<BannerData> = [];
  dataSuccess: boolean = false
  constructor(dataList: Array<BannerData>) {
    this.dataList=dataList;
    this.dataSuccess=dataList.length>0
  }
}

/**
 * 首页今日看板类型数据
 */
export class TypeJRKB {

}

/**
 * 首页市场掘金滚动栏类型数据
 */
export class TypeSCJJ {
  dataList: Array<ContentArticle> = [];
  dataSuccess: boolean = false
  constructor(dataList: Array<ContentArticle>) {
    this.dataList=dataList;
    this.dataSuccess=dataList.length>0
  }
}

/**
 * 首页TAB类型数据
 */
export class TypeIndexTab {

}