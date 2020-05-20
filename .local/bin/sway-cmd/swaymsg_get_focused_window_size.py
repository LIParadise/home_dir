import json
import os

swayJsonStream = os.popen('swaymsg -t get_tree')
swayJson       = swayJsonStream.read()
swayJsonData   = json.loads ( swayJson )

def traverseSwayJson ( swayNode ):
  if ( swayNode['focused'] is True ):
    return [ \
        swayNode['id'], \
        swayNode['type'], \
        swayNode['rect']['x'], \
        swayNode['rect']['y'], \
        swayNode['rect']['width'], \
        swayNode['rect']['height'] + swayNode['deco_rect']['height'], \
        swayNode['fullscreen_mode'] ]
  elif ( swayNode['focused'] is False ):
    if 'floating_nodes' in swayNode:
      if len(swayNode['floating_nodes']) != 0:
        for floatNode in swayNode['floating_nodes']:
          ret = traverseSwayJson(floatNode);
          if len(ret) != 0:
            return ret
    if 'nodes' in swayNode:
      if len(swayNode['nodes']) != 0:
        for node in swayNode['nodes']:
          ret = traverseSwayJson(node);
          if len(ret) != 0:
            return ret
  return []

l = traverseSwayJson ( swayJsonData )
l.insert ( len(l), swayJsonData['rect']['width']  )
l.insert ( len(l), swayJsonData['rect']['height'] )
print('%s' % ' '.join(map(str, l)))
