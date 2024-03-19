
import { BaseBean } from './BaseBean'

export class ContentListReq extends BaseBean{
  categoryIdList: Array<Number>//栏目
  pageSize: number = 10

}