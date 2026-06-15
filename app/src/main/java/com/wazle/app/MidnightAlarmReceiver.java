package com.wazle.app;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import androidx.core.app.NotificationCompat;

public class MidnightAlarmReceiver extends BroadcastReceiver {
    private static final String CHANNEL_ID = "wazle_midnight_channel";

    @Override
    public void onReceive(Context context, Intent intent) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "Wazle System Alerts",
                    NotificationManager.IMPORTANCE_HIGH
            );
            if (notificationManager != null) {
                notificationManager.createNotificationChannel(channel);
            }
        }

        // Intent to open the app when notification is clicked
        Intent openAppIntent = new Intent(context, MainActivity.class);
        PendingIntent pendingOpenIntent = PendingIntent.getActivity(
                context, 0, openAppIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );

        // Intent for the "Got it" action button
        Intent dismissIntent = new Intent(context, DismissReceiver.class);
        dismissIntent.putExtra("notification_id", 1001);
        PendingIntent pendingDismissIntent = PendingIntent.getBroadcast(
                context, 1, dismissIntent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );

        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, CHANNEL_ID)
                .setSmallIcon(android.R.drawable.ic_dialog_alert) // Fallback system icon
                .setContentTitle("Server Restart")
                .setContentText("Your Wazle server has been successfully restarted.")
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)
                .setContentIntent(pendingOpenIntent)
                .addAction(android.R.drawable.ic_menu_close_clear_cancel, "Got it", pendingDismissIntent);

        if (notificationManager != null) {
            notificationManager.notify(1001, builder.build());
        }
    }
}
