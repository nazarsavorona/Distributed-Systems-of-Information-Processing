package encoding.protobuf.client.src.main.java.org.example;

import java.io.*;
import java.net.*;
import java.util.Scanner;

public class Client {
    private final String host;
    private final int port;
    private Socket socket;
    private OutputStream out;
    private DataInputStream in;

    public Client(String host, int port) {
        this.host = host;
        this.port = port;
    }

    public void connect() throws IOException {
        this.socket = new Socket(host, port);
        socket.setSoTimeout(5000);  // Set timeout to 5000 ms
        this.out = socket.getOutputStream();
        this.in = new DataInputStream(socket.getInputStream());
    }

    public void sendMessage(String name) throws IOException {
        Hello.Greeting greeting = Hello.Greeting.newBuilder().setName(name).build();
        byte[] data = greeting.toByteArray();
        out.write((data.length >> 24) & 0xFF);
        out.write((data.length >> 16) & 0xFF);
        out.write((data.length >> 8) & 0xFF);
        out.write((data.length) & 0xFF);
        out.write(data);
        out.flush();
        System.out.println("Sending: \"" + name + "\"");

        if (!name.equalsIgnoreCase("exit")) {
            try {
                int length = in.readInt();
                if (length > 0) {
                    byte[] responseBytes = new byte[length];
                    in.readFully(responseBytes);
                    Hello.Response response = Hello.Response.parseFrom(responseBytes);
                    System.out.println("Server says: " + response.getMessage());
                }
            } catch (SocketTimeoutException e) {
                System.out.println("Timeout waiting for the server response.");
            }
        }
    }

    public void disconnect() throws IOException {
        sendMessage("exit");  // Inform the server to close the connection
        in.close();
        out.close();
        socket.close();
    }

    public static void main(String[] args) throws IOException {
        Client client = new Client("127.0.0.1", 12345);
        client.connect();

        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your messages (type 'exit' to quit):");

        while (true) {
            System.out.print("Input: ");
            String message = scanner.nextLine();

            if (message.equalsIgnoreCase("exit")) {
                client.disconnect();
                break;
            }

            client.sendMessage(message);
        }

        scanner.close();
    }
}
