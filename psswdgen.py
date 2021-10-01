from notebook.auth import passwd
from notebook.auth.security import passwd_check
password = input("type password: ")
# password = input()
hashed_argon2 = passwd(password)
hashed_sha1 = passwd(password, 'sha1')
# print(hashed_argon2)
print(hashed_sha1)
# passwd_check(hashed_argon2, password)
passwd_check(hashed_sha1, password)