export class CircleTrendData {
  chargeType: number; //内容收费类型, 0：免费；1：收费
  circleId: number;
  circleInfo: RCInfo;
  collectNum: number; //收藏数
  collectStatus: number; //收藏状态，0未收藏，1已收藏

  contentId: number; //内容id
  contentType: number; //内容形式1文本 2附件，仅type=2时存在
  coverImage: string; //封面图
  fileUrl: string; //附件链接，仅contentType=2时

  lecturerId: number; //讲师id
  lecturers: LectureInfo;
  likeNum: number; //点赞数
  likeStatus: number; //点赞状态，0未点赞，1已点赞
  pictureList: string; //图片列表，仅type=1
  publishTime: string; //发布时间
  shareNum: number; // 分享数
  summary: string; //摘要
  title: string; //标题
  type: number; //类型 1:图文 2:观点3录播，4回放
  viewNum: number; //浏览数
  detailLink: number; //详情页链接

  /**老师观点*/
  static readonly TYPE_TEACHER_ARTICLE:number=3;
  /**老师直播**/
  static readonly TYPE_TEACHER_LIVE:number=4;

  // static getItemType(type:number): MarketNewType {
  //   if(type===2){
  //     return MarketNewType.ITEM_TYPE_PIC_AND_TEXT;
  //   }else if(type===3 ||type===4){
  //     return CircleTrendData.TYPE_TEACHER_LIVE;
  //   }else if(type===1){
  //     return MarketNewType.ITEM_TYPE_HTML_TEXT;
  //   }else{
  //     return CircleTrendData.TYPE_TEACHER_ARTICLE;
  //   }
  //
  // }

}

export class RCInfo {
  chargeType: number; //圈子收费类型, 0:免费；1：收费
  circleAvatar: string; //圈子头像
  circleId: number; //圈子ID
  circleName: string; //圈子名称
  followStatus: number; //是否关注, 0:未关注；1：已关注

  labelList: Array<string>; //标签列表
  liveStatus: number; //直播状态, 0:未开播；1:直播中；3：已结束
  liveLink: string; //直播链接
  payFlag: boolean; //是否已付费

  hasBuy(info: RCInfo): boolean {
    return info.chargeType === 1 && info.payFlag;
  }
}

export class StockInfo {
  marketCode: string;
  stockCode: string;
  stockName: string;
  changeRatio: number;
  changeValue: number;
}

export class LectureInfo {
  avatar: string;
  lecturerId: number;
  name: string;
}

