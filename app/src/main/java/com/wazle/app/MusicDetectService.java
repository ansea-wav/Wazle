package com.wazle.app;

import android.content.Intent;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.MediaSessionManager;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.content.Context;
import android.content.ComponentName;
import java.util.List;
import android.util.Log;

public class MusicDetectService extends NotificationListenerService {

    private String lastDetectedTitle = "";

    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        detectMusic();
    }

    @Override
    public void onNotificationRemoved(StatusBarNotification sbn) {
        detectMusic();
    }

    private void detectMusic() {
        try {
            MediaSessionManager mediaSessionManager = (MediaSessionManager) getSystemService(Context.MEDIA_SESSION_SERVICE);
            ComponentName componentName = new ComponentName(this, MusicDetectService.class);
            
            if (mediaSessionManager != null) {
                List<MediaController> controllers = mediaSessionManager.getActiveSessions(componentName);

                String currentTitle = "";
                
                for (MediaController controller : controllers) {
                    MediaMetadata metadata = controller.getMetadata();
                    if (metadata != null) {
                        currentTitle = metadata.getString(MediaMetadata.METADATA_KEY_TITLE);
                        break; // Just grab the first active media session
                    }
                }

                if (currentTitle != null && !currentTitle.isEmpty() && !currentTitle.equals(lastDetectedTitle)) {
                    lastDetectedTitle = currentTitle;
                    Intent broadcastIntent = new Intent("com.wazle.app.MUSIC_UPDATE");
                    broadcastIntent.putExtra("title", currentTitle);
                    sendBroadcast(broadcastIntent);
                }
            }
        } catch (SecurityException e) {
            // Permission not granted
            Log.e("WazleMusic", "Notification Access not granted", e);
        } catch (Exception e) {
            Log.e("WazleMusic", "Error detecting music", e);
        }
    }
}
