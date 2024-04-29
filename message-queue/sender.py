import pika


def send():
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(host='localhost',
                                  credentials=pika.PlainCredentials('guest', 'guest'))
    )
    channel = connection.channel()

    channel.queue_declare(queue='hello')

    while True:
        message = input("Enter your message (type 'exit' to stop): ")
        if message.lower() == 'exit':
            break

        times = input("Enter the number of times to send the message (default is 1): ")
        times = int(times) if times.isdigit() else 1

        for _ in range(times):
            channel.basic_publish(exchange='', routing_key='hello', body=message)
            print(" [x] Sent %r" % message)

    connection.close()


if __name__ == '__main__':
    send()
