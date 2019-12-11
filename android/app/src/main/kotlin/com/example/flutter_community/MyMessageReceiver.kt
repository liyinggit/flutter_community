package com.example.flutter_community

import android.content.Context
import android.util.Log
import com.alibaba.sdk.android.push.MessageReceiver
import com.alibaba.sdk.android.push.notification.CPushMessage


class MyMessageReceiver : MessageReceiver() {
    override fun onNotification(context: Context?, title: String, summary: String, extraMap: Map<String?, String?>) { // TODO 处理推送通知
        Log.e("MyMessageReceiver", "Receive notification, title: $title, summary: $summary, extraMap: $extraMap")
    }

    override fun onMessage(context: Context?, cPushMessage: CPushMessage) {
        Log.e("MyMessageReceiver", "onMessage, messageId: " + cPushMessage.messageId + ", title: " + cPushMessage.title + ", content:" + cPushMessage.content)
    }

    override fun onNotificationOpened(context: Context?, title: String, summary: String, extraMap: String) {
        Log.e("MyMessageReceiver", "onNotificationOpened, title: $title, summary: $summary, extraMap:$extraMap")
    }

    override fun onNotificationClickedWithNoAction(context: Context?, title: String, summary: String, extraMap: String) {
        Log.e("MyMessageReceiver", "onNotificationClickedWithNoAction, title: $title, summary: $summary, extraMap:$extraMap")
    }

    override fun onNotificationReceivedInApp(context: Context?, title: String, summary: String, extraMap: Map<String?, String?>, openType: Int, openActivity: String, openUrl: String) {
        Log.e("MyMessageReceiver", "onNotificationReceivedInApp, title: $title, summary: $summary, extraMap:$extraMap, openType:$openType, openActivity:$openActivity, openUrl:$openUrl")
    }

    override fun onNotificationRemoved(context: Context?, messageId: String?) {
        Log.e("MyMessageReceiver", "onNotificationRemoved")
    }

    companion object {
        // 消息接收部分的LOG_TAG
        const val REC_TAG = "receiver"
    }
}