from sa_exception_handler.exceptions import CustomValidationError

if __name__ == '__main__':
    raise CustomValidationError({'message': 'Hello World!'}, code='hello')
