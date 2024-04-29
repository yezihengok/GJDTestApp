export class UPServiceConfig{

  //首页策略相关功能code
  static readonly SY_CL_NSXJGC: string = 'gjd_sy_cl_nsxjgc';
  static readonly SY_CL_BXFC: string = 'gjd_sy_cl_bxfc';
  static readonly SY_CL_CDXH: string = 'gjd_sy_cl_cdxh';
  static readonly SY_CL_LTQB: string = 'gjd_sy_cl_ltqb';
  static readonly SY_CL_QSZS: string = 'gjd_sy_cl_qszs';
  static readonly SY_CL_ZYDGCL: string = 'gjd_sy_cl_zydgcl';
  static readonly SY_CL_PEGCL: string = 'gjd_sy_cl_pegcl';

  static readonly test_banner_data: string = `{
    "code": 200,
    "msg": "操作成功",
    "data": [
        {
            "materialId": 1,
            "interval": 4,
            "materialCode": "1000",
            "materialName": "首页广告测试",
            "materialType": 1,
            "materialImg": "http://file.gjdapp.wlstock.com/operate-upload/2024/03/01/637f0862833cf1669269602_20240301173242A069.jpg",
            "materialText": "",
            "materialIcon": null,
            "livePlanId": null,
            "liveVideo": null,
            "linkType": 2,
            "linkUrl": "https://data.10jqka.com.cn/"
        },
        {
            "materialId": 3,
            "interval": 4,
            "materialCode": "cesi3",
            "materialName": "测试3",
            "materialType": 1,
            "materialImg": "http://file.gjddev.wlstock.com/operate-upload/2024/04/29/%E4%BD%8D%E5%9B%BE_20240429150833A003.png",
            "materialText": "",
            "materialIcon": null,
            "livePlanId": null,
            "liveVideo": null,
            "linkType": 2,
            "linkUrl": "https://pilgrimoutpost.techlandgg.com/dashboard"
        }
    ]
}`;

}