
export class FunctionData {

  code: string = '';
  name: string = '';
  secondNavbars:Array<MFunction>;
}

export class MFunction{
  functionId: number;
  code: string = '';
  categoryId: number;
  categoryName: string = '';
  icon: string = '';
  subscript: string = '';
  link: string = '';
  permissions:string[];
  jumpType: number;
  adLink: string = '';
  title: string = '';
  loginType: number;

}

