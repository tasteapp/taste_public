import subprocess
import os
import re
path = os.path.join(os.environ['TASTE_PATH'], 'taste', 'pubspec.yaml')
with open(path, 'r') as fn:
    data = fn.read()
data = re.sub(r'(version: \d+\.\d+\.)(\d+)', lambda g: f'{g.group(1)}{int(g.group(2)) + 1}',  data, 1, re.MULTILINE)
with open(path, 'w') as fn:
    fn.write(data)