from setuptools import find_packages, setup

setup(name='transfer-contacts',
      version='0.1.0',
      description="Helps extract notes from a certain contact database program.",
      author="Justin Harris",
      url='https://github.com/juharris/transfer-contacts',
      license="MIT",
      packages=find_packages(),
      install_requires=[
          'pandas',
      ]
      )
