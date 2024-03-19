export class DateUtil {
  static readonly MMdd_HH_mm = "MM-dd HH:mm";
  static readonly YYYY_MM_DD_HH_mm_ss = "yyyy-MM-dd HH:mm:ss";


  /**
   * date时间字符串转时间戳
   * @param dateStr 时间字符串
   * @param format 时间格式
   * @returns
   */
  static dateToStamp(dateStr: string): number {
    var date = new Date(dateStr); //时间对象
    // var timestamp2 = Date.parse(date.toString());
    var time = date.getTime();
    return (date != null || date!=undefined) ? time : 0;
  }
}