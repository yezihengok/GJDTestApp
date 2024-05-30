
import hilog from '@ohos.hilog'
import { CommonUtil } from '../common/utils/CommonUtil'

@Entry
@Component
struct CanvasExample {

  //模拟接口返回的测试数据
  private   testData={
    "code": 200,
    "data": [{
      "index": 0,
      "price": 30.0
    }, {
      "index": 1,
      "price": 33.0
    }, {
      "index": 2,
      "price": 37.0
    }, {
      "index": 3,
      "price": 33.0
    }, {
      "index": 4,
      "price": 36.0
    }, {
      "index": 5,
      "price": 42.0
    }, {
      "index": 6,
      "price": 36.0
    }, {
      "index": 7,
      "price": 43.0
    }, {
      "index": 8,
      "price": 40.0
    }, {
      "index": 9,
      "price": 47.0
    }, {
      "index": 10,
      "price": 41.0
    }, {
      "index": 11,
      "price": 42.0
    }, {
      "index": 12,
      "price": 51.0
    }, {
      "index": 13,
      "price": 48.0
    }, {
      "index": 14,
      "price": 52.0
    }, {
      "index": 15,
      "price": 53.0
    }, {
      "index": 16,
      "price": 53.0
    }, {
      "index": 17,
      "price": 47.0
    }, {
      "index": 18,
      "price": 51.0
    }, {
      "index": 19,
      "price": 54.0
    }, {
      "index": 20,
      "price": 59.0
    }, {
      "index": 21,
      "price": 52.0
    }, {
      "index": 22,
      "price": 53.0
    }, {
      "index": 23,
      "price": 53.0
    }, {
      "index": 24,
      "price": 54.0
    }, {
      "index": 25,
      "price": 59.0
    }, {
      "index": 26,
      "price": 64.0
    }, {
      "index": 27,
      "price": 60.0
    }, {
      "index": 28,
      "price": 64.0
    }, {
      "index": 29,
      "price": 67.0
    }, {
      "index": 30,
      "price": 65.0
    }, {
      "index": 31,
      "price": 63.0
    }, {
      "index": 32,
      "price": 63.0
    }, {
      "index": 33,
      "price": 64.0
    }, {
      "index": 34,
      "price": 66.0
    }, {
      "index": 35,
      "price": 73.0
    }, {
      "index": 36,
      "price": 75.0
    }, {
      "index": 37,
      "price": 67.0
    }, {
      "index": 38,
      "price": 77.0
    }, {
      "index": 39,
      "price": 71.0
    }, {
      "index": 40,
      "price": 74.0
    }, {
      "index": 41,
      "price": 78.0
    }, {
      "index": 42,
      "price": 79.0
    }, {
      "index": 43,
      "price": 81.0
    }, {
      "index": 44,
      "price": 77.0
    }, {
      "index": 45,
      "price": 76.0
    }, {
      "index": 46,
      "price": 78.0
    }, {
      "index": 47,
      "price": 82.0
    }, {
      "index": 48,
      "price": 79.0
    }, {
      "index": 49,
      "price": 82.0
    }, {
      "index": 50,
      "price": 86.0
    }, {
      "index": 51,
      "price": 90.0
    }, {
      "index": 52,
      "price": 83.0
    }, {
      "index": 53,
      "price": 86.0
    }, {
      "index": 54,
      "price": 93.0
    }, {
      "index": 55,
      "price": 90.0
    }, {
      "index": 56,
      "price": 92.0
    }, {
      "index": 57,
      "price": 94.0
    }, {
      "index": 58,
      "price": 92.0
    }, {
      "index": 59,
      "price": 95.0
    }, {
      "index": 60,
      "price": 92.0
    }, {
      "index": 61,
      "price": 96.0
    }, {
      "index": 62,
      "price": 98.0
    }, {
      "index": 63,
      "price": 94.0
    }, {
      "index": 64,
      "price": 91.0
    }, {
      "index": 65,
      "price": 87.0
    }, {
      "index": 66,
      "price": 87.0
    }, {
      "index": 67,
      "price": 97.0
    }, {
      "index": 68,
      "price": 94.0
    }, {
      "index": 69,
      "price": 94.0
    }, {
      "index": 70,
      "price": 94.0
    }, {
      "index": 71,
      "price": 91.0
    }, {
      "index": 72,
      "price": 88.0
    }, {
      "index": 73,
      "price": 87.0
    }, {
      "index": 74,
      "price": 84.0
    }, {
      "index": 75,
      "price": 80.0
    }, {
      "index": 76,
      "price": 76.0
    }, {
      "index": 77,
      "price": 74.0
    }, {
      "index": 78,
      "price": 71.0
    }, {
      "index": 79,
      "price": 71.0
    }, {
      "index": 80,
      "price": 69.0
    }, {
      "index": 81,
      "price": 68.0
    }, {
      "index": 82,
      "price": 65.0
    }, {
      "index": 83,
      "price": 62.0
    }, {
      "index": 84,
      "price": 60.0
    }, {
      "index": 85,
      "price": 60.0
    }, {
      "index": 86,
      "price": 57.0
    }, {
      "index": 87,
      "price": 55.0
    }, {
      "index": 88,
      "price": 54.0
    }, {
      "index": 89,
      "price": 50.0
    }, {
      "index": 90,
      "price": 46.0
    }, {
      "index": 91,
      "price": 45.0
    }, {
      "index": 92,
      "price": 44.0
    }, {
      "index": 93,
      "price": 42.0
    }, {
      "index": 94,
      "price": 40.0
    }, {
      "index": 95,
      "price": 36.0
    }, {
      "index": 96,
      "price": 35.0
    }, {
      "index": 97,
      "price": 34.0
    }, {
      "index": 98,
      "price": 33.0
    }, {
      "index": 99,
      "price": 29.0
    }],
    "msg": "成功"
  }
  @State stateNum:number=0;
  @State mDataList: Array<MyData> = []
  @State  mSideMax:number = 0;

  aboutToAppear() {
    // this.mDataList = this.testData.data

    setInterval(() => {
      let randomIndex=CommonUtil.getRandom(0,100)
      let randomPrice=CommonUtil.getRandom(20,100)

      hilog.error(0,"",`randomIndex=${randomIndex} randomPrice=${randomPrice}`)
      // this.mSideMax=randomIndex
      if(this.mDataList.length<this.testData.data.length){
        this.mDataList.push(this.testData.data[this.mDataList.length])

        hilog.error(0,"",`mDataList=${this.mDataList.length}`)
      }else{
        clearInterval(0x123)
      }
      this.stateNum++;//改变数字为了触发刷新
    }, 1000,0x123);

  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      LinePathView({ stateNum:this.stateNum,mDataList:this.mDataList,mSideMin:0,mSideMax:this.mSideMax})

      Slider({
        value: this.mSideMax,
        min: 0,
        max: 100,
        style: SliderStyle.OutSet
      })
        .showTips(true)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.mSideMax = value
          console.info('value:' + value + 'mode:' + mode.toString())
          // this.mDataList[5].price=value
        })
    }
    .width('100%')
    .height('100%')
  }
}




 class MyData {
  index:number
  price:number
}

 class Point {
  x: number
  y: number

  constructor(x?: number , y?: number ) {
    this.x = x
    this.y = y
  }

  set(x: number, y: number){
    this.x = x
    this.y = y
  }

}


@Component
export struct LinePathView {
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  //把当前画布平分成 宽高 2x2 的格子
  private readonly X_NUM = 2;
  private readonly Y_NUM: number = 2;
  //边框颜色
  private borderColors: string = '#B8B8B8'
  //现价颜色
  private priceColors: string = '#E162E1'

  @State mMaxValue: number = Number.MIN_VALUE;
  private  mDataList: Array<MyData>=[]

  @Prop @Watch('invalidate')stateNum:number=0;

  //选择的起止
  @Prop mSideMin:number ;
  @Prop @Watch('invalidate') mSideMax:number;

  @State  mSideMinIndex:number = 20;
  @State  mSideMaxIndex:number = 60;

  readonly defaultCanvasHeight:number=120
  @State canvasHeight:number=this.defaultCanvasHeight
  onDraw: () => void = () => {
    let drawerWidth = this.context.width;
    let drawerHeight = this.context.height;

    this.drawBorder(drawerWidth,drawerHeight)
    this.drawNowPriceLine(drawerWidth,drawerHeight)
    this.drawSelectPath(drawerWidth,drawerHeight)
  }


  invalidate(){
    this.mSideMinIndex=this.mSideMin
    this.mSideMaxIndex=Number(this.mSideMax.toFixed(0))

    hilog.error(0,"",`invalidate=============》`)

    //不能执行绘制，这样会重复叠加绘制一遍，需要清空画布后执行。暂时网上也找不到清空画布的api
    // this.onDraw()

    //临时曲线救国方式: Canvas组件发生大小变化时会回调onReady，同时画布被清空
    if(this.canvasHeight>this.defaultCanvasHeight){
      this.canvasHeight-=0.01
    }else{
      this.canvasHeight+=0.01
    }

  }
  aboutToAppear() {
    // this.mDataList = LinePathView.testData.data
    this.mDataList.forEach(element => {
      this.mMaxValue = Math.max(this.mMaxValue, element.price);
    });
  }

  getUnitHeight(drawerHeight: number): number {
    let valueSum = this.mMaxValue;
    return valueSum != 0.0 ? drawerHeight / valueSum : 0.0;
  }

  getUnitWidth(drawerWidth: number): number {
    let valueSum = this.mDataList === null ? 0 : this.mDataList.length;
    return valueSum != 0.0 ? drawerWidth / valueSum : 0.0;
  }

  drawBorder(drawerWidth: number, drawerHeight: number) {

    hilog.error(0,"",`drawerWidth=${drawerWidth} drawerHeight=${drawerHeight}`)
    this.context.save()//为了不影响后面画布设置样式 先保存在还原
    this.context.lineWidth = 2
    this.context.strokeStyle = this.borderColors;
    this.context.strokeRect(0, 0, drawerWidth, drawerHeight)

    this.context.lineWidth = 1
    this.context.setLineDash([10, 20])
    //画2条横线
    this.context.fillStyle = this.borderColors
    let offsetY = drawerHeight / this.Y_NUM
    let startY = offsetY
    this.context.beginPath();
    for (var i = 1; i < this.Y_NUM; i++) {
      this.context.moveTo(0, startY);
      this.context.lineTo(drawerWidth, startY);
      startY += offsetY;
    }
    this.context.stroke();

    //画2条竖线
    let offsetX = drawerWidth / this.X_NUM
    let startX = offsetX
    this.context.beginPath();
    for (var i = 1; i < this.X_NUM; i++) {
      this.context.moveTo(startX, 0);
      this.context.lineTo(startX, drawerHeight);
      startX += offsetX;
    }
    this.context.stroke();
    // this.context.setLineDash(null)
    this.context.restore()//还原
  }

  drawNowPriceLine(drawerWidth: number, drawerHeight: number) {
    this.context.save()
    this.context.lineWidth = 1
    this.context.fillStyle = this.priceColors
    let unitHeight = this.getUnitHeight(drawerHeight)
    let itemWidth = this.getUnitWidth(drawerWidth)
    const point = new Point();
    let startX = 0;
    let minY = Number.MAX_VALUE;
    let size = this.mDataList.length
    //100条数据 x从0 开始画，画到最后一条数据的位置是99 距离右边框还差 一个 item 距离，。给每个itemWidth额外加上偏移量则刚好铺满表格宽度
    let offsetItem = itemWidth / size
    itemWidth += offsetItem;

    let shaderPath = new Path2D();//现价非闭合路径path
    for (let i = 0; i < size; i++) {
      const data = this.mDataList[i]
      let y = (this.mMaxValue - data.price) * unitHeight
      minY = Math.min(minY, y)
      //画现价线条
      if (i === 0) {
        point.set(0, y);
        this.context.beginPath();
        this.context.moveTo(point.x, point.y)
        shaderPath.moveTo(point.x, drawerHeight)
      } else {
        point.set(startX, y);
        this.context.lineTo(point.x, point.y)
        shaderPath.lineTo(point.x, point.y)
      }
     // Logger.warn("LinePathView",`i==${i}  ${JSON.stringify(point)} y==${y}}`)

      //补齐第一个，与最后一个 路径
      if (i == 0) {
        shaderPath.lineTo(startX, y);
      } else if (i === size - 1) {
        shaderPath.lineTo(point.x, drawerHeight);
      }

      startX += itemWidth;
    }
    this.context.strokeStyle = this.priceColors;
    this.context.stroke();

    //渐变样式填充
    var grad = this.context.createLinearGradient(drawerWidth/2,0, drawerWidth/2,drawerHeight)
    grad.addColorStop(0.0, '#B8B8B8')
    grad.addColorStop(1.0, '#1AB8B8B8')
    this.context.fillStyle = grad
    this.context.fill(shaderPath);

    this.context.restore()
  }

  drawSelectPath(drawerWidth: number, drawerHeight: number) {
    this.context.save()
    this.context.lineWidth = 1
    this.context.fillStyle = this.priceColors
    let unitHeight = this.getUnitHeight(drawerHeight)
    let itemWidth = this.getUnitWidth(drawerWidth)

    let startX = this.mSideMinIndex* itemWidth;
    let minY = Number.MAX_VALUE;
    let size = this.mSideMaxIndex
    //100条数据 x从0 开始画，画到最后一条数据的位置是99 距离右边框还差 一个 item 距离，。给每个itemWidth额外加上偏移量则刚好铺满表格宽度
    let offsetItem = itemWidth / size
    itemWidth += offsetItem;

    let shaderPath = new Path2D();//现价非闭合路径path
    for (let i = this.mSideMinIndex;  i < size; i++) {
      const data = this.mDataList[i]
      let y = (this.mMaxValue - data.price) * unitHeight
      minY = Math.min(minY, y)
      //画现价线条
      if (i === this.mSideMinIndex) {

        this.context.beginPath();
        shaderPath.moveTo(startX, drawerHeight)
      } else {
        shaderPath.lineTo(startX, y)
      }

      //补齐第一个，与最后一个 路径
      if (i == this.mSideMinIndex) {
        shaderPath.lineTo(startX, y);
      } else if (i === size - 1) {
        shaderPath.lineTo(startX, drawerHeight);
      }

      startX += itemWidth;
    }
    this.context.strokeStyle = this.priceColors;
    this.context.stroke();

    //渐变样式填充
    var grad = this.context.createLinearGradient(drawerWidth/2,0, drawerWidth/2,drawerHeight)
    grad.addColorStop(0.0, '#990097D4')
    grad.addColorStop(1.0, '#1a0097D4')
    this.context.fillStyle = grad
    this.context.fill(shaderPath);

    this.context.restore()
  }

  build() {
    Column() {
      Text(`select区间: ${this.mSideMinIndex}-${this.mSideMaxIndex}`)
      Row(){
        Canvas(this.context)
          .width('100%')
          .height('100%')
            // .backgroundColor('#dcdcdc')
          .onReady(this.onDraw)
      }.width('90%').height(this.canvasHeight)
    }.width('100%').padding({top:10})
  }


}




