

export class TabInfoModel {
  index: number = 0;
  img: Resource = $r('app.media.ic_home_normal');
  selectImg: Resource = $r('app.media.ic_home_selected');
  title:  Resource|string = $r('app.string.index_home');
}

export { homeTabInfo }
const homeTabInfo: TabInfoModel[] = [
  {
    index: 0,
    img: $r('app.media.ic_home_normal'),
    selectImg: $r('app.media.ic_home_selected'),
    title: $r('app.string.index_home')
  },
  {
    index: 1,
    img: $r('app.media.ic_dq_normal'),
    selectImg: $r('app.media.ic_dq_selected'),
    title: $r('app.string.index_dq')
  },
  {
    index: 2,
    img: $r('app.media.ic_jc_normal'),
    selectImg: $r('app.media.ic_jc_selected'),
    title: $r('app.string.index_jc')
  },
  {
    index: 3,
    img: $r('app.media.ic_hq_normal'),
    selectImg: $r('app.media.ic_hq_selected'),
    title: $r('app.string.index_hq')
  },
  {
    index: 4,
    img: $r('app.media.ic_zx_normal'),
    selectImg: $r('app.media.ic_zx_selected'),
    title: $r('app.string.index_zx')
  }
]



export class TabModel {
  index: number = 0;
  title:  Resource|string = 'tab';
}
export { indexTabInfo }
 const indexTabInfo: TabModel[] = [
  {
    index: 0,
    title: '推荐'
  },
  {
    index: 1,
    title: '关注'
  },
  {
    index: 2,
    title: '策略'
  },
  {
    index: 3,
    title: '动态'
  }
]

