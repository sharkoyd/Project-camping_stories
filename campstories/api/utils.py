import os
from twilio.rest import Client

def send_sms(phone_number, content):
    account_sid = "ACf3e5e6366e9bb9a563cb50b5ba9c0bf3"
    auth_token = "3e11f1b4ccc295ef8fb2fe5f140a8509"
    client = Client(account_sid, auth_token)

    message = client.messages.create(
        body=content,
        from_='+15812033514',
        to=phone_number
    )
    print(message)
