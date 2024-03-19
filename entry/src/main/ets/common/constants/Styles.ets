
// 定义在全局的@Styles封装的样式

@Styles function paddingHorizontal(value:string | number | Resource) {
  .padding({left:value,right:value})
}

@Styles function paddingVertical(value:string | number | Resource) {
  .padding({top:value,bottom:value})
}

@Component
struct Styles{
  build(){

  }
}