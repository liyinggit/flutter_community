package com.example.flutter_community

import android.content.Context
import android.util.Log
import com.alibaba.sdk.android.push.MessageReceiver
import com.alibaba.sdk.android.push.notification.CPushMessage


class MyMessageReceiver : MessageReceiver() {
    /**
     * 客户端接收到通知后，回调该方法。可获取到并处理通知相关的参数
     */
    override fun onNotification(context: Context?, title: String, summary: String, extraMap: Map<String?, String?>) { // TODO 处理推送通知

        Log.e("MyMessageReceiver", "Receive notification, title: $title, summary: $summary, extraMap: $extraMap")
    }

    /**
     * 用于接收服务端推送的消息。 消息不会弹窗，而是回调该方法。
     */
    override fun onMessage(context: Context?, cPushMessage: CPushMessage) {
        Log.e("MyMessageReceiver", "onMessage, messageId: " + cPushMessage.messageId + ", title: " + cPushMessage.title + ", content:" + cPushMessage.content)
    }

    /**
     * 打开通知时会回调该方法，通知打开上报由SDK自动完成。
     */
    override fun onNotificationOpened(context: Context?, title: String, summary: String, extraMap: String) {
        Log.e("MyMessageReceiver", "onNotificationOpened, title: $title, summary: $summary, extraMap:$extraMap")
    }

    /**
     * 无跳转逻辑通知打开回调
     */
    override fun onNotificationClickedWithNoAction(context: Context?, title: String, summary: String, extraMap: String) {
        Log.e("MyMessageReceiver", "onNotificationClickedWithNoAction, title: $title, summary: $summary, extraMap:$extraMap")
    }

    /**
     * 通知在应用内到达回调
     */
    override fun onNotificationReceivedInApp(context: Context?, title: String, summary: String, extraMap: Map<String?, String?>, openType: Int, openActivity: String, openUrl: String) {
        Log.e("MyMessageReceiver", "onNotificationReceivedInApp, title: $title, summary: $summary, extraMap:$extraMap, openType:$openType, openActivity:$openActivity, openUrl:$openUrl")
    }

    /**
     * 删除通知时回调该方法，通知删除上报由SDK自动完成。
     */
    override fun onNotificationRemoved(context: Context?, messageId: String?) {
        Log.e("MyMessageReceiver", "onNotificationRemoved")
    }

    companion object {
        // 消息接收部分的LOG_TAG
        const val REC_TAG = "receiver"
    }
}