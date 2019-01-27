from linear_regreesion import regression
from matplotlib import cm
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import numpy as np


if __name__ == "__main__":
    X, y = regression.loadDataSet('data/temperature.txt')
    print(X)
    print(y)
