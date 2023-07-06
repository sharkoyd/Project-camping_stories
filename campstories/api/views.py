from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response

from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.authentication import JWTAuthentication

from django.shortcuts import get_object_or_404
import requests
import json


from .serializers import LoginSerializer
from django.contrib.auth import authenticate
from django.contrib.auth import login
from .models import PendingCode,UserProfile,Story

from django.contrib.auth.models import User

from rest_framework import status


import os,openai
from dotenv import load_dotenv


from rest_framework.permissions import IsAuthenticated
from .models import UserProfile

from django.core import serializers
from django.http import JsonResponse

from .serializers import StorySerializer
from django.db.models import F, Func

import random


import re

from . import utils

import boto3
from botocore.exceptions import BotoCoreError, NoCredentialsError


from django.core.files.base import ContentFile



load_dotenv()
api_key = os.getenv('OPENAI_KEY',None)
openai.api_key = api_key


import aiohttp
async def make_api_request(url, params=None):
    async with aiohttp.ClientSession() as session:
        async with session.get(url, params=params) as response:
            return await response.json()



@api_view(['GET'])
def Home(request):
    # Get the token from the query parameters
    token = request.query_params.get('token')
    print(token)

    try:
        # Manually authenticate the user using the token
        authentication = JWTAuthentication()
        validated_token = authentication.get_validated_token(token)
        user = authentication.get_user(validated_token)
        # Assign the authenticated user to request.user
        request.user = user
        print(user)
    except:
        return Response({'message': 'Invalid token'}, status=401)

    # Get the profile ID from the request
    profile_id = request.query_params.get('profile_id')

    # Get the user's profile
    # also performs as a  check for if the profile does not belong to the logged-in user
    profile = get_object_or_404(UserProfile, id=profile_id, user=user)



    # Get the age range for story filtering
    age_range_min = profile.age - 3
    age_range_max = profile.age + 3

    number_of_stories_to_fetch = 2


    # Fetch random stories from the database within the age range
    one_minute_stories = Story.objects.filter(age_range__gte=age_range_min, age_range__lte=age_range_max, length_minutes=1).order_by('?')[:number_of_stories_to_fetch]
    three_minute_stories = Story.objects.filter(age_range__gte=age_range_min, age_range__lte=age_range_max, length_minutes=3).order_by('?')[:number_of_stories_to_fetch]
    five_minute_stories = Story.objects.filter(age_range__gte=age_range_min, age_range__lte=age_range_max, length_minutes=5).order_by('?')[:number_of_stories_to_fetch]
    ten_minute_stories = Story.objects.filter(age_range__gte=age_range_min, age_range__lte=age_range_max, length_minutes=10).order_by('?')[:number_of_stories_to_fetch]

    # Serialize the stories 
    one_minute_serializer = StorySerializer(one_minute_stories, many=True)
    three_minute_serializer = StorySerializer(three_minute_stories, many=True)
    five_minute_serializer = StorySerializer(five_minute_stories, many=True)
    ten_minute_serializer = StorySerializer(ten_minute_stories, many=True)

    # Return the serialized stories
    return Response({
        'one_minute_stories': one_minute_serializer.data,
        'three_minute_stories': three_minute_serializer.data,
        'five_minute_stories': five_minute_serializer.data
    })





@api_view(['POST'])
def CustomStory(request):



    # Get the token from the query parameters
    token = request.query_params.get('token')

    try:
        # Manually authenticate the user using the token
        authentication = JWTAuthentication()
        validated_token = authentication.get_validated_token(token)
        user = authentication.get_user(validated_token)
        # Assign the authenticated user to request.user
        request.user = user
    except:
        return Response({'message': 'Invalid token'}, status=401)



    # Get the profile ID from the request
    profile_id = request.query_params.get('profile_id')

    # Get the user's profile
    profile = get_object_or_404(UserProfile, id=profile_id, user=user)

    if profile.user != request.user:
        return Response({'message': 'Profile does not belong to the logged-in user'}, status=403)

    # Extract the necessary information from the request data
    involving = request.data.get('involving')
    age_range = request.data.get('age_range')
    duration = request.data.get('duration')
    if age_range =='0':
        age_range = profile.age


    #prompt customization

    if int(age_range) < 5:
        prompt = f"generate an easy {duration} minutes story that involves {involving} using repetitive phrases or rhymes,Basic vocabulary and simple sentence structures,Clear and straightforward plotlines, present it in a json format with the keys : title,content,gender(M,F,A(for any gender)),genre (oneword)" 
    if int(age_range) >= 5 and int(age_range) < 8:
        prompt = f"generate a {duration} minutes story that involves {involving} using multiple characters, subplots Exploration of emotions, friendships, and problem-solving, present it in a json format with the keys : title,content,gender(M,F,A(for any gender)),genre (oneword)" 
    if int(age_range) >= 8:
        prompt = f"generate a complex {duration} minutes story that involves {involving} using storylines and character development,Advanced vocabulary and language usage, present it in a json format with the keys : title,content,gender(M,F,A(for any gender)),genre (oneword)" 

    
    response=openai.Completion.create(
        model="text-davinci-003",
        prompt= prompt,
        temperature= 0 ,
        max_tokens= 4000,
        top_p= 1,
        frequency_penalty= 0,
        presence_penalty= 0,
        stop= ["&"],
    
    )
    generated_text = response["choices"][0]["text"]

    # Remove \n characters
    generated_text = generated_text.replace('\n', '')

    # Convert to JSON format
    generated_text = json.loads(generated_text)

    # Add age_range field
    generated_text["age_range"] = age_range

    try:
        polly_client = boto3.client('polly')
        # Set the SSML input with a slow speech rate
        ssml = f"<speak><prosody rate='slow'>{generated_text['content']}</prosody></speak>"
        response = polly_client.synthesize_speech(TextType='ssml',Text=ssml, OutputFormat='mp3', VoiceId='Joanna')
        audio_stream = response['AudioStream'].read()

        # Create the ContentFile from the audio stream
        audio_file = ContentFile(audio_stream)

        # Create the Story object
        story = Story(
            title=generated_text['title'],
            content=generated_text['content'],
            age_range=generated_text['age_range'],
            gender=generated_text['gender'],
            story_type=generated_text['genre'].lower(),
            length_minutes=duration,
            validated=False
        )

        # Save the story object to generate an ID
        story.save()

        # Specify the file name as the ID of the story
        file_name = str(story.id) + '.mp3'  # Assuming the ID field of the Story model is 'id'

        # Assign the audio file to the story's audio_file field
        story.audio_file.save(file_name, audio_file)
        story.save()

        print("Story created successfully")

    except (BotoCoreError, NoCredentialsError) as e:
        # Handle any exceptions that may occur
        print("Error:", str(e))

    # Create the response data
    response_data = {
        'story': generated_text['content'],
        'title': generated_text['title'],
        'audio_file': story.audio_file.url  # Get the URL of the saved audio file
    }



    # Return the generated story as the response
    return Response(response_data)








@api_view(['GET'])
def Profiles(request):
    token = request.query_params.get('token')
    try:
        # Manually authenticate the user using the token
        authentication = JWTAuthentication()
        validated_token = authentication.get_validated_token(token)
        user = authentication.get_user(validated_token)
        # Assign the authenticated user to request.user
        request.user = user
    except:
        return Response({'message': 'Invalid token'}, status=401)

    # Check if the user has associated profiles
    profiles = UserProfile.objects.filter(user=user)
    if profiles.exists():
        # Serialize the profiles to JSON
        serialized_profiles = serializers.serialize('json', profiles)
        return JsonResponse({'profiles': serialized_profiles}, status=200)
    else:
        return JsonResponse({'profiles': None}, status=200)

@api_view(['POST'])
def LoginWithPhoneNum(request):
    country_code = request.data.get('country_code')
    phone_number = request.data.get('phone_number')
    password = request.data.get('password')

    if not phone_number or not password:
        return Response({'error': 'Invalid request data'}, status=400)

    username = f"+{country_code}.{phone_number}"

    user = authenticate(request, username=username, password=password)

    if user is not None:
        # User credentials are valid, set the pending code
        try:
            pending_code = PendingCode.objects.get(user=user)
        except PendingCode.DoesNotExist:
            pending_code = PendingCode.objects.create(user=user)
        pending_code.code = str(user.code)  # Set the code from user.code
        pending_code.save()  # Save the pending code

        utils.send_sms(phone_number, f"Your code is {pending_code.code}")
        print(pending_code.code)

        return Response({'message': 'Valid'})
    else:
        return Response({'message': 'Invalid'}, status=401)




@api_view(['POST'])
def PhoneNumConfirm(request):
    country_code = request.data.get('country_code')
    phone_number = request.data.get('phone_number')



    username = f"+{country_code}.{phone_number}"

    if User.objects.filter(username=username).exists():
        return Response({'message': 'Invalid'}, status=409)
    else:
        user = User.objects.create_user(username=username, password='999999' ,is_active=False)
        try:
            pending_code = PendingCode.objects.get(user=user)
        except PendingCode.DoesNotExist:
            pending_code = PendingCode.objects.create(user=user)
        pending_code.code = str(user.code)  # Set the code from user.code
        pending_code.save()  # Save the pending code
        phn=f"+{country_code}{phone_number}"
        utils.send_sms(phn, f"Your code is {pending_code.code}")
    return Response({'message': 'Valid'},status=200)


@api_view(['POST'])
def VerifySignUpCode(request):
    code = request.data.get('verification_code')

    if not code:
        return Response({'message': 'Invalid'}, status=400)

    try:
        pending_code = PendingCode.objects.get(code=code)
        user = pending_code.user
    except PendingCode.DoesNotExist:
        return Response({'message': 'Invalid'}, status=401)

    if code == pending_code.code:
        # Code is valid, generate JWT tokens for the user
        refresh = RefreshToken.for_user(user)
        access_token = refresh.access_token

        # Delete the pending code
        pending_code.delete()
        #call the save method to generate a new code
        user.code.save()
        # Return the JWT tokens in the response
        return Response({'message': 'Valid'}, status=200)
        
    else:
        return Response({'message': 'Invalid'}, status=401)
    
    

@api_view(['POST'])
def VerifyLoginCode(request):
    code = request.data.get('code')

    if not code:
        return Response({'message': 'Invalid'}, status=400)

    try:
        pending_code = PendingCode.objects.get(code=code)
        user = pending_code.user
    except PendingCode.DoesNotExist:
        return Response({'message': 'Invalid'}, status=401)

    if code == pending_code.code:
        # Code is valid, generate JWT tokens for the user
        refresh = RefreshToken.for_user(user)
        access_token = refresh.access_token

        # Delete the pending code
        pending_code.delete()
        #call the save method to generate a new code
        user.code.save()
        # Return the JWT tokens in the response
        return Response({
            'message': 'Valid',
            'refresh': str(refresh),
            'access': str(access_token),
        })
        
    else:
        return Response({'message': 'Invalid'}, status=401)



@api_view(['POST'])
def RegisterWithPhoneNum(request):

    phone_number = request.data.get('phone_number')
    country_code = request.data.get('country_code')
    password = request.data.get('password')
    first_name = request.data.get('first_name')
    last_name = request.data.get('last_name')


    username = f"+{country_code}.{phone_number}"

    if User.objects.filter(username=username).exists():
        #update the user
        user = User.objects.get(username=username)
        user.first_name = first_name
        user.last_name = last_name
        user.set_password(password)
        user.is_active = True
        user.save()

    return Response({'message': 'success'}, status=status.HTTP_201_CREATED)





@api_view(['POST'])
def CreateProfile(request):
    token = request.query_params.get('token')
    print(token)

    try:
        # Manually authenticate the user using the token
        authentication = JWTAuthentication()
        validated_token = authentication.get_validated_token(token)
        user = authentication.get_user(validated_token)
        # Assign the authenticated user to request.user
        request.user = user

    except:
        return Response({'message': 'Invalid token'}, status=401)

    try:
        user = request.user
        # Extract the necessary information from the request data
        name = request.data.get('name')
        gender = request.data.get('gender')
        age = request.data.get('age')
        profilepic = request.data.get('profilepic')
        interests = request.data.get('interests')

        # Create a profile for the authenticated user
        profile = UserProfile(user=user, name=name, gender=gender, age=age, profilepic=profilepic)
        profile.save()

        # Set the interests in the profile JSON data
        profile_data = profile.data
        profile_data['interests'] = {interest: 1 for interest in interests}
        profile.data = profile_data
        profile.save()

        # Return a success response
        return Response({'message': 'Profile created successfully'})
    except:
        return Response({'message': 'Invalid params'}, status=401)


    





#use the code below to fast add json  containing information about the new stories you want to add manually the database  use this format below  -------------------------------------------------------------
# [
#   {
#     "title": "",
#     "content": "",
#     "age_range": 0,
#     "gender": "Any",
#     "story_type": "fantasy",
#     "picture": "path/to/story_pictures/magic_crayons.jpg",
#     "length_minutes": 1
#   },]


# def create_stories_from_json(json_data):
#     stories = json.loads(json_data)

#     for story_data in stories:
#         story = Story(
#             title=story_data['title'],
#             content=story_data['content'],
#             age_range=story_data['age_range'],
#             gender=story_data['gender'],
#             story_type=story_data['story_type'],
#             length_minutes=story_data['length_minutes']
#         )
#         story.save()

# # Example usage
# json_data = '''





# '''

# create_stories_from_json(json_data)