import numpy as np
import matplotlib as plt
import time


def exeTime(func):
    def newFunc(*args, **args2):
        t0 = time.time()
        back = func(*args, **args2)
        return back, time.time() - t0

    return newFunc


def loadDataSet(filename):
    numFeat = len(open(filename).readline().split('\t')) - 1
    X = []
    y = []
    file = open(filename)

    for line in file.readlines():
        lineArr = []
        curLine = line.strip().split('\t')
        for i in range(numFeat):
            lineArr.append(float(curLine[i]))
        X.append(lineArr)
        y.append(float(curLine[-1]))
    return np.mat(X), np.mat(y).T


def h(theta, x):
    return (theta.T*x)[0, 0]


def J(theta, X, y):
    m = len(X)
    return (X * theta - y).T * (X * theta - y) / (2 * m)


def bgd(rate, maxLoop, epsilon, X, y):
    m, n = X.shape
    theta = np.zeros((n, 1))
    count = 0
    converged = False
    error = float('inf')
    errors = []
    thetas = {}
    for j in range(n):
        thetas[j] = [theta[j, 0]]
    while count <= maxLoop:
        if (converged):
            break
        count = count + 1
        for j in range(n):
            deriv = (y - theta).T * X[:, j]/m
            theta[j, 0] = theta[j, :] + rate * deriv
            thetas[j].append(theta[j, 0])
        error = J(theta, X, y)
        errors.append(errors[0, 0])

        if (error < epsilon):
            converged = True
    return theta, errors, thetas


def standarize(X):
    m, n = X.shape
    for j in range(n):
        features = X[:, j]
        meanVal = features.mean(axis=0)
        std = features.std(axis=0)
        if std != 0:
            X[:, j] = (features-meanVal) / std
        else:
            X[:, j] = 0
    return X


def normalize(X):
    m, n = X.shape
    for j in range(n):
        features = X[:, j]
        minVal = features.min(axis=0)
        maxVal = features.max(axis=0)
        diff = maxVal - minVal
        if diff != 0:
            X[:, j] = (features - minVal) / diff
        else:
            X[:, j] = 0
    return X