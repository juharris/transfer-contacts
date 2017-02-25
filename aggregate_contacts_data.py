import io
import os

import pandas as pd

contacts_filename = 'contacts.csv'
notes_folder = os.path.join(os.getenv('USERPROFILE', os.path.expanduser('~')), 'contact_notes')

os.makedirs(notes_folder, exist_ok=True)

data = pd.read_csv(contacts_filename,
                   na_values=[], keep_default_na=False,
                   index_col=False,
                   # The exporter only exported to latin1.
                   encoding='latin1')

all_notes = []

for i, row in enumerate(data.itertuples()):
    # Add notes about contact.
    path = os.path.join(notes_folder, f'{i + 1}')
    if os.path.exists(path):
        with io.open(path, encoding='utf8') as f:
            notes = f.read()
    else:
        notes = ""

    all_notes.append(notes)

data['Notes'] = all_notes

data.rename(columns={
    "Address": "Address 1 - Street",
    "Address 2": "Address 1 - Extended Address",
    "Birthday": "Birthday",
    "Car Phone": "Phone 2 - Value",
    "City": "Address 1 - City",
    "Company": "Organization 1 - Name",
    "Contact": "Nickname",
    "Country": "Address 1 - Country",
    "Department": "Organization 1 - Department",
    "Fax": "Phone 3 - Value",
    "First Name": "Given Name",
    "Hobbies": "Hobby",
    "ID/Status": "Group Membership",
    "Industry": "Organization 1 - Type",
    "Notes": "Notes",
    "Phone": "Phone 1 - Value",
    "State": "Address 1 - Region",
    "Surname": "Family Name",
    "Title": "Organization 1 - Job Description",
    "Web Site": "Website 1 - Type",
    "ZIP Code": "Address 1 - Postal Code",
    "E-mail Login": "E-mail 1 - Value",
}, copy=False, inplace=True)

pd.DataFrame(data=data).to_csv('contacts_with_notes.csv',
                               index=False, encoding='utf8')
