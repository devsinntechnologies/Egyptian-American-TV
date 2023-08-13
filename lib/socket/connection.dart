import 'package:socket_io_client/socket_io_client.dart' as IO;


    connection() {
    IO.Socket socket = IO.io('http://54.196.245.7:5000');
    socket.onConnect((_) {
      print('connect');      
    });
    socket.on('video_links', (data){

      print(data);
            //  LinksModel urlData =  LinksModel.fromJson(data);
      //   urls = urlData;
      //   notifyListeners();
    });
    socket.onDisconnect((_) => print('disconnect'));
  }