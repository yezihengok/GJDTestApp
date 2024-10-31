export class ContentArticle {
  chargeType: number=0;
  circleId: number=0;
  contentType: number=0; //	内容形式1文本 2附件，仅type=2时存在	integer(int32)
  coverImage: string=''; //	封面图	string
  detailLink: string=''; //	详情页链接	string
  fileUrl: string=''; //	附件链接，仅contentType=2时	string
  lecturerId: number=0; //	讲师id	integer(int64)
  lecturers?: Lecturer; //讲师信息
  likeNum: number=0; //	点赞数	integer(int32)
  likeStatus: number=0; //	点赞状态，0未点赞，1已点赞	integer(int32)
  pictureList: string=''; //	图片列表，仅type=1	string
  publishTime: string=''; //	发布时间	string(date-time)
  publishTimeStamp: number=0; //	发布时间时间戳	integer(int64)
  riskTip: string=''; //	风险提示	string
  secondCategoryId: number=0; //	二级栏目ID	integer(int64)
  secondCategoryName: string=''; //	二级栏目	string
  summary: string=''; //	摘要	string
  text: string=''; //	内容	string
  thirdCategoryId: number=0; //	三级栏目ID	integer(int64)
  title: string=''; //	标题	string
  top: number=0; //	置顶，0否，1是	integer(int32)
  type: number=0; //	类型 1:图文 2:观点3录播，4回放	integer(int32)
  viewNum: number=0; //	浏览数	integer(int32)


}

export class Lecturer {
  avatar: string=''; //头像	string
  lecturerId: string=''; //讲师ID	integer
  name: string=''; //名称	string
}