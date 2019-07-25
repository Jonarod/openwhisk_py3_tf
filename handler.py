#
#
# main() will be invoked when you Run This Action.
#
# @param Cloud Functions actions accept a single parameter,
#        which must be a JSON object.
#
# @return which must be a JSON object.
#         It will be the output of this action.
#
#
import sys

def main(dict):
  if 'name' in dict:
    name = dict['name']
  else:
    name = 'stranger'
  greeting = 'Hello ' + name + '!'
  print(greeting)
  return {'greeting':greeting}