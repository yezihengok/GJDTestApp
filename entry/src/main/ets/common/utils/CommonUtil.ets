export class CommonUtil {


  /**
   *交换数组中位置
   * array 原数组
   * index1 原位置
   * index2 要交换的位置
   */
  static arrIndexExchange(array: any[], index1: number, index2: number) {
    array[index1] = array.splice(index2, 1, array[index1])[0];
    /** splice 会修改原来的数组 slice 不会 返回的是删除后的数据 所以 index2要删除的位置，删除1个数据 返回是index2的数据 然后最后一个参数是新增的数据为index的数据 */
    return array
  }


  static subList(list: Array<any>,start:number,end:number){
    if(CommonUtil.isListNull(list)){
      return [];
    }
    //区别1：splice方法会对原数组产生修改，slice方法不会
    //区别2：splice的第二个参数代表的是个数，但是slice的第二个参数代表的是区间（包含左边不包含右边）
   return list.slice(start,end)
  }

  static getTestColor(index: number) {
    let color: Color = Color.Orange
    if (index % 2 == 0) {
      color = Color.Grey
    }
    return color
  }

  /**
   * 判断字符串是否为空
   * @param str
   * @returns
   */
  static isEmpty(str) {
    if (typeof str == null || str == '' || str == 'undefined') {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 判断list 是否为空
   */
  static isListNull(list: Array<any>) {
    return list == null || list.length == 0;
  }
  /**
   * 判断list 是否为空
   */
  static isListNotNull(list: Array<any>) {
    return !CommonUtil.isListNull(list);
  }



  static getDefaultNumber(num:number) {
    if ( num === null || num===undefined) {
      return 0;
    } else {
      return num;
    }
  }

  /**
   * 生成 [ n, m ) 范围内的随机数（大于等于n，小于m）
   * @param start
   * @param end
   */
  static getRandom(n:number,m:number){
    let random=Math.random()*(m-n)+n;
    //随机数四舍五入取整返回
    return Math.round(random)
  }


}
