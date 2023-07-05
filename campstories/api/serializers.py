from rest_framework import serializers

from rest_framework import serializers

class LoginSerializer(serializers.Serializer):
    country_code = serializers.IntegerField()
    phone_number = serializers.IntegerField()
    password = serializers.CharField()

    def validate(self, attrs):
        country_code = attrs.get('country_code')
        phone_number = attrs.get('phone_number')
        password = attrs.get('password')

        # Validate that country_code and phone_number are numbers
        if not isinstance(country_code, int):
            raise serializers.ValidationError("Country code must be a number.")
        if not isinstance(phone_number, int):
            raise serializers.ValidationError("Phone number must be a number.")

        username = f"+{country_code}.{phone_number}"
        attrs['username'] = username
        return attrs
