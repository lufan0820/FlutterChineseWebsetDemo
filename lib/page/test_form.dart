import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

/// * Create by lf 2019-12-19 16:17
/// TODO 表单
/// Form
/// 对所有子FormField/TextFormField 进行统一管理
/// 详见: https://book.flutterchina.club/chapter3/input_and_form.html

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormTestRoute();
}

class _FormTestRoute extends State<FormTestRoute> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("表单"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, // 设置GlobalKey，用于后面获取FormState
          autovalidate: true, // 开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  icon: Icon(Icons.person),
                ),
                // 校验用户名(户名不能为空，如果为空则提示“用户名不能为空”)
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                // 校验密码
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // 在这里不能通过此方式获取FormState，context不对
                          // Form.of(context);
                          /**
                           * TODO
                           * 正确的做法是通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数
                           *  Expanded(
                           *  // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                           *  child:Builder(builder: (context){
                           *   return RaisedButton(
                           *  ...
                           *  onPressed: () {
                           *   //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                           *  if(Form.of(context).validate()){
                           *   //验证通过提交数据
                           *  }
                           *  },
                           * );
                           * })
                           *  )
                           */
                          // 通过_formKey.currentState 获取FormState后
                          // 调用validate()方法校验用户名和密码是否合法，
                          // 校验通过后再提交数据
                          if ((_formKey.currentState as FormState).validate()) {
                            // 提交数据
                            print(
                                "用户名 : ${_userNameController.text} \n 密码 : ${_passwordController.text}");
                            showToast(
                                "用户名 : ${_userNameController.text} \n 密码 : ${_passwordController.text}");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  child: Text("清空所有输入框"),
                  onPressed: () {
                    // 清空所有TextFormField的内容
                    (_formKey.currentState as FormState).reset();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
