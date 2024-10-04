import base64


def encode(path: str):
    with open(path, 'rb') as file:
        s = base64.urlsafe_b64encode(file.read())
        file.close()
    return s
