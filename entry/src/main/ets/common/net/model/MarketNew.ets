
import { MarketNewType } from '../../constants/CommEnum';
import { CommonUtil } from '../../constants/CommonUtil';

export class MarketNew{
  contentId:number;
  contentType:number;
  coverImage:string;
  detailLink:string;
  fileUrl:string;
  firstCategoryId:number;
  lecturerId:number;
  pictureList:string;
  publishTime:string;
  secondCategoryId:number;
  secondCategoryName:string;
  summary:string;
  text:string;
  thirdCategoryId:number;
  title:string;
  type:number;     //    type：	类型 1:图文(富文本样式) 2:观点（文章） 3录播，4回放	integer(int32)
  enum

   static getItemType(type:number): MarketNewType {
    if(type===2){
      return MarketNewType.ITEM_TYPE_PIC_AND_TEXT;
    }else if(type===3 ||type===4){
      return MarketNewType.ITEM_TYPE_VIDEO;
    }else if(type===1){
      return MarketNewType.ITEM_TYPE_HTML_TEXT;
    }else{
      return MarketNewType.ITEM_TYPE_PIC_AND_TEXT;
    }

  }

  static getPicList(bean: MarketNew):Array<string>{
    let picList:Array<string>=[];
    //coverImage 优先
    if(!CommonUtil.isEmpty(bean.coverImage)){
      picList[0]=bean.coverImage;
    }else if(!CommonUtil.isEmpty(bean.pictureList)){
      picList=bean.pictureList.split(',')
    }
    return picList;
  }

}