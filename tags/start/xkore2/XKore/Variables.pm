package XKore::Variables;
use Exporter 'import';
use base qw(Exporter);
#our %EXPORT_TAGS = (
     @EXPORT_OK =qw($xConnectionStatus $currLocationPacket $tempMsg $tempIp $tempPort $programEnder $localServ $port $xkoreSock $clientFeed $socketOut $serverNumber $serverIp $serverPort $record $ghostPort $recordSocket $recordSock $recordPacket);#]
#     );
#our @EXPORT = {@EXPORT_TAGS{variables}};

our $socketOut; #the out going connection handle
our $serverNumber; # the server number TODO: parse username to get this value.
our $serverIp; #ipaddress of the server TODO put this in a file.. OR read from servers.txt
our $serverPort; #PORT of the server TODO same as above

our $record;
our $ghostPort;
our $recordSocket;
our $recordSock;
our $recordPacket;
our $clientFeed;
our $xkoreSock;
our $port; #Controler client's listener port
our $xConnectionStatus;
our $localServ;
our $tempIp;
our $tempPort;
our $tempMsg;
our $programEnder;
our $currLocationPacket;
1;
