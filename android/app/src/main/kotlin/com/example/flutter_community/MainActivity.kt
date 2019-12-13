package com.example.flutter_community

import android.os.Bundle
import android.util.Log
import com.alibaba.sdk.android.push.CommonCallback
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    companion object {
        private const val TAG = "Alias"
    }

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
                    result.success(addAlias(text))
                } else {
                    result.error("UNAVAILABLE", "别名不能为空.", null)
                }
            } else if (call.method == "removeAlias") {
                val text = call.argument<String>("text")
                if (text != null) {
                    result.success(addAlias(text))
                } else {
                    result.error("UNAVAILABLE", "别名不能为空.", null)
                }
            } else {
                result.notImplemented()
            }

        }
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

}
