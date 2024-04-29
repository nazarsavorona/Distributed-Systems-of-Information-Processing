import socket
import threading
import struct
import protobuf.server.hello_pb2 as hello_pb2


class Server:
    def __init__(self, host='127.0.0.1', port=12345):
        self.host = host
        self.port = port
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    def recvall(self, conn, length):
        data = bytearray()
        while len(data) < length:
            packet = conn.recv(length - len(data))
            if not packet:
                return None  # Important to handle a disconnect or error
            data.extend(packet)
        return data

    def handle_client(self, conn):
        try:
            while True:
                raw_length = self.recvall(conn, 4)
                if raw_length is None:
                    break  # Handling disconnection or failure to receive length bytes
                message_length = struct.unpack('>I', raw_length)[0]

                data = self.recvall(conn, message_length)
                if data is None:
                    break  # Handling disconnection or incomplete message

                # Convert bytearray to bytes for parsing
                data_bytes = bytes(data)

                greeting = hello_pb2.Greeting()
                greeting.ParseFromString(data_bytes)  # Now using a bytes object
                print(f"Received: \"{greeting.name}\"")

                # Create a response
                response = hello_pb2.Response()
                response.message = f"Hello, {greeting.name}!"
                response_data = response.SerializeToString()
                response_length = struct.pack('>I', len(response_data))
                conn.sendall(response_length + response_data)  # Send length of response followed by response
                print(f"Sent: \"{response.message}\"")

                if greeting.name == "exit":
                    break
        finally:
            conn.close()

    def start(self):
        self.server_socket.bind((self.host, self.port))
        self.server_socket.listen(5)
        print("Server listening...")
        try:
            while True:
                conn, addr = self.server_socket.accept()
                print('Connected by', addr)
                threading.Thread(target=self.handle_client, args=(conn,)).start()
        finally:
            self.server_socket.close()


if __name__ == '__main__':
    server = Server()
    server.start()
