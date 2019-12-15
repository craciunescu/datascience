################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL5                 #
#                               Grupo 4 - P5                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

# Imports
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import offsetbox
from sklearn import manifold, datasets, decomposition

################################################################################
#                               Data Plotting                                  #
################################################################################

# Load digits.
digits = datasets.load_digits(n_class=10)
X = digits.data
y = digits.target

# Plotting function.
def plot_MNIST(X, title=None):
   
    # Create ranges
    x_min = np.min(X, 0)
    x_max = np.max(X, 0)

    # Scale values to fit.
    X = (X - x_min) / (x_max - x_min)
    plt.figure(figsize= (10,10))
    ax = plt.subplot(111)

    for i in range(X.shape[0]):
        plt.text(
            X[i, 0], 
            X[i, 1], 
            str(digits.target[i]),
            color=plt.cm.Set1(y[i] / 10.),
            fontdict={'weight': 'bold', 'size': 9}) 
    
    ## Only print thumbnail with matplotlib > 1.0
    if hasattr(offsetbox, 'AnnotationBbox'):
        # Simply something big.
        shown_images = np.array([[1., 1.]])

        for i in range(digits.data.shape[0]):
            dist = np.sum((X[i] - shown_images) ** 2, 1)

            # Filter points that are too close.
            if np.min(dist) < 5e-3:
                continue
                
            show_images = np.r_[shown_images, [X[i]]]
            imagebox = offsetbox.AnnotationBbox(
                offsetbox.OffsetImage(
                    digits.images[i],
                    cmap = plt.cm.gray_r),
                X[i])

            ax.add_artist(imagebox)
    
    plt.xticks([]), plt.yticks([])
    
    if title is not None:
        plt.title(title)


################################################################################
#                             Data Visualization                               # 
################################################################################
print("Computing")
X_tsne = manifold.TSNE(n_components=2, init='pca').fit_transform(X)
plot_MNIST(X_tsne, "t-SNE embedding of the digits")
plt.show()
