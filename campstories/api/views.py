from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response

from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.authentication import JWTAuthentication



from .serializers import LoginSerializer
from django.contrib.auth import authenticate
from django.contrib.auth import login
from .models import PendingCode

from django.contrib.auth.models import User

from rest_framework import status


from rest_framework.permissions import IsAuthenticated
from .models import UserProfile






@api_view(['GET'])
def Home(request):
    token = request.query_params.get('token')

    
    try:
        # Manually authenticate the user using the token
        authentication = JWTAuthentication()
        validated_token = authentication.get_validated_token(token)
        print('aaaaaaaaaa')
        user = authentication.get_user(validated_token)
        # Assign the authenticated user to request.user
        request.user = user
    except:
        return Response({'message': 'Invalid token'}, status=401)

    
    return Response({'user': request.user.username ,'message':'valid'}, status=200)

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

        # Send the pending code to the user (sms, email, etc.)
        #for now il just print it
        print(pending_code.code)

        return Response({'message': 'Valid'})
    else:
        return Response({'message': 'Invalid'}, status=401)



@api_view(['POST'])
def VerifyCodeView(request):
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

    # Check if a user with the provided username already exists
    if User.objects.filter(username=username).exists():
        return Response({'message': 'user already exists'}, status=status.HTTP_409_CONFLICT)

    # Create the user
    user = User.objects.create_user(username=username, password=password , first_name=first_name , last_name=last_name)


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

        try:
            user = request.user

            # Extract the necessary information from the request data
            name = request.data.get('name')
            print('ddddddddddddddddddddddddddd')
            gender = request.data.get('gender')
            age = request.data.get('age')

            # Create a profile for the authenticated user
            profile = UserProfile(user=user, name=name, gender=gender, age=age)
            profile.save()

            # Return a success response
            return Response({'message': 'Profile created successfully'})

        except:
            return Response({'message': 'Invalid params'}, status=401)






    except:
        return Response({'message': 'Invalid token'}, status=401)





    