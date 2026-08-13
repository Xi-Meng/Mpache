#! /usr/bin/python3
import pydot
import common

def vis_dot(path):
  graphs = pydot.graph_from_dot_file(path)
  graphs[0].write_svg(f"{'/'.join(path.split('/')[:-1])}/{path.split('/')[-1].split('.')[0]}.svg")

if __name__ == "__main__" :
  assert common.args.path
  vis_dot(common.args.path)