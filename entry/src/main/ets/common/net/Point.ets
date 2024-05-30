export class Point {
  x: number
  y: number

  //?代表可不传
  constructor(x?: number , y?: number ) {
    this.x = x
    this.y = y
  }

  set(x: number, y: number){
    this.x = x
    this.y = y
  }

}