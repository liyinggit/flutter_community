package com.example.flutter_community

import android.os.Bundle
import android.util.Log
import com.alibaba.sdk.android.push.CommonCallback
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.flutter_community.AliasUtil as AliasUtil


class MainActivity : FlutterActivity() {

    private var aliasUtil:AliasUtil = AliasUtil()
    private val CHANNEL = "flutter_community/alias"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "addAlias") {
                //这是传来的参数
                val text = call.argument<String>("text")
                if (text != null) {
                    //调用AliasUtil中的方法
                    result.success(aliasUtil.addAlias(text))
                } else {
                    result.error("UNAVAILABLE", "别名不能为空.", null)
                }
            } else if (call.method == "removeAlias") {
                val text = call.argument<String>("text")
                if (text != null) {
                    result.success(aliasUtil.removeAlias(text))
                } else {
                    result.error("UNAVAILABLE", "别名不能为空.", null)
                }
            } else {
                result.notImplemented()
            }

        }
    }

}
