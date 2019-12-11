package com.example.flutter_community

import android.content.Context
import android.util.Log
import com.alibaba.sdk.android.push.CommonCallback
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory
import io.flutter.app.FlutterApplication


class MainApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        initCloudChannel(this)
    }

    /**
     * 初始化云推送通道
     * @param applicationContext
     */
    private fun initCloudChannel(applicationContext: Context) {
        PushServiceFactory.init(applicationContext)
        val pushService = PushServiceFactory.getCloudPushService()
        pushService.register(applicationContext, object : CommonCallback {
            override fun onSuccess(response: String) {
                Log.d(TAG, "init cloudchannel success")
                print("init cloudchannel success")
            }

            override fun onFailed(errorCode: String, errorMessage: String) {
                Log.d(TAG, "init cloudchannel failed -- errorcode:$errorCode -- errorMessage:$errorMessage")
                print("init cloudchannel failed")

            }
        })
    }

    companion object {
        private const val TAG = "Init"
    }
}