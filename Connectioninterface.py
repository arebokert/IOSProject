import os
import httplib
import socket
import threading
import SocketServer
import sys

def pingServer(address):
    result = os.system("ping -n 1 " + address)
    if(result == 0):
        print "Ping succeeded."
        return "0";
    else:
        print "Ping did not succeed."
        return "1"

def checkHTTP(address):
    try:
        conn = httplib.HTTPConnection(address)
        conn.request("HEAD", "/")
        statusCode = conn.getresponse().status
        print ("HTTP status code was ",statusCode);
        if((statusCode == 200)
        or (statusCode == 201)
        or (statusCode == 202)
        or (statusCode == 203)
        or (statusCode == 204)
        or (statusCode == 205)
        or (statusCode == 206)):
            return "0"
        else:
            return "1"
    except StandardError:
        return "1"

#Recives the input from the client and processes it according to what the 2 or 4 first characters are.
class service(SocketServer.BaseRequestHandler):

    def handle(self):
        data = self.request.recv(1024)
        if data[:2] == 'PI':
            print ("Ping request received on ",data[2:])
            self.request.send(pingServer(data[2:]))
        elif data[:2] == 'HT':
            print ("HTTP request received on ",data[2:])
            self.request.send(checkHTTP(data[2:]))
        else:
            print 'Incorrect operation.'
        self.request.close()

class ThreadedTCPServer(SocketServer.ThreadingMixIn, SocketServer.TCPServer):
    pass
	
if __name__ == "__main__":


    server = ThreadedTCPServer(('',24070), service)
    server.serve_forever()