# todoapp



## Getting Started

to run this project must be instaled python, flutter and dart

```
cd todoapi
```

and than run server with this command

```
python manage.py runserver
```

but before do it make sure you have migrate model django for your local computer
```
python manage.py makemigrations
python manage.py migrate
```

next is to run flutter

because rest api is in local, if you try on browser flutter its will dificult to handle cross so better try with android emulator or ios

before run it you must do command to generate file
```
flutter pub run build_runner build --delete-conflicting-outputs
```
then you can do flutter -run and use the app

quick video can be check on file overview.mp4
