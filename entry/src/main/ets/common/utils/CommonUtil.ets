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

}
