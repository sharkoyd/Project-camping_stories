# Download the helper library from https://www.twilio.com/docs/python/install
import os
from twilio.rest import Client

# Set environment variables for your credentials
# Read more at http://twil.io/secure
account_sid = "ACf3e5e6366e9bb9a563cb50b5ba9c0bf3"
auth_token = "3e11f1b4ccc295ef8fb2fe5f140a8509"


client = Client(account_sid, auth_token)

def send_sms(phone_number):
    message = client.messages.create(
        body='+15812033514',
        from_='+12058513300',
        to=phone_number
    )

    print(message.sid)  