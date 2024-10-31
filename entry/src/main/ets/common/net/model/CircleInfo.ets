
export class CircleInfo {
  //文章数
  articleCount: number=0;
  circleAvatar: string = '';
  circleName: string = '';
  followCount: number;
  followFlag: boolean;
  id: number=0;
  //讲师认证
  label: string = '';
  lecturerName: string = '';
  liveStatus: number;//直播状态, 0:未开播；1:直播中；3：已结束
  //证券执业编号
  practiceNo: string = '';
  tagList:Array<string>=[]//圈子标签

   tags: string='';
   payFlag: boolean=false;//是否已付费
   freeFlag: boolean=false;//是否免费
   likeCount:number=0; //点赞数
   circleIntro: string='';//圈子简介
   latestPublishTime:number=0;//最近发布时间

  constructor(followCount: number,liveStatus: number, circleName: string, followFlag: boolean) {
    this.followCount = followCount;
    this.liveStatus = liveStatus;
    this.circleName = circleName;
    this.followFlag = followFlag;
  }
}