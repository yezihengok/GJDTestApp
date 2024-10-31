import { CommonUtil } from '../common/utils/CommonUtil'

export class BaseItemType {
  name: string = ""
  isEmpty: boolean=false //是否数据为空
  hasPermission: boolean //是否有权限
  data: object|null

  constructor(hasPermission: boolean,data: object|null) {
    this.data = data
    this.hasPermission = hasPermission
    if (data instanceof Object) {
      this.isEmpty = data == null || data == undefined
    }
    if (data instanceof Array) {
      this.isEmpty = CommonUtil.isListNull(data)
    }
  }

}