import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  //validate password length and is filled
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
  ]);

  //validate name length and is filled
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
    MinLengthValidator(4, errorText: 'Name must be at least 4 digits long'),
  ]);

  //validate email is filled and format
  final emailValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: 'Not a correct Email format')
    ],
  );

  //validate phone format and is filled
  //accepted phone formats +2519000000, 0900000000, '-,. and space' are acceptable in between 3 digits
  final phoneValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Phone Number is required'),
      PatternValidator(
        r'(^(\+251|0)\-?\s?(\9)(\d{8}|(\d{2}[\s.-]?\d{3}[\s.-]?\d{3}))$)',
        errorText: 'Phone Number must have at least one special character',
      )
    ],
  );
}
