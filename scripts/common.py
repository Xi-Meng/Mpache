import argparse
import glob
import os

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--path", help="Path to the proj/file", type=str, default=os.getenv("CM_PROJ_PATH"))
parser.add_argument("-d", "--device", help="GPU device ID", type=str , default="0")
parser.add_argument("-i", "--iteration", help="number of iterations to benchmark", type=int, default=5)
args = parser.parse_args()

assert args.path

apps = [i.split('.')[0].split('/')[-1] for i in glob.glob(args.path+"/src/*.hip")]

