package com.example.flutter_community

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.Color
import android.os.Build
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
        // 创建notificaiton channel
        this.createNotificationChannel()

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

    /**
     * android8.0及以上需要配置，否则收不到通知
     * 因为暂时无后台，所以在这里添加，到时候可以在后台创建
     * https://help.aliyun.com/knowledge_detail/67398.html
     */
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val mNotificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            // 通知渠道的id
            val id = "1"
            // 用户可以看到的通知渠道的名字.
            val name: CharSequence = "notification channel"
            // 用户可以看到的通知渠道的描述
            val description = "notification description"
            val importance: Int = NotificationManager.IMPORTANCE_HIGH
            val mChannel = NotificationChannel(id, name, importance)
            // 配置通知渠道的属性
            mChannel.setDescription(description)
            // 设置通知出现时的闪灯（如果 android 设备支持的话）
            mChannel.enableLights(true)
            mChannel.setLightColor(Color.RED)
            // 设置通知出现时的震动（如果 android 设备支持的话）
            mChannel.enableVibration(true)
            mChannel.setVibrationPattern(longArrayOf(100, 200, 300, 400, 500, 400, 300, 200, 400))
            //最后在notificationmanager中创建该通知渠道
            mNotificationManager.createNotificationChannel(mChannel)
        }
    }

    companion object {
        private const val TAG = "Init"
    }
}