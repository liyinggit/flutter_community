package com.example.flutter_community

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    private var aliasUtil: AliasUtil = AliasUtil()
    private val CHANNEL = "flutter_community/alias"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        //第一种方式 直接调用方法的 flutter与原生交互
        aliasUtil.registerWith(registrarFor(aliasUtil.CHANNEL))

        //第二种方式 在这里调用 flutter与原生交互
//        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
//            // Note: this method is invoked on the main thread.
//            if (call.method == "addAlias") {
//                //这是传来的参数
//                val text = call.argument<String>("text")
//                if (text != null) {
//                    //调用AliasUtil中的方法
//                    result.success(aliasUtil.addAlias(text))
//                } else {
//                    result.error("UNAVAILABLE", "别名不能为空.", null)
//                }
//            } else if (call.method == "removeAlias") {
//                val text = call.argument<String>("text")
//                if (text != null) {
//                    result.success(aliasUtil.removeAlias(text))
//                } else {
//                    result.error("UNAVAILABLE", "别名不能为空.", null)
//                }
//            } else {
//                result.notImplemented()
//            }
//
//        }
    }

}
