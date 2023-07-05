from django.urls import path
from api import views
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    path('', views.Home, name='home'),
    path('LoginWithPhoneNum/', views.LoginWithPhoneNum, name='login'),
    path('VerifyCode/', views.VerifyCodeView, name='verify'),
    path('RegisterWithPhoneNum/', views.RegisterWithPhoneNum, name='register'),
    path('CreateProfile/', views.CreateProfile, name='create_profile'),
    # path('users/', views.UserList.as_view()),
    # path('users/<int:pk>/', views.UserDetail.as_view()),
    # path('stories/<int:pk>/', views.StoryDetail.as_view()),
    # path('stories/', views.StoryList.as_view()),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]