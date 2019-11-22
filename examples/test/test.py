import matplotlib.pyplot as plt
import cv2

for j in range(1, 4):
    img = cv2.imread('{}.png'.format(j))
    plt.subplot(1, 3, j)
    plt.imshow(img)
    plt.axis('off')
    plt.tight_layout()
plt.show()