
export class CircleInfo {
  //文章数
  articleCount: number;
  circleAvatar: string = '';
  circleName: string = '';
  followCount: number;
  followFlag: boolean;
  id: number;
  //讲师认证
  label: string = '';
  lecturerName: string = '';
  liveStatus: number;//直播状态, 0:未开播；1:直播中；3：已结束
  //证券执业编号
  practiceNo: string = '';
  tagList:Array<string>;//圈子标签

   tags: string;
   payFlag: boolean;//是否已付费
   freeFlag: boolean;//是否免费
   likeCount:number; //点赞数
   circleIntro: string;//圈子简介
   latestPublishTime:number;//最近发布时间
}