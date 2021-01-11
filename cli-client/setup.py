import os

from setuptools import setup, find_packages

def get_long_desc():
    with open("README.md", "r") as readme:
        desc = readme.read()

    return desc

def setup_package():
    setup(
        name='ev_group53',
        version='0.1.0',
        description='CLI Client for elon-charge API',
        long_description=get_long_desc(),
        url='https://github.com/fillmln/elon-charge',
        license='MIT',
        long_description_content_type='text/markdown',
        packages=find_packages(),
        install_requires=[],
        entry_points = {
            'console_scripts': [
                'ev_group53=ev_group53.__main__:main',
            ],
        },
        classifiers=[
            'License :: OSI Approved :: MIT License',
            'Programming Language :: Python :: 3'
        ],
        author = 'Elon Charge',
        author_email = 'elon@elon-charge.ev'
    )

if __name__ == '__main__':
    setup_package()
