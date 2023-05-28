============================
Robot Framework Mark85 Tests
============================

These tests were developed for the Robot eXperience BOOTCAMP, taught by Fernando Papito on the Hotmart platform.

The development was done on Windows 10, using Python 3.11.0 and Robot Framework with Browser library.

To delete the user from the database I am using robot-mongodb-library 0.0.5.

How to Run
==========
#. Create a Python VENV. ::

    $ python -m venv ./venv

#. Activate venv. ::

    $ ./venv/Scripts/activate.ps1

#. Upgrade PIP. ::

    $ python -m pip install --upgrade pip

#. Install requirements.txt. ::

    $ pip install -r requirements.txt

Tests Coverage
==============

These are the tests that we have developed until now.

Sign Up
-------
#. New User
#. User Already Exists
#. Name Field Empty
#. Email Field Empty
#. Password Field Empty
#. All Fields Empty


Login
-----
#. Login OK
#. Email Field Empty
#. Password Field Empty
#. All Fields Empty

Author
======
Ivens Souza