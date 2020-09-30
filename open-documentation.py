#! /usr/bin/env python3

import os
from subprocess import run, call, PIPE


homeDir = os.environ['HOME']
docDir = '/'.join([homeDir, 'Doc'])

supportedExtensions = ['html', 'jpeg', 'jpg', 'png', 'pdf']

def promptDMenu(path):
    elems = list(filter(lambda p: os.path.isdir(path+'/'+p) or (os.path.splitext(p)[1][1:] in supportedExtensions), os.listdir(path)))
    p = run(['dmenu', '-l', '30'],
            stdout = PIPE,
            input='\n'.join(elems), encoding='utf-8')
    output = p.stdout.strip()
    if output == '':
        exit(0)
    if os.path.isdir(p := '/'.join([path, output])) :
        return promptDMenu(p)
    return '/'.join([path, output])

docFile = promptDMenu(docDir)
print(docFile)

{
    'html': lambda : call ([ 'surf', '-F', docFile]),
    'jpeg': lambda : call ([ 'eom', '-f', docFile ]),
    'jpg':  lambda : call ([ 'eom', '-f', docFile ]),
    'png':  lambda : call ([ 'eom', '-f', docFile ]),
    'pdf':  lambda : call ([ 'zathura', '--mode=fullscreen', docFile]),
}[os.path.splitext(docFile)[1][1:]]()
