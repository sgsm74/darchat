enum Method {
  livechatRegisterGuest("livechat:registerGuest"),
  livechatGetInitialData("livechat:getInitialData"),
  livechatSendOfflineMessage("livechat:sendOfflineMessage"),
  sendMessageLivechat("sendMessageLivechat"),
  streamRoomMessages("stream-room-messages");

  const Method(this.value);
  final String value;
}
