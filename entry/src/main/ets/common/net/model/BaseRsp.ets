export class BaseRsp<T> {
  code: number = 0
  msg: string = ""
  data: T = null

  /**
   * DG的接口返回 200就是成功
   */
  isSuccess(): boolean {
    return this.code === 200
  }

  // isSuccessWithData(): boolean {
  //   return this.code === 0 && !!this.data
  // }
}
