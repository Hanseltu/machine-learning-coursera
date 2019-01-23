import numpy as np
import time
import math

a = np.array([1, 2, 3, 4])

print(a)

a = np.random.rand(1000000)
b = np.random.rand(1000000)

tic = time.time()
c = np.dot(a, b)
toc = time.time()

print(c)
print("vectorized version :" + str(1000*(toc - tic)) + "ms")


c = 0
tic = time.time()
for i in range(1000000):
    c += a[i] * b[i]
toc = time.time()

print(c)
print("for loop: " + str(1000*(toc - tic)) + "ms")

n = 10
v = np.ones((n, 1))
u = np.zeros((n, 1))
for i in range(n):
    u[i] = math.exp(v[i])

A = np.array([[56.0, 0.0, 4.4, 68.0],
             [1.2, 104.0, 52.0, 8.0],
             [1.8, 135.0, 99.0, 0.9]])

print(A)

cal = A.sum(axis=0)
print(cal)

percentage = A/cal.reshape(1, 4)
print(percentage)

# broadcasting
a = np.array([[1, 2, 3], [4, 5, 6]])
b = a + [100, 200, 300]
print(b)

a = np.random.randn(5, 1)
print(a)

a = np.random.randn(1, 5)
print(a)

print(a.shape)
print(np.dot(a, a.T))

a = np.random.randn(2, 3) # a.shape = (2, 3)
print(a)
b = np.random.randn(2, 1) # b.shape = (2, 1)
print(b)
c = a + b
print(c)

a = np.random.randn(4, 3) # a.shape = (4, 3)
b = np.random.randn(3, 2) # b.shape = (3, 2)
c = a.dot(b)
print(c)