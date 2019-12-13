package com.example.flutter_community

import android.util.Log
import com.alibaba.sdk.android.push.CommonCallback
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar


class AliasUtil : MethodChannel.MethodCallHandler {

    companion object {
        private const val TAG = "Alias"
    }

    var CHANNEL = "flutter_community/alias"

    private var channel: MethodChannel? = null

    fun registerWith(registrar: Registrar) {
        channel = MethodChannel(registrar.messenger(), CHANNEL)
        channel!!.setMethodCallHandler(AliasUtil())

    }

    /**
     * 添加别名
     */
    fun addAlias(userId: String) {

        PushServiceFactory.getCloudPushService().addAlias(userId, object : CommonCallback {
            override fun onSuccess(s: String) {
                Log.i(TAG, userId + " 订阅成功")
            }

            override fun onFailed(s: String, s1: String) {
                Log.i(TAG, userId + " 订阅失敗")
            }
        })
    }

    /**
     * 移除别名
     */
    fun removeAlias(userId: String) {
        PushServiceFactory.getCloudPushService().removeAlias(userId, object : CommonCallback {
            override fun onSuccess(s: String) {
                Log.i(TAG, userId + " 解绑成功")
            }

            override fun onFailed(s: String, s1: String) {
                Log.i(TAG, userId + " 解绑失敗")
            }
        })

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("addAlias")) {
            val text = call.argument<String>("text")
            if (text != null) {
                //调用AliasUtil中的方法
                result.success(addAlias(text))
            } else {
                result.error("UNAVAILABLE", "别名不能为空.", null)
            }
        } else if (call.method.equals("removeAlias")) {
            val text = call.argument<String>("text")
            if (text != null) {
                result.success(removeAlias(text))
            } else {
                result.error("UNAVAILABLE", "别名不能为空.", null)
            }
        } else {
            result.notImplemented()
        }
    }


}




