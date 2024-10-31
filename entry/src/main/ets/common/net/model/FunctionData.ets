
export class FunctionData {

  code: string = '';
  name: string = '';
  secondNavbars:Array<MFunction>=[];
}

export class MFunction{
  functionId: number=0;
  code: string = '';
  categoryId: number=0;
  categoryName: string = '';
  icon: string = '';
  subscript: string = '';
  link: string = '';
  permissions:string[]=[];
  jumpType: number=0;
  adLink: string = '';
  title: string = '';
  loginType: number=0;

}

